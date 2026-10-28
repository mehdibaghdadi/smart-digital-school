# export_vectors.py
"""
Export vectors.npy and ids.npy from MySQL table `content_vectors`.

Writes REAL .npy files (with correct NumPy header) using open_memmap.
"""

from pathlib import Path
import argparse
import sys
import time
import mysql.connector
import numpy as np
from numpy.lib.format import open_memmap

# --- Imports ---
try:
    from E_AI_SEARCH.embeddings.embeddings import embed_texts, EMBED_DIM
except Exception:
    from embeddings.embeddings import embed_texts, EMBED_DIM

from settings import VECTORS_PATH, IDS_PATH, MYSQL_FAISS

DEFAULT_BATCH = 512

def get_conn():
    return mysql.connector.connect(
        host=MYSQL_FAISS["host"],
        port=MYSQL_FAISS["port"],
        user=MYSQL_FAISS["user"],
        password=MYSQL_FAISS["password"],
        database=MYSQL_FAISS["database"],
    )

def count_rows(conn, where_clause=""):
    cur = conn.cursor()
    sql = "SELECT COUNT(*) FROM content_vectors"
    if where_clause:
        sql += " WHERE " + where_clause
    cur.execute(sql)
    cnt = cur.fetchone()[0]
    cur.close()
    return int(cnt)

def iterate_rows(conn, batch=512, where_clause=""):
    cur = conn.cursor(dictionary=True)
    sql = "SELECT vector_id, snippet FROM content_vectors"
    if where_clause:
        sql += " WHERE " + where_clause
    sql += " ORDER BY vector_id ASC"
    cur.execute(sql)

    while True:
        rows = cur.fetchmany(batch)
        if not rows:
            break
        yield rows

    cur.close()

def main(batch_size, where_clause):
    conn = get_conn()
    try:
        total = count_rows(conn, where_clause)
        print(f"Total rows to export: {total}")
        if total == 0:
            print("No rows found. Exiting.")
            return

        VECTORS_PATH.parent.mkdir(parents=True, exist_ok=True)

        dim = int(EMBED_DIM)
        print(f"Embedding dim detected: {dim}")

        # --- Correct NumPy .npy creation with header ---
        vectors_mm = open_memmap(
            str(VECTORS_PATH), mode="w+", dtype="float32", shape=(total, dim)
        )
        ids_mm = open_memmap(
            str(IDS_PATH), mode="w+", dtype="int64", shape=(total,)
        )

        offset = 0
        t0 = time.time()

        for rows in iterate_rows(conn, batch=batch_size, where_clause=where_clause):
            snippets = [r["snippet"] or "" for r in rows]
            ids = [int(r["vector_id"]) for r in rows]

            embs = embed_texts(snippets)
            if embs.shape[1] != dim:
                raise RuntimeError(
                    f"embed dimension mismatch: expected {dim}, got {embs.shape[1]}"
                )

            n = len(snippets)
            vectors_mm[offset:offset+n, :] = embs
            ids_mm[offset:offset+n] = np.array(ids, dtype="int64")

            offset += n
            elapsed = time.time() - t0
            print(f"Processed {offset}/{total} ({offset/total*100:.1f}%)  {elapsed:.1f}s", end="\r")

        vectors_mm.flush()
        ids_mm.flush()

        print("\nExport finished.")
        print(f"Saved vectors to: {VECTORS_PATH}")
        print(f"Saved ids to:     {IDS_PATH}")

    finally:
        conn.close()

if __name__ == "__main__":
    p = argparse.ArgumentParser(description="Export vectors.npy and ids.npy from MySQL content_vectors")
    p.add_argument("--batch", type=int, default=DEFAULT_BATCH, help="DB batch size")
    p.add_argument("--where", type=str, default="", help="Optional SQL WHERE clause")
    args = p.parse_args()
    main(args.batch, args.where)
