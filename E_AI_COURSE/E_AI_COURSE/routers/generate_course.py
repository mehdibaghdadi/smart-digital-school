# E_AI_COURSE/routers/generate_course.py
import os
import logging
import uuid
import asyncio
import json
from typing import Dict, Any
import traceback
from fastapi import APIRouter, HTTPException, Request
from fastapi.responses import JSONResponse, StreamingResponse

from E_AI_COURSE.app.schemas import GenerateRequest, GenerateResponse
from E_AI_COURSE.app.ai import  call_ollama_stream_chunks
from E_AI_COURSE.utilities.helpers import (
    build_markdown_from_ai,
    synthesize_quiz_from_modules,
    attempt_models_list,
)
from E_AI_COURSE.settings import OLLAMA_API_BASE


logger = logging.getLogger(__name__)
router = APIRouter()

TASKS: Dict[str, Dict[str, Any]] = {}
TASKS_LOCK = asyncio.Lock()


@router.get("/health")
async def health():
    return {"status": "ok", "service": "E_AI_COURSE"}


@router.get("/models")
async def models(request: Request):
    base =  OLLAMA_API_BASE
    data = await attempt_models_list(base)
    if data is None:
        raise HTTPException(status_code=503, detail="Cannot contact local Ollama models endpoint")
    return JSONResponse({"models": data})


def _parse_ai_result(ai_result: Any, payload: Dict[str, Any]) -> Dict[str, Any]:
    import json, re
    if isinstance(ai_result, dict) and "raw" in ai_result:
        raw = ai_result.get("raw", "")
        try:
            return json.loads(raw)
        except Exception:
            m = re.search(r"(\{[\s\S]*\})", raw)
            if m:
                try:
                    return json.loads(m.group(1))
                except Exception:
                    pass
            return {
                "title": payload.get("title", "(titre)"),
                "summary": raw[:2000],
                "modules": [],
                "markdown": raw
            }
    if isinstance(ai_result, dict):
        return ai_result
    return {
        "title": payload.get("title", "(titre)"),
        "summary": "AI returned unexpected format.",
        "modules": [],
        "markdown": None
    }
# Streaming endpoint
@router.post("/generate/stream")
async def generate_stream(req: GenerateRequest, request: Request):
    """
    Streaming endpoint (SSE-like). Returns text/event-stream. The client should parse
    'data: ...' lines or read raw stream chunks. This endpoint keeps the POST body.
    """
    payload = req.dict()


    async def event_generator():
        try:
            async for chunk in call_ollama_stream_chunks(payload, timeout=300.0):
                # send SSE data event line(s); preserve newlines inside chunk
                for line in chunk.splitlines():
                    yield f"data: {line}\n"
                # blank line ends SSE event
                yield "\n"
        except Exception as exc:
            err = str(exc)
            yield f"event: error\ndata: {json.dumps({'error': err})}\n\n"

    return StreamingResponse(event_generator(), media_type="text/event-stream")


# Quiz generation endpoint
@router.post("/generate/quiz")
async def generate_quiz(req: GenerateRequest, request: Request):
    payload = req.dict()
    modules_data = payload.get("modules_data")
    if not modules_data:
        
        try:
            
            ai_result = await call_ollama_stream(payload, timeout=180.0)
        except Exception as exc:
            logger.exception("call_ollama_stream failed for quiz: %s", exc)
            raise HTTPException(status_code=503, detail="AI unavailable for quiz generation")
        ai_json = _parse_ai_result(ai_result, payload)
        modules_data = ai_json.get("modules", [])

    quiz = synthesize_quiz_from_modules({"modules": modules_data}, questions_per_module=3)
    return quiz


@router.post("/generate/markdown")
async def generate_markdown(req: GenerateRequest, request: Request):
    payload = req.dict()

    try:
     
        ai_result = await call_ollama_stream(payload, timeout=180.0)
    except Exception as exc:
        logger.exception("call_ollama_stream failed for markdown: %s", exc)
        md = build_markdown_from_ai({
            "course_title": payload.get("title"),
            "course_summary": "Fallback markdown: local engine unavailable",
            "modules": [{"module_title": "Module 1 (temp)", "module_description": "", "lessons": [{"lesson_title": "Leçon 1", "lesson_content": "Contenu temporaire."}]}]
        })
        return {"markdown": md, "note": "fallback_local_unavailable"}

    ai_json = _parse_ai_result(ai_result, payload)
    md = ai_json.get("markdown") or build_markdown_from_ai(ai_json)
    return {"markdown": md}



async def _run_generate_task(task_id: str, payload: Dict[str, Any], app):
    async with TASKS_LOCK:
        TASKS[task_id] = {"status": "running", "result": None, "error": None}
    try:
       
        ai_result = await call_ollama_stream(payload,timeout=300.0)
        ai_json = _parse_ai_result(ai_result, payload)
        if not ai_json.get("markdown"):
            ai_json["markdown"] = build_markdown_from_ai(ai_json)
        async with TASKS_LOCK:
            TASKS[task_id]["status"] = "finished"
            TASKS[task_id]["result"] = ai_json
    except Exception as exc:
        logger.exception("Async task failed %s: %s", task_id, exc)
        async with TASKS_LOCK:
            TASKS[task_id]["status"] = "failed"
            TASKS[task_id]["error"] = str(exc)


@router.post("/generate-async")
async def generate_async(req: GenerateRequest, request: Request):
    payload = req.dict()

    task_id = str(uuid.uuid4())
    async with TASKS_LOCK:
        TASKS[task_id] = {"status": "queued", "result": None, "error": None}

    asyncio.create_task(_run_generate_task(task_id, payload, request.app))
    return {"task_id": task_id, "status": "queued"}


@router.get("/task/{task_id}")
async def task_status(task_id: str):
    async with TASKS_LOCK:
        t = TASKS.get(task_id)
    if not t:
        raise HTTPException(status_code=404, detail="task not found")
    return {"task_id": task_id, "status": t["status"], "result": t.get("result"), "error": t.get("error")}
