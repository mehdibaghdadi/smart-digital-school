import os
import subprocess
import re
from typing import Optional, List, Dict, Any


from fastapi import APIRouter, BackgroundTasks, Depends, Header, HTTPException
from pydantic import BaseModel, Field

from E_AI_SEARCH.ingest.ingest import IngestPayload, ingest_content
from E_AI_SEARCH.embeddings.embeddings import embed_texts, load_index, save_index, remove_ids as faiss_remove_ids
import numpy as np
from rank_bm25 import BM25Okapi
from settings import  API_KEY, BUILD_INDEX_SCRIPT,STOPWORDS
from E_AI_SEARCH.utility.db import  get_faiss_meta_conn 


router = APIRouter()

def check_api_key(x_api_key: Optional[str] = Header(None)):
    if x_api_key != API_KEY:
        pass
        # raise HTTPException(status_code=403, detail="Forbidden")


# ---------------------------
#        INGEST ENDPOINT
# ---------------------------
class IngestRequest(BaseModel):
    content_id: int
    
    title: Optional[str] = ""
    description: Optional[str] = ""
    url: Optional[str] = None
    type: Optional[str] = "text"


@router.post("/ingest", dependencies=[Depends(check_api_key)], tags=["ingest"])
async def ingest_endpoint(payload: IngestRequest, background_tasks: BackgroundTasks):
    p = IngestPayload(
        content_id=str(payload.content_id),
        title=payload.title or "",
        description=payload.description or "",
        url=payload.url,
        type=payload.type or "text"     
    )
    background_tasks.add_task(ingest_content, p)
    return {"status": "accepted", "content_id": payload.content_id}


# ---------------------------
#        SEARCH ENDPOINT
# ---------------------------
class SearchRequest(BaseModel):
    query: str = Field(..., description="Search query text")
    k: int = Field(5, description="Number of results to return", ge=1, le=50)


def highlight(snippet: str, query: str) -> str:
    """Robust server-side highlighter. Removes stopwords from tokens highlight."""
    if not snippet or not query:
        return snippet or ""

    s = snippet
    q = query.strip()
    if not q:
        return s

    try:
        # 1) full phrase highlight
        phrase_pat = re.escape(q)
        s = re.sub(r"(?i)({})".format(phrase_pat), r"<mark>\1</mark>", s)

        # 2) token highlight (filter short and stopwords)
        tokens = [t for t in re.split(r"\s+", q) if len(t) > 2 and t.lower() not in STOPWORDS]
        tokens = sorted(list(dict.fromkeys(tokens)), key=lambda x: -len(x))
        for tok in tokens:
            tok_pat = re.escape(tok)
            s = re.sub(r"(?i)({})".format(tok_pat), r"<mark>\1</mark>", s)
    except Exception:
        return snippet

    return s

def _tokenize(text: str) -> List[str]:
    if not text:
        return []
    toks = re.findall(r"\w+", text.lower())
    return [t for t in toks if len(t) > 2 and t not in STOPWORDS]

