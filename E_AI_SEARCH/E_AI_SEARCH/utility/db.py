import mysql.connector
from settings import MYSQL_HOST, MYSQL_FAISS

def get_host_connection():
    return mysql.connector.connect(
        host=MYSQL_HOST["host"],
        port=MYSQL_HOST["port"],
        user=MYSQL_HOST["user"],
        password=MYSQL_HOST["password"],
        database=MYSQL_HOST["database"],
    )

def get_faiss_meta_conn():
    return mysql.connector.connect(
        host=MYSQL_FAISS["host"],
        port=MYSQL_FAISS["port"],
        user=MYSQL_FAISS["user"],
        password=MYSQL_FAISS["password"],
        database=MYSQL_FAISS["database"],
    )
