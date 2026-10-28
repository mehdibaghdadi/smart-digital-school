# clean_snippets.py
# Nettoie les snippets contenant data:image...;base64,... ou longues suites base64
# Usage: python clean_snippets.py

import re
import mysql.connector
import os
from dotenv import load_dotenv
load_dotenv()
from settings import MYSQL_FAISS
from E_AI_SEARCH.utility.db import  get_faiss_meta_conn 

BATCH = 500

# regex pour data:image base64 (multiligne possible)
RE_DATAURI = re.compile(r"data:image\/[^;]+;base64,[A-Za-z0-9+/=\s]+", flags=re.IGNORECASE)
# regex pour longues séquences base64-like (>150 chars)
RE_LONGBASE64 = re.compile(r"[A-Za-z0-9+/]{150,}={0,2}")

def clean_snippet(text: str) -> str:
    if not text:
        return text
    s = text
    # remove data-uri blobs
    s = RE_DATAURI.sub("[IMAGE_REMOVED]", s)
    # replace other very long base64-like runs
    s = RE_LONGBASE64.sub("[IMAGE_REMOVED]", s)
    # collapse excessive whitespace/newlines
    s = re.sub(r"\s{2,}", " ", s).strip()
    # truncate to 800 chars (same policy as ingest.update_snippets)
    if len(s) > 800:
        s = s[:800]
    return s


def main():
    conn = get_faiss_meta_conn()
    cur = conn.cursor(dictionary=True)

    # select candidate rows: either suspicious long or containing 'data:'
    # uses REGEXP for long base64 sequences if supported; fallback to LENGTH check
    select_sql = """
    SELECT vector_id, content_id, chunk_index, snippet
    FROM content_vectors
    WHERE (snippet LIKE '%data:%')
       OR (LENGTH(snippet) > 800)
       OR (snippet REGEXP '[A-Za-z0-9+/]{150}')
    """
    cur.execute(select_sql)
    rows = cur.fetchall()
    total = len(rows)
    print(f"Found {total} candidate rows to inspect/update.")

    if total == 0:
        cur.close()
        conn.close()
        return

    updated = 0
    i = 0
    try:
        for row in rows:
            i += 1
            vid = row["vector_id"]
            orig = row["snippet"] or ""
            cleaned = clean_snippet(orig)
            if cleaned != orig:
                # update
                cur.execute("UPDATE content_vectors SET snippet=%s WHERE vector_id=%s", (cleaned, int(vid)))
                updated += 1
            if i % 100 == 0:
                conn.commit()
                print(f"Processed {i}/{total} rows; updated so far: {updated}")
        conn.commit()
        print(f"Done. Total processed: {total}. Updated: {updated}")
    except Exception as e:
        conn.rollback()
        print("Error, rolled back. Exception:", e)
    finally:
        cur.close()
        conn.close()

if __name__ == "__main__":
    main()