@router.post("/search", tags=["search"])
async def search_endpoint(payload: SearchRequest, x_api_key: Optional[str] = Header(None)):

    index = load_index()
    if index.ntotal == 0:
        return {"results": []}

    # ============================================================
    # 1) EMBEDDING
    # ============================================================
    vector = embed_texts([payload.query])

    # récupérer beaucoup de candidats FAISS pour maximiser le rappel
    topk = max(30, payload.k *8)
    #topk = max(100, payload.k * 20)
    scores, ids = index.search(vector, topk)

    # cutoff dynamique FAISS : si FAISS renvoie des scores trop bas → on ignore
    global_faiss_max = max(scores[0]) if len(scores[0]) else 0
    if global_faiss_max <= 0:
        return {"results": []}

    faiss_cutoff = global_faiss_max * 0.15  # 15% du meilleur score
    # en dessous : bruit certain

    conn = get_faiss_meta_conn()
    cur = conn.cursor(dictionary=True)

    candidates = []

    # ============================================================
    # 2) EXTRACTION DES CANDIDATS + FILTRE FAISS
    # ============================================================
    for score, vid in zip(scores[0], ids[0]):

        if int(vid) == -1:
            continue

        # éliminer FAISS scores trop faibles
        if score <= 0 or score < faiss_cutoff:
            continue

        cur.execute(
            "SELECT content_id, chunk_index, snippet FROM content_vectors WHERE vector_id=%s",
            (int(vid),)
        )
        row = cur.fetchone()
        if not row:
            continue

        cid_str = str(row["content_id"])

        if cid_str.startswith("course-"):
            ctype = "course"
            oid = cid_str.split("course-", 1)[1]
        elif cid_str.startswith("chapter-"):
            ctype = "chapter"
            oid = cid_str.split("chapter-", 1)[1]
        else:
            ctype = "content"
            try:
                oid = int(cid_str)
            except:
                oid = cid_str

        candidates.append({
            "vector_id": int(vid),
            "faiss_score": float(score),
            "snippet": (row.get("snippet") or ""),
            "content_id": cid_str,
            "content_type": ctype,
            "object_id": str(oid),
            "chunk": int(row["chunk_index"])
        })

    if not candidates:
        cur.close()
        conn.close()
        return {"results": []}

    # ============================================================
    # 3) BM25 — RERANK LEXICAL OPTIMISÉ
    # ============================================================

    docs = [c["snippet"] for c in candidates]
    tokenized_docs = [_tokenize(d) for d in docs]
    bm25 = BM25Okapi(tokenized_docs)

    qtokens = _tokenize(payload.query)
    bm25_raw = np.array(bm25.get_scores(qtokens), dtype=float)

    faiss_raw = np.array([c["faiss_score"] for c in candidates], dtype=float)

    def _norm(x: np.ndarray):
        if x.size == 0 or np.allclose(x.max(), x.min()):
            return np.zeros_like(x)
        return (x - x.min()) / (x.max() - x.min())

    faiss_norm = _norm(faiss_raw)
    bm25_norm = _norm(bm25_raw)

    # pondération dynamique
    # requêtes très courtes → plus de BM25
    # requêtes longues → plus de FAISS
    qlen = len(qtokens)
    if qlen <= 1:
        alpha = 0.30; beta = 0.70
    elif qlen == 2:
        alpha = 0.35; beta = 0.65
    else:
        alpha = 0.45; beta = 0.55

    combined = alpha * faiss_norm + beta * bm25_norm

    for i, c in enumerate(candidates):
        c["bm25_score"] = float(bm25_raw[i])
        c["combined_score"] = float(combined[i])

    # ============================================================
    # 4) FILTRES ANTI-BRUIT (version stricte)
    # ============================================================

    for c in candidates:
        # nouveau calcul des hit lexicaux + pénalités plus permissives
        snippet = (c["snippet"] or "").strip()
        sn_lower = snippet.lower()

        # tokens de la query déjà calculés : qtokens
        words = re.findall(r"\w+", sn_lower)
        wc = len(words)

        # token_hits : accepte exact, substring, et préfix match
        token_hits = 0
        for t in qtokens:
            if not t:
                continue
            # exact token anywhere
            if t in sn_lower:
                token_hits += 1
                continue
            # any word startswith token (jack -> jackson)
            if any(w.startswith(t) for w in words):
                token_hits += 1
                continue
            # substring inside any word
            if any(t in w for w in words):
                token_hits += 1

        # proportion de caractères non-alphanumériques (bruit visuel)
        non_alpha = 1.0
        if len(snippet) > 0:
            alpha_chars = len(re.findall(r"[A-Za-zÀ-ÿ0-9]", snippet))
            non_alpha = 1 - (alpha_chars / max(1, len(snippet)))

        penalty = 0.0

        # si pas de hit exactement, pénalité réduite (moins agressive)
        if token_hits == 0:
            penalty += 0.60   # was 0.6

        # trop court ou pauvre
        if wc <= 2:
            penalty += 0.15   # was 0.3 for wc<=3

        # bruit visuel
        if non_alpha > 0.30:
            penalty += 0.25   # slightly relaxed

        # réduire l'impact de type non-content mais pas supprimer totalement
        if c["content_type"] != "content":
            penalty += 0.10   # was 0.15

        # bonus: si FAISS donne un score élevé, réduire la pénalité automatiquement
        # (conserver candidats semantiques forts)
        faiss_threshold_for_override = 0.85 * global_faiss_max
        if c["faiss_score"] >= faiss_threshold_for_override:
            penalty = max(0.0, penalty - 0.4)

        c["combined_score_filtered"] = max(0.0, c["combined_score"] - penalty)


    # ============================================================
    # 5) AGGREGATION — garder le meilleur score par objet
    # ============================================================
    agg = {}
    for c in candidates:
        key = (c["content_type"], c["object_id"])
        score_key = c["combined_score_filtered"]
        if key not in agg or score_key > agg[key]["combined_score_filtered"]:
            agg[key] = c

    # tri final
    results = sorted(
        agg.values(),
        key=lambda x: x["combined_score_filtered"],
        reverse=True
    )

    # cutoff final : éliminer tous les scores quasi-nuls
    results = [r for r in results if r["combined_score_filtered"] > 0.001]

    # limiter à k
    results = results[:payload.k]

    # ============================================================
    # 6) HIGHLIGHT SERVEUR
    # ============================================================
    for r in results:
        r["snippet"] = highlight(r.get("snippet", "") or "", payload.query)

    cur.close()
    conn.close()

    return {
        "results": [
            {
                "content_id": r["content_id"],
                "content_type": r["content_type"],
                "object_id": r["object_id"],
                "vector_id": r["vector_id"],
                "chunk": r["chunk"],
                "snippet": r["snippet"],
                "score_faiss": r["faiss_score"],
                "score_bm25": r["bm25_score"],
                "score": r["combined_score_filtered"],
            }
            for r in results
        ]
    }




