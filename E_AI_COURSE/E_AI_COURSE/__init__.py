# E_AI_COURSE/__init__.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from E_AI_COURSE.routers import get_all_routers 
import os

def create_app() -> FastAPI:
    app = FastAPI(
        title="E_AI_COURSE - Local AI Course Generator",
        version="1.0.0"
    )

    # CORS
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_methods=["*"],
        allow_headers=["*"],
    )

    # config interne
    app.state.OLLAMA_URL = os.getenv("OLLAMA_URL", "http://localhost:11434/api/chat")
   
   # ---- root ----
    @app.get("/")
    async def root():
        return {"service": "E_AI_COURSE", "status": "ok"}
    # -------------
  
  # Montage des routers
    for router in get_all_routers():
        app.include_router(router,prefix="/api")

    return app
