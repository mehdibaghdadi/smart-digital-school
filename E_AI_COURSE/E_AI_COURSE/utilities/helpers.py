# E_AI_COURSE/utilities/helpers.py

import re
import httpx

# ---------------------------------------------------
# 1. Génération Markdown à partir du JSON
# ---------------------------------------------------
def build_markdown_from_ai(ai_json: dict) -> str:
    md = []
    title = ai_json.get("title", "")
    if title:
        md.append(f"# {title}\n")

    summary = ai_json.get("summary", "")
    if summary:
        md.append(summary + "\n")

    modules = ai_json.get("modules", []) or []

    for i, m in enumerate(modules, start=1):
        md.append(f"## Module {i} — {m.get('title','')}\n")
        if m.get("description"):
            md.append(m["description"] + "\n")
        for j, lesson in enumerate(m.get("lessons", []) or [], start=1):
            md.append(f"### {j}. {lesson.get('summary','')}\n\n{lesson.get('content','')}\n")

    return "\n".join(md)

# ---------------------------------------------------
# 2. Génération de quiz à partir des modules
# ---------------------------------------------------
def synthesize_quiz_from_modules(ai_json: dict, questions_per_module: int = 3) -> dict:
    quizzes = []
    modules = ai_json.get("modules", []) or []

    for mi, m in enumerate(modules, start=1):
        q = {
            "module_index": mi,
            "module_title": m.get("title", ""),
            "questions": []
        }

        lessons = m.get("lessons", []) or []

        for qi in range(questions_per_module):
            lesson = lessons[qi % max(1, len(lessons))] if lessons else {"title": "Contenu"}

            q["questions"].append({
                "question": f"Posez une question sur : {lesson.get('title','')}",
                "type": "short_answer",
                "choices": ["(réponse attendue)"]
            })

        quizzes.append(q)

    return {"quizzes": quizzes}

# ---------------------------------------------------
# 3. Liste des modèles Ollama (API locale)
# ---------------------------------------------------
async def attempt_models_list(base_url: str):
    """
    Tente plusieurs endpoints d’Ollama pour obtenir la liste
    des modèles installés. Retourne dict ou None.
    """
    candidates = [
        f"{base_url}/models",
        f"{base_url}/list",
        f"{base_url}/models/list",
        f"{base_url}/"
    ]

    async with httpx.AsyncClient(timeout=10.0) as client:
        for url in candidates:
            try:
                r = await client.get(url)
                if r.status_code == 200:
                    try:
                        return r.json()
                    except Exception:
                        return r.text
            except:
                continue

    return None