# ---------------------------
#   DELETE / UPDATE / REINDEX
# ---------------------------
class DeleteRequest(BaseModel):
    content_id: str


@router.post("/delete_content", dependencies=[Depends(check_api_key)], tags=["admin"])
async def delete_content(req: DeleteRequest):
    conn = get_faiss_meta_conn()
    cur = conn.cursor()
    cur.execute("SELECT vector_id FROM content_vectors WHERE content_id=%s", (req.content_id,))
    rows = cur.fetchall()
    if not rows:
        cur.close()
        conn.close()
        return {"status": "not_found", "content_id": req.content_id}

    ids = [r[0] for r in rows]
    faiss_remove_ids(ids)
    cur.executemany("DELETE FROM content_vectors WHERE vector_id=%s", [(i,) for i in ids])
    conn.commit()
    cur.close()
    conn.close()
    return {"status": "deleted", "content_id": req.content_id, "removed_vectors": ids}


class UpdateRequest(IngestRequest):
    pass


@router.post("/update_content", dependencies=[Depends(check_api_key)], tags=["admin"])
async def update_content(req: UpdateRequest):
    await delete_content(DeleteRequest(content_id=req.content_id))
    p = IngestPayload(
        content_id=str(req.content_id),
        title=req.title or "",
        description=req.description or "",
        url=req.url,
        type=req.type or "text"
    )
    return ingest_content(p)


@router.post("/reindex", dependencies=[Depends(check_api_key)], tags=["admin"])
async def reindex_endpoint():
    if not os.path.exists(BUILD_INDEX_SCRIPT):
        raise HTTPException(status_code=500, detail="build_index script not found")
    try:
        subprocess.Popen(["python", BUILD_INDEX_SCRIPT], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return {"status": "reindex_started"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/health", tags=["system"])
async def health():
    return {"status": "ok"}
