# E_AI_COURSE/routers/model_status.py
import subprocess
from fastapi import APIRouter

router = APIRouter()

@router.get("/model/status")
async def model_status():
    """
    Vérifie si un modèle Ollama est chargé en RAM via `ollama ps`.
    Retourne les modèles chargés, leur état, et la sortie brute.
    """
    try:
        result = subprocess.run(
            ["ollama", "ps"],
            capture_output=True,
            text=True
        )
        output = result.stdout.strip()

        if not output or "No models loaded" in output:
            return {
                "status": "unloaded",
                "loaded_models": [],
                "raw_output": output
            }

        lines = output.splitlines()
        models = []

        # Skip header line
        for line in lines[1:]:
            parts = line.split()
            if len(parts) >= 3:
                models.append({
                    "model": parts[0],
                    "size": parts[1],
                    "status": parts[2]
                })

        return {
            "status": "loaded" if models else "unloaded",
            "loaded_models": models,
            "raw_output": output
        }

    except Exception as exc:
        return {
            "status": "unknown",
            "error": str(exc)
        }
