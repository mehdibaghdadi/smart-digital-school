# build_index.py
"""
Robust FAISS index builder (Flat for small datasets, IVF for large ones).
"""

from pathlib import Path
import argparse
import numpy as np
import faiss
from settings import FAISS_PATH, FAISS_IVF_PATH, VECTORS_PATH, IDS_PATH

def choose_nlist(N):
    """
    Automatically choose a safe nlist for IVF.
    Rule: nlist ≈ sqrt(N), clamped to [8, 4096].
    """
    import math
    n = int(math.sqrt(N))
    if n < 8:
        n = 8
    if n > 4096:
        n = 4096
    return n

def build_flat(vectors, ids, D):
    """
    Simple index for small datasets.
    """
    print("Using IndexFlatIP + IDMap (dataset too small for IVF).")
    base = faiss.IndexFlatIP(D)
    idmap = faiss.IndexIDMap(base)
    idmap.add_with_ids(vectors, ids)
    return idmap

def build_ivf(vectors, ids, D, nlist, nprobe):
    """
    IVF index (only if N >= nlist).
    """
    N = vectors.shape[0]

    print(f"Training IVF index with nlist={nlist}, nprobe={nprobe}...")

    quantizer = faiss.IndexFlatIP(D)
    index = faiss.IndexIVFFlat(
        quantizer,
        D,
        nlist,
        faiss.METRIC_INNER_PRODUCT
    )

    print("Training...")
    index.train(vectors)

    print("Wrapping in IDMap and adding vectors...")
    idmap = faiss.IndexIDMap(index)
    idmap.add_with_ids(vectors, ids)

    if hasattr(idmap, "nprobe"):
        idmap.nprobe = nprobe

    return idmap

def main(nlist_arg, nprobe):
    print("Loading vectors and ids...", VECTORS_PATH)

    vectors = np.load(str(VECTORS_PATH), allow_pickle=False).astype("float32")
    ids = np.load(str(IDS_PATH), allow_pickle=False).astype("int64")

    N, D = vectors.shape
    print(f"Loaded {N} vectors with dim {D}")

    # Decide whether to use flat or IVF
    if N < 500:  # threshold for IVF usefulness
        index = build_flat(vectors, ids, D)
    else:
        # choose nlist if user passed 0 or very large
        if nlist_arg <= 0:
            nlist = choose_nlist(N)
        else:
            nlist = min(nlist_arg, N)
            if nlist < 8:
                nlist = 8

        index = build_ivf(vectors, ids, D, nlist, nprobe)

    print("Saving index to:", FAISS_PATH)
    faiss.write_index(index, str(FAISS_PATH))

    # Optional IVF copy
    try:
        faiss.write_index(index, str(FAISS_IVF_PATH))
    except Exception:
        pass

    print("Done.")
    print("Index total vectors:", index.ntotal)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--nlist", type=int, default=0, help="IVF nlist (0 = auto)")
    parser.add_argument("--nprobe", type=int, default=4, help="IVF nprobe")
    args = parser.parse_args()

    main(args.nlist, args.nprobe)
