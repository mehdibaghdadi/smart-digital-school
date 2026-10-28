from __future__ import annotations

import os
from pathlib import Path
import mysql.connector
import faiss
from dotenv import load_dotenv
load_dotenv()

from E_AI_SEARCH.ingest.ingest import IngestPayload, ingest_content
from E_AI_SEARCH.embeddings.embeddings import EMBED_DIM, save_index
from settings import  FAISS_FOLDER, FAISS_FILE,MYSQL_FAISS,MYSQL_HOST
from E_AI_SEARCH.utility.db import get_host_connection, get_faiss_meta_conn

_FAISS_FOLDER = Path(FAISS_FOLDER)



# -------------------------------------------------
# Reset index + metadata
# -------------------------------------------------
def reset_index():
    _FAISS_FOLDER.mkdir(parents=True, exist_ok=True)
    base = faiss.IndexFlatIP(EMBED_DIM)
    new_index = faiss.IndexIDMap(base)
    faiss.write_index(new_index, str(_FAISS_FOLDER / FAISS_FILE))

    conn = get_faiss_meta_conn()
    cur = conn.cursor()
    cur.execute("TRUNCATE TABLE content_vectors")
    conn.commit()
    cur.close()
    conn.close()

# -------------------------------------------------
# 1) Courses
# -------------------------------------------------
def fetch_all_courses():
    query = """
    SELECT id AS course_id,
           course_title,
           course_brief
    FROM course
    WHERE 1=1
    """
    with get_host_connection() as conn:
        cur = conn.cursor(dictionary=True)
        cur.execute(query)
        return cur.fetchall()

# -------------------------------------------------
# 2) Chapters
# -------------------------------------------------
def fetch_all_chapters():
    query = """
    SELECT ch.id AS chapter_id,
           ch.course_id,
           ch.chapter_title
    FROM course_chapter ch
    WHERE 1=1
    """
    with get_host_connection() as conn:
        cur = conn.cursor(dictionary=True)
        cur.execute(query)
        return cur.fetchall()

# -------------------------------------------------
# 3) Contents
# -------------------------------------------------
def fetch_all_contents():
    query = """
     SELECT 
         c.id AS content_id,
         c.course_chapter_id,
         ch.course_id,
         c.content_type_id,
         c.content_url,
         c.content_text,
         c.content_brief
     FROM course_chapter_content c
     JOIN course_chapter ch ON ch.id = c.course_chapter_id
     JOIN course cc ON cc.id = ch.course_id
     WHERE 1 = 1
    """
    with get_host_connection() as conn:
        cur = conn.cursor(dictionary=True)
        cur.execute(query)
        return cur.fetchall()

# -------------------------------------------------
# REBUILD (INGEST + BUILD FAISS)
# -------------------------------------------------
def rebuild_index():
    print("Resetting index and metadata...")
    reset_index()

    # ----------------------------
    # Phase 1: COURSES
    # ----------------------------
    courses = fetch_all_courses()
    print(f"Found {len(courses)} courses to index.")

    for r in courses:
        payload = IngestPayload(
            content_id=f"course-{r['course_id']}",
            title=(r.get("course_title") or ""),
            description=(r.get("course_brief") or ""),
            url=None,
            type="course"
        )
        try:
            ingest_content(payload)
            print("Indexed course:", payload.content_id)
        except Exception as e:
            print("Failed to index course", payload.content_id, ":", e)

    # ----------------------------
    # Phase 2: CHAPTERS
    # ----------------------------
    chapters = fetch_all_chapters()
    print(f"Found {len(chapters)} chapters to index.")

    for r in chapters:
        payload = IngestPayload(
            content_id=f"chapter-{r['chapter_id']}",
            title=(r.get("chapter_title") or ""),
            description="",
            url=None,
            type="chapter"
        )
        try:
            ingest_content(payload)
            print("Indexed chapter:", payload.content_id)
        except Exception as e:
            print("Failed to index chapter", payload.content_id, ":", e)

    # ----------------------------
    # Phase 3: CONTENTS
    # ----------------------------
    contents = fetch_all_contents()
    print(f"Found {len(contents)} contents to index.")

    for r in contents:
        payload = IngestPayload(
            content_id=str(r["content_id"]),
            title=(r.get("content_brief") or ""),
            description=(r.get("content_text") or ""),
            url=r.get("content_url"),
            type="text"
        )
        try:
            ingest_content(payload)
            print("Indexed content:", payload.content_id)
        except Exception as e:
            print("Failed to index content", payload.content_id, ":", e)

    # Final FAISS save
    save_index()
    print("Rebuild complete.")

# -------------------------------------------------
if __name__ == "__main__":
    rebuild_index()
