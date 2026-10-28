from pathlib import Path
from dotenv import load_dotenv
import os

BASE_DIR = Path(__file__).resolve().parent
load_dotenv(BASE_DIR / ".env")

def _clean(v):
    if v is None:
        return None
    return v.strip().strip('"').strip("'")

FAISS_FOLDER = _clean(os.getenv("FAISS_FOLDER", "faiss_store"))

FAISS_FILE   = _clean(os.getenv("FAISS_FILE", "faiss.index"))
FAISS_IVF_FILE   = _clean(os.getenv("FAISS_IVF_FILE", "faiss_index.ivf"))
IDS_FILE     = _clean(os.getenv("IDS_FILE", "ids.npy"))
VECTORS_FILE     = _clean(os.getenv("VECTORS_FILE", "vectors.npy"))

FAISS_PATH = BASE_DIR / FAISS_FOLDER / FAISS_FILE
FAISS_IVF_PATH = BASE_DIR / FAISS_FOLDER / FAISS_IVF_FILE
IDS_PATH  = BASE_DIR / FAISS_FOLDER / IDS_FILE
VECTORS_PATH = BASE_DIR / FAISS_FOLDER / VECTORS_FILE

MYSQL_HOST = {
    "host": os.getenv("MYSQL_HOST", "localhost"),
    "port": int(os.getenv("MYSQL_PORT", 3306)),
    "user": os.getenv("MYSQL_USER"),
    "password": os.getenv("MYSQL_PASSWORD"),
    "database": os.getenv("MYSQL_DATABASE"),
}

MYSQL_FAISS = {
    "host": os.getenv("FAISS_DB_HOST", "localhost"),
    "port": int(os.getenv("FAISS_DB_PORT", 3306)),
    "user": os.getenv("FAISS_DB_USER"),
    "password": os.getenv("FAISS_DB_PASS"),
    "database": os.getenv("FAISS_DB_NAME"),
}

API_KEY = os.getenv("E_AI_SEARCH_API_KEY")
BUILD_INDEX_SCRIPT = os.getenv("BUILD_INDEX_SCRIPT", "index/build_index.py")
OPENAI_API_KEY=os.getenv("OPENAI_API_KEY")

# Simple stopwords (extend as needed)
STOPWORDS = {
    # French
    "le","la","les","un","une","des","du","de","d","au","aux",
    "et","ou","est","sont","mais","donc","or","ni","car",
    "que","qui","quoi","quand","où","ou","comme",
    "pour","par","avec","sans","sur","sous","dans","entre","chez",
    "ce","cet","cette","ces",
    "mon","ton","son","notre","votre","leur",
    "mes","tes","ses","nos","vos","leurs",
    "être",

    # English
    "the","a","an","and","or","but","so","because",
    "to","from","on","in","into","onto","at","of","off","up","down",
    "for","with","without","within","between","among",
    "this","that","these","those",
    "my","your","his","her","its","our","their",
    "is","are","was","were","be","been","being",
    "have","has","had","do","does","did",
    "can","could","will","would","should",
}
