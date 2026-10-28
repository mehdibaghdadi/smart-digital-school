# ingest.py
from __future__ import annotations
from bs4 import BeautifulSoup
import re
import json
from pathlib import Path
from typing import List, Tuple, Dict, Any, Optional
import os

from pydantic import BaseModel, Field
import mysql.connector
import numpy as np

from E_AI_SEARCH.embeddings.embeddings import embed_texts, add_vectors_with_ids, load_index, save_index
from E_AI_SEARCH.utility.utils import extract_pdf_text_from_path, simple_chunk_text, transcribe_media_with_openai
from E_AI_SEARCH.utility.db import  get_faiss_meta_conn 
from settings import MYSQL_FAISS


class IngestPayload(BaseModel):
    content_id: str = Field(..., description="Unique identifier for the content")
    title: str = ""
    description: str = ""
    url: Optional[str] = None
    type: str = Field("text", description="content type: pdf, text, audio, video, etc.")

def build_contextual_text(payload: IngestPayload) -> str:
    """
    Construit le texte final à indexer en ajoutant le contexte : course title/brief & chapter title.
    """
    parts: List[str] = []

    if payload.title:
        parts.append(f"{payload.title}\n")   

    # join with double newlines to keep sections clear
    return "\n\n".join(parts).strip()

# extract_text_from_payload 

DATA_URI_RE = re.compile(r"^data:image/[^;]+;base64,", flags=re.I)

def _sanitize_html_remove_data_images(html: str) -> str:
    """
    Remove inline base64 images and replace with a short token.
    Keep alt text if present: replace <img> by "[IMAGE: alt text]" or "[IMAGE]".
    Returns plain text extracted from HTML.
    """
    if not html:
        return ""

    # parse HTML
    soup = BeautifulSoup(html, "html.parser")

    # find img tags
    for img in soup.find_all("img"):
        src = img.get("src", "") or ""
        alt = (img.get("alt") or "").strip()
        if src.startswith("data:") or DATA_URI_RE.match(src):
            token = "[IMAGE"
            if alt:
                token += ": " + alt
            token += "]"
            img.replace_with(token)
        else:
            # external image url -> keep alt or a short token with url optionally
            if alt:
                img.replace_with("[IMAGE: " + alt + "]")
            else:
                img.replace_with("[IMAGE_URL]")

    # remove script/style tags to avoid noise
    for bad in soup(["script", "style"]):
        bad.decompose()

    text = soup.get_text(separator="\n")
    # collapse multiple blank lines
    text = re.sub(r"\n\s*\n+", "\n\n", text).strip()
    return text


def extract_text_from_payload(payload: IngestPayload) -> str:
    """
    Sanitize HTML content_text by removing data:image base64 blobs and
    extracting meaningful text to be chunked and embedded.
    """
    context = build_contextual_text(payload)
    content_body = ""

    # priority: explicit text provided in payload
    if payload.description:
        # if text could be HTML, sanitize similarly
        content_body = _sanitize_html_remove_data_images(payload.description)
    else:
        # prefer HTML content_text if available via payload.url or url points to file
        # existing code path: pdf, audio/video, url fallback
        content_type = (payload.type or "").lower()
        if content_type == "pdf" and payload.url:
            try:
                pdf_text = extract_pdf_text_from_path(payload.url)
                content_body = pdf_text
            except Exception:
                content_body = f"\n {payload.url}"
        elif content_type in {"audio", "video"} and payload.url:
            transcript = transcribe_media_with_openai(payload.url, payload.type)
            content_body = transcript
        elif payload.url:
            # If URL is a local path to an HTML file or an HTML string was stored in content_text,
            # we fallback to using url as a marker. The ingest flow for build_index.py uses the DB text fields.
            content_body = "" # f"[EXTERNAL_RESOURCE] {payload.url}"
        else:
            # fallback to description or empty
            content_body = (payload.description or "") or ""

    # If content_body may contain HTML (e.g., content_text column), sanitize it now
    content_body = _sanitize_html_remove_data_images(content_body)

    if context:
        final = f"{context}\n\n{content_body}"
    else:
        final = content_body

    return final.strip()



def reserve_vector_rows(conn, content_id: str, n_chunks: int) -> List[int]:
    """
    Reserve rows in content_vectors and return vector_ids matching chunk_index order.
    content_id is a string (could be numeric string or 'course-1' etc).
    """
    cur = conn.cursor()
    rows = [(content_id, i, "placeholder") for i in range(n_chunks)]
    insert_sql = "INSERT INTO content_vectors (content_id, chunk_index, snippet) VALUES (%s, %s, %s)"
    cur.executemany(insert_sql, rows)
    conn.commit()
    # retrieve vector_ids for these chunk indices
    placeholders = ",".join(["%s"] * n_chunks)
    select_sql = f"SELECT vector_id, chunk_index FROM content_vectors WHERE content_id=%s AND chunk_index IN ({placeholders})"
    params = [content_id] + list(range(n_chunks))
    cur.execute(select_sql, tuple(params))
    fetched = cur.fetchall()
    cur.close()
    mapping = {row[1]: int(row[0]) for row in fetched}
    ids = [mapping[i] for i in range(n_chunks)]
    return ids


def update_snippets(conn, vector_ids: List[int], chunks: List[str]) -> None:
    cur = conn.cursor()
    update_sql = "UPDATE content_vectors SET snippet=%s WHERE vector_id=%s"
    for vid, chunk in zip(vector_ids, chunks):
        cur.execute(update_sql, (chunk[:800], int(vid)))
    conn.commit()
    cur.close()


def ingest_content(payload: IngestPayload) -> Dict[str, Any]:
    """
    Full ingestion flow:
    - build contextual text
    - extract (pdf/transcript) and chunk
    - reserve vector rows
    - compute embeddings
    - add_with_ids to FAISS
    - update snippets in DB
    """
    # ensure numeric content_id for DB
    try:
        content_id_db = str(payload.content_id)
    except Exception:
        raise ValueError("content_id must be convertible to str")

    text = extract_text_from_payload(payload)
    chunks = simple_chunk_text(text, max_chars=1000, overlap=100)
    if not chunks:
        return {"status": "no_chunks", "content_id": payload.content_id}

    n = len(chunks)

    conn = get_faiss_meta_conn()
    try:
        vector_ids = reserve_vector_rows(conn, content_id_db, n)
    except Exception as e:
        conn.rollback()
        conn.close()
        raise

    # embed
    vectors = embed_texts(chunks)  # np.ndarray (n, dim)
    # add to FAISS with ids (atomic on FAISS side)
    try:
        add_vectors_with_ids(vectors, vector_ids)
    except Exception as e:
        # If FAISS add fails, attempt to cleanup placeholders in DB
        try:
            cur = conn.cursor()
            delete_sql = "DELETE FROM content_vectors WHERE content_id=%s AND chunk_index IN (%s)" % (
                "%s",
                ",".join(["%s"] * n),
            )
            params = [content_id_db] + list(range(n))
            # We prefer deleting by content_id to remove placeholders
            cur.execute("DELETE FROM content_vectors WHERE content_id=%s", (content_id_db,))
            conn.commit()
            cur.close()
        except Exception:
            pass
        conn.close()
        raise

    # update snippets in DB (in a new connection)
    conn2 = get_faiss_meta_conn()
    try:
        update_snippets(conn2, vector_ids, chunks)
    finally:
        conn2.close()

    return {"status": "indexed", "content_id": payload.content_id, "vectors": vector_ids}
