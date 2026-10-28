# E_AI_COURSE/app/ai.py
import json
import re
import httpx
import logging, asyncio
from typing import Any, Dict, Optional, AsyncGenerator
from E_AI_COURSE.settings import OLLAMA_MODEL, GENERATION_DEFAULTS, OLLAMA_URL_DEFAULT,OLLAMA_SECRECT_KEY
from E_AI_COURSE.prompts.course_generator import COURSE_GENERATOR_TEMPLATE

num_predict = GENERATION_DEFAULTS["num_predict"]
temperature = GENERATION_DEFAULTS["temperature"]
top_p = GENERATION_DEFAULTS["top_p"]
top_k = GENERATION_DEFAULTS["top_k"]
repeat_penalty = GENERATION_DEFAULTS["repeat_penalty"]
presence_penalty = GENERATION_DEFAULTS["presence_penalty"]
num_ctx = GENERATION_DEFAULTS["num_ctx"]
stream = GENERATION_DEFAULTS["stream"]

logger = logging.getLogger(__name__)


def _build_request_body(payload: Dict[str, Any]) -> Dict[str, Any]:
    prompt = (
        COURSE_GENERATOR_TEMPLATE.replace("<<title>>", payload.get("title", ""))
        .replace("<<level>>", payload.get("level", ""))
        .replace("<<audience>>", payload.get("audience", ""))
        .replace("<<language>>", payload.get("language", "fr"))
        .replace("<<duration>>", payload.get("duration", "8 heures"))
        .replace("<<modules>>", str(payload.get("modules", 8)))
        .replace("<<style>>", payload.get("style", ""))
        .replace("<<include_quiz>>", str(payload.get("include_quiz", False)))
        .replace("<<description>>", payload.get("description", ""))
    )

    body = {
        "model": OLLAMA_MODEL,
        "format": "json",
        "messages": [
            {"role": "system", "content": "You are a JSON-only generator."},
            {"role": "user", "content": prompt},
        ],
        "stream": stream,
        "options": {  # <--- Regroupe les paramètres ici
            "num_predict": num_predict,
            "temperature": temperature,
            "top_p": top_p,
            "top_k": top_k,
            "repeat_penalty": repeat_penalty,
            "presence_penalty": presence_penalty,
            "num_ctx": num_ctx,
        }
    }
    return body

async def call_ollama_stream_chunks(
    payload: Dict[str, Any], timeout: float = 600.0  # Augmenté car la réflexion peut être longue
) -> AsyncGenerator[str, None]:
    """
    Générateur asynchrone qui envoie les morceaux de texte (chunks) en temps réel.
    Gère les erreurs de format et nettoie les balises parasites.
    """
    url = OLLAMA_URL_DEFAULT
    # Préparation des headers avec votre clé secrète
    headers={'Authorization': f'Bearer {OLLAMA_SECRECT_KEY}'}

    body = _build_request_body(payload)

    # On utilise timeout=None pour la lecture car l'IA peut mettre du temps entre deux mots
    async with httpx.AsyncClient(timeout=httpx.Timeout(timeout, read=None)) as client:
        try:
            async with client.stream("POST", url, json=body, headers=headers) as resp:
                if resp.status_code >= 400:
                    detail = await resp.aread()
                    raise RuntimeError(f"Ollama error {resp.status_code}: {detail[:200]}")

                async for line in resp.aiter_lines():
                    if not line:
                        continue
                    
                    try:
                        # Ollama envoie un objet JSON par ligne
                        data = json.loads(line)
                        
                        # Récupération du contenu selon le format de réponse d'Ollama
                        # message.content est la norme pour l'API /chat
                        chunk = data.get("message", {}).get("content", "")
                        
                        if chunk:
                            # NETTOYAGE : Évite d'envoyer les balises ```json au client UI
                            # Cela évite que l'UI affiche du texte de code inutile
                            clean_chunk = chunk.replace("```json", "").replace("```", "")
                            if clean_chunk.strip() or chunk in [" ", "\n", "{", "}"]:
                                yield clean_chunk

                        if data.get("done"):
                            logger.info("Génération Ollama terminée avec succès.")
                            break

                    except json.JSONDecodeError:
                        # Si ce n'est pas du JSON, c'est peut-être un log ou du texte brut
                        continue
                        
        except httpx.ReadError as e:
            logger.error(f"Erreur de lecture du flux : {e}")
            raise
        except Exception as e:
            logger.error(f"Erreur inattendue dans le stream : {e}")
            raise

async def call_ollama_stream_chunks2(
    payload: Dict[str, Any], timeout: float = 300.0
) -> AsyncGenerator[str, None]:
    """
    Async generator that yields progressive text chunks (strings) from Ollama as they arrive.
    Yields raw text fragments that you can forward to a client (SSE/WebSocket/stream).
    """
    url = OLLAMA_URL_DEFAULT
    body = _build_request_body(payload)

    async with httpx.AsyncClient(timeout=timeout) as client:
        async with client.stream("POST", url, json=body) as resp:
            if resp.status_code >= 400:
                detail = await resp.aread()
                raise RuntimeError(
                    f"Ollama returned status {resp.status_code}: {detail[:200]}"
                )
            async for line in resp.aiter_lines():
                if not line:
                    continue
                for raw in line.splitlines():
                    raw = raw.strip()
                    if not raw:
                        continue
                    try:
                        obj = json.loads(raw)
                    except Exception:
                        continue
                    msg = obj.get("message") or obj.get("output") or {}
                    if isinstance(msg, dict):
                        part = msg.get("content", "") or ""
                    elif isinstance(msg, str):
                        part = msg
                    else:
                        part = ""
                    if part:
                        yield part
                    if obj.get("done") or obj.get("done_reason"):
                        return

