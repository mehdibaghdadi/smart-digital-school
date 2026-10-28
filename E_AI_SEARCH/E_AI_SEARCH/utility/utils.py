# utils.py
from __future__ import annotations

import io
from pathlib import Path
from typing import Iterable, List

import requests
from pypdf import PdfReader
from settings import OPENAI_API_KEY


def extract_pdf_text_from_path(url_or_path: str) -> str:
    """
    Supports local filesystem paths or remote URLs.
    """
    if url_or_path.startswith("http://") or url_or_path.startswith("https://"):
        response = requests.get(url_or_path, timeout=30)
        response.raise_for_status()
        pdf_file = io.BytesIO(response.content)
    else:
        pdf_file = open(Path(url_or_path), "rb")

    with pdf_file:
        reader = PdfReader(pdf_file)
        texts = [page.extract_text() or "" for page in reader.pages]
    return "\n".join(texts)


def simple_chunk_text(text: str, max_chars: int = 1000, overlap: int = 100) -> List[str]:
    if not text:
        return []
    text = text.strip()
    if len(text) <= max_chars:
        return [text]

    chunks: List[str] = []
    start = 0
    while start < len(text):
        end = start + max_chars
        chunk = text[start:end]
        chunks.append(chunk)
        start = end - overlap
        if start < 0:
            start = 0
    return chunks


def transcribe_media_with_openai(url: str, media_type: str | None = None) -> str:
    """
    Transcrit audio/vidéo en utilisant Whisper API (OpenAI).
    """
    api_key = OPENAI_API_KEY
    if not api_key:
        return f"[Transcription error] Missing OPENAI_API_KEY."

    try:
        # Télécharger le fichier
        audio_data = requests.get(url, timeout=60).content

        # Appel Whisper API
        resp = requests.post(
            "https://api.openai.com/v1/audio/transcriptions",
            headers={"Authorization": f"Bearer {api_key}"},
            files={"file": ("media", audio_data)},
            data={"model": "whisper-1"},
        )

        text = resp.json().get("text", "")
        if not text:
            return f"[Transcription empty] Could not transcribe file at {url}"

        return text

    except Exception as e:
        return f"[Transcription failed] {e}"

