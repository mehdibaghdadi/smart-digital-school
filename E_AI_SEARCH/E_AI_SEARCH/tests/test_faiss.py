import faiss
import numpy as np
from settings import FAISS_IVF_PATH
try:
    
    print("I, D")
    index = faiss.read_index(FAISS_IVF_PATH)
    q = np.random.randn(1, index.d).astype(np.float32)
    D, I = index.search(q, 5)
    print(I, D)
    input("pause")
except Exception as ex:
    print("Error:", ex)