
import os
from dotenv import load_dotenv

load_dotenv()
# others : deepseek-v3.1:671b-cloud, qwen3.5:0.8b,qwen3:0.6b, gemma3:1b
OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "gemma3:1b")
# Base Ollama endpoints
OLLAMA_API_BASE = os.getenv("OLLAMA_API_BASE", "http://localhost:11434/api") 

OLLAMA_URL_DEFAULT = f"{OLLAMA_API_BASE}/chat"
OLLAMA_SECRECT_KEY = os.getenv("OLLAMA_SECRECT_KEY", "")

# Generation defaults tuned for Qwen3 stability
GENERATION_DEFAULTS = {
    "num_predict": int(os.getenv("NUM_PREDICT", 4096)),
    "temperature": float(os.getenv("TEMPERATURE", 0.3)),
    "top_p": float(os.getenv("TOP_P", 0.9)),
    "top_k": int(os.getenv("TOP_K", 40)),
    "repeat_penalty": float(os.getenv("REPEAT_PENALTY", 1.1)),
    "presence_penalty": float(os.getenv("PRESENCE_PENALTY", 0.3)),
    "num_ctx":   int(os.getenv("NUM_CTX", 8192)),
    "stream": True,
}
