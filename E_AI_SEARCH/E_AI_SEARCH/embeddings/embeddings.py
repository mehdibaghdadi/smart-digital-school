# embeddings.py (IVF-ready)
from __future__ import annotations
from pathlib import Path
from typing import List, Optional

import faiss
import numpy as np
from sentence_transformers import SentenceTransformer
import os
from settings import FAISS_PATH, FAISS_FOLDER, FAISS_IVF_PATH

# Config
INDEX_DIR = Path(FAISS_FOLDER)
INDEX_FILE = Path(FAISS_PATH)
IVF_FILE = Path(FAISS_IVF_PATH)
EMBED_DIM = 384  # SentenceTransformers all-MiniLM-L6-v2

_model: SentenceTransformer | None = None
_index: Optional[faiss.Index] = None

def get_model() -> SentenceTransformer:
    global _model
    if _model is None:
        _model = SentenceTransformer("sentence-transformers/all-MiniLM-L6-v2")
    return _model

def embed_texts(texts: List[str]) -> np.ndarray:
    if not texts:
        return np.zeros((0, EMBED_DIM), dtype="float32")
    embeddings = get_model().encode(
        texts, normalize_embeddings=True, convert_to_numpy=True, batch_size=32
    )
    return embeddings.astype("float32")

def ensure_index_dir():
    INDEX_DIR.mkdir(parents=True, exist_ok=True)

def _wrap_idmap(index: faiss.Index) -> faiss.Index:
    """Ensure the index is an IndexIDMap (or IndexIDMap2)."""
    # Many builds expose IndexIDMap; some expose IndexIDMap2
    if isinstance(index, faiss.IndexIDMap) or isinstance(index, faiss.IndexIDMap2):
        return index
    return faiss.IndexIDMap(index)

def load_index() -> faiss.Index:
    """
    Load FAISS index.
    - If FAISS_PATH exists -> load it.
    - Else if IVF_FILE exists -> load it, wrap in IDMap.
    - Else create a fresh IndexFlatIP wrapped in IDMap.
    """
    global _index
    if _index is not None:
        return _index

    ensure_index_dir()

    # Preferred: whole index file saved at FAISS_PATH
    if INDEX_FILE.exists():
        _index = faiss.read_index(str(INDEX_FILE))
        _index = _wrap_idmap(_index)
        return _index

    # Fallback: if an IVF-only file exists, try to load it
    if IVF_FILE.exists():
        _index = faiss.read_index(str(IVF_FILE))
        _index = _wrap_idmap(_index)
        return _index

    # Last resort: create empty flat inner-product index and wrap
    base_index = faiss.IndexFlatIP(EMBED_DIM)
    _index = faiss.IndexIDMap(base_index)
    save_index()
    return _index

def save_index() -> None:
    ensure_index_dir()
    index = load_index()
    faiss.write_index(index, str(INDEX_FILE))
    # also write a copy to IVF_FILE for compatibility reasons
    try:
        faiss.write_index(index, str(IVF_FILE))
    except Exception:
        # some FAISS builds may not permit writing different formats; ignore
        pass

def add_vectors_with_ids(vectors: np.ndarray, ids: List[int]) -> None:
    if vectors is None or vectors.shape[0] == 0:
        return
    index = load_index()
    ids_np = np.array(ids, dtype="int64")
    index.add_with_ids(vectors, ids_np)
    save_index()

def remove_ids(ids: List[int]) -> None:
    if not ids:
        return
    index = load_index()
    ids_np = np.array(ids, dtype="int64")
    index.remove_ids(ids_np)
    save_index()

def search(query: str, top_k: int = 5):
    index = load_index()
    if index.ntotal == 0:
        return [], []
    vector = embed_texts([query])
    scores, ids = index.search(vector, top_k)
    return scores, ids
