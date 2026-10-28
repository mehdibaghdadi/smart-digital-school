from flask import current_app as app
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker, load_only
from sqlalchemy.ext.declarative import declarative_base, AbstractConcreteBase
from ..utilities.database.serializer import EntitySerializer

"""-------------------
Engine DB SqlAlchemy
-------------------"""

def get_engine():

    MYSQL_HOST = app.config["MYSQL_HOST"]
    SQLALCHEMY_DATABASE_URI = (
        f"{MYSQL_HOST['engine']}://{MYSQL_HOST['user']}:{MYSQL_HOST['password']}"
        f"@{MYSQL_HOST['host']}:{MYSQL_HOST['port']}/{MYSQL_HOST['database']}"
    )

    SQLALCHEMY_POOL_RECYCLE = app.config["SQLALCHEMY_POOL_RECYCLE"]
    SQLALCHEMY_ECHO = app.config["SQLALCHEMY_ECHO"]

    return create_engine(
        SQLALCHEMY_DATABASE_URI,
        pool_size=50,  # Nombre initial de connexions dans le pool
        max_overflow=100,  # Nombre maximal de connexions
        pool_recycle=SQLALCHEMY_POOL_RECYCLE,
        pool_pre_ping=True,
        echo=SQLALCHEMY_ECHO,
    )


engine = get_engine()
engine.pool._use_threadlocal = True

_dbCxt = scoped_session(sessionmaker(autocommit=False, autoflush=False, bind=engine))
Base = declarative_base()
Base.query = _dbCxt.query_property()
metadata = Base.metadata

try:
    engine.raw_connection()
except Exception as ex:
    print(ex)


"""--------------------------
Remove Session DB SqlAlchemy
---------------------------"""


@app.teardown_appcontext
def shutdown_session(exception=None):
    _dbCxt.remove()
