# main.py

# Load .env variables
from dotenv import load_dotenv
load_dotenv()
from E_AI_SEARCH.search.search_router import router as search_router
import os
from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates



def create_app() -> FastAPI:
    app = FastAPI(
        title="E AI Search",
        version="1.0.0",
        description="Lightweight semantic search microservice powered by FAISS.",
    )

    # ----------------------------
    # Include API Routes
    # ----------------------------
    app.include_router(search_router, prefix="")

    # ----------------------------
    # UI (HTML templates + static files)
    # ----------------------------
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))

    # Setup Jinja2 template directory
    templates_dir = os.path.join(BASE_DIR, "templates")
    templates = Jinja2Templates(directory=templates_dir)

    # Setup static directory (js/css)
    static_dir = os.path.join(BASE_DIR, "static")
    if not os.path.exists(static_dir):
        os.makedirs(static_dir, exist_ok=True)
        os.makedirs(os.path.join(static_dir, "js"), exist_ok=True)
        os.makedirs(os.path.join(static_dir, "css"), exist_ok=True)

    # Mount the /static folder
    app.mount("/static", StaticFiles(directory=static_dir), name="static")

    # Mount the /files route (use absolute system paths)
    # Example: /files/mnt/data/build_index.py → opens the file
    app.mount("/files", StaticFiles(directory="/", html=False), name="files")

    # UI Page
    @app.get("/")
    async def ui_page(request: Request):
        return templates.TemplateResponse("search_ui.html", {"request": request})

    return app



