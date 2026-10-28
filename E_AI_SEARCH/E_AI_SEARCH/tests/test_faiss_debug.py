# test_faiss_debug.py
import sys
import traceback
import faiss
import numpy as np
from settings import FAISS_IVF_PATH

print("START", flush=True)

try:
    print("import ok", flush=True)
    idx = faiss.read_index(FAISS_IVF_PATH)
    print("index loaded ntotal:", getattr(idx, "ntotal", "N/A"),
          "d:", getattr(idx, "d", "N/A"), flush=True)

    q = np.random.randn(1, int(getattr(idx, "d", 128))).astype(np.float32)
    print("query shape:", q.shape, flush=True)

    D, I = idx.search(q, 5)
    print("RESULT I:", I, "D:", D, flush=True)

except Exception:
    print("EXCEPTION:", file=sys.stderr)
    traceback.print_exc()
finally:
    try:
        input("press Enter to exit")
    except Exception:
        pass
