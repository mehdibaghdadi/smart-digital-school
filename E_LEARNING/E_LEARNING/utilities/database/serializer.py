import json
import decimal
from sqlalchemy.inspection import inspect
from json import JSONEncoder
from flask.json.provider import JSONProvider
from flask import current_app as app
from flask_babel.speaklater import LazyString
from  datetime import date
from sqlalchemy.orm import DeclarativeMeta
from contextlib import suppress
from sqlalchemy import inspect
"""
Json Entity Encoder
"""  
class JSON_Improved(JSONEncoder):
    def default(self, o):
        try:            
            if isinstance(o, LazyString):
                return str(o)
            
            if isinstance(o, decimal.Decimal):
                return str(o)
            
            if isinstance(o, date):
                return o.isoformat()
            
            # Optional: convert datetime objects to ISO format
            with suppress(AttributeError):
                return o.isoformat()
            return dict(o)
        except :
            ""

class CustomJSONProvider(JSONProvider):
    
    def dumps(self, obj, **kwargs):
        return json.dumps(obj, **kwargs, cls=JSON_Improved)
    
    def loads(self, s: str | bytes, **kwargs):
        return json.loads(s, **kwargs)          

"""
Serialize entities sqlalchemy
"""
class EntitySerializer:
    def serialize(self, _depth=1):
        with suppress(AttributeError):
            d = {}
            for attr in inspect(self).attrs.keys():
                val = getattr(self, attr)
                # ---- relations -------------------------------------------------
                if isinstance(val.__class__, DeclarativeMeta):           # objet SA
                    val = val.serialize(_depth-1) if _depth > 0 else getattr(val, 'id', None)
                elif isinstance(val, (list, tuple, set)):                # collection
                    val = [
                        (v.serialize(_depth-1) if _depth > 0 else getattr(v, 'id', None))
                        if isinstance(v.__class__, DeclarativeMeta) else v
                        for v in val
                    ]
                # ----------------------------------------------------------------
                d[attr] = val

            for p in (prop for prop in dir(self.__class__) if isinstance(getattr(self.__class__, prop), property)):
                with suppress(Exception):
                    d[p] = getattr(self, p)
            return d
        return '{null}'

    @staticmethod
    def serialize_list(it):
        return [obj.serialize() for obj in it]



