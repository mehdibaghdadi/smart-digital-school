from E_LEARNING import app,logger
from time import strftime
import sys
import os
import inspect
from flask_classful import FlaskView, route
from flask import  request,make_response,jsonify,current_app as app
from http import HTTPStatus
from decimal import Decimal
from datetime import datetime
"""
Routes Base class FlaskView (API)
"""
class BaseController(FlaskView):
    route_prefix = "/api/"   
    GET=['GET']
    POST=['POST']
    GET_POST=['GET','POST']
    PUT=['PUT']
    DELETE=['DELETE']

    @classmethod
    def json_response(self,code,obj):
        return make_response(jsonify(status = code,response = obj),code)

    @classmethod
    def log_exception(self,obj):
        import sys
        co_name = sys._getframe(1).f_code.co_name
        co_firstlineno = sys._getframe(1).f_code.co_firstlineno
        obj = str(obj) if obj.args else '_'
        code=500
        logger.error('Method: %s(%s) - [%s, %s, %s="%s"] - Exception: %s',
                      co_name,
                      co_firstlineno,
                      request.remote_addr,
                      request.method,
                      request.scheme,
                      request.full_path,
                      obj)
        
    @classmethod
    def json_exception(self,obj):
        import sys
        co_name = sys._getframe(1).f_code.co_name
        co_firstlineno = sys._getframe(1).f_code.co_firstlineno
        obj = str(obj) if obj.args else '_'
        code=500
        logger.error('Method: %s(%s) - [%s, %s, %s="%s"] - Exception: %s',
                      co_name,
                      co_firstlineno,
                      request.remote_addr,
                      request.method,
                      request.scheme,
                      request.full_path,
                      obj)
        return make_response(jsonify(status = HTTPStatus.INTERNAL_SERVER_ERROR,response = obj),code)

"""
 Determine if `item` is a `FlaskView` subclass
(because we don't want to register `FlaskView or FlaskViewBase` itself).
"""
def is_flaskview(item):
    return (item not in [FlaskView,BaseController] 
            and inspect.isclass(item) 
            and issubclass(item,FlaskView)
            ) # and not item.__ignore__()

"""
 Registre `FlaskViewBase` subclass views
"""
def register_flaskviews(app=None,flaskviews=None):
    if app is None:
        raise ValueError('cannot init views without app object')
    if flaskviews is not None:
        results = []
        results = inspect.getmembers(flaskviews,predicate=inspect.isclass)
        for name, obj in results:
                        if is_flaskview(obj):
                            obj.register(app)


"""
 METHODS
"""
def allowed_file_images(filename):
    return '.' in filename and \
            filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS_IMAGES']

def get_dir_images(id,filename,directory):
    return app.root_path + os.path.join( directory + str(id) + '/', filename)

def create_dir_images(id,directory):
    folder = app.root_path + os.path.join( directory + str(id) , "")
    if not os.path.exists(folder):
        os.makedirs(folder)

def representsInt(s):
    try: 
        int(s)
        return True
    except ValueError:
        return False

def representsDecimal(s):
    try: 
        Decimal(s)
        return True
    except ValueError:
        return False
   
def convertTimezoneToDate(date_string_tz):
    try: 
        sep="+"
        if "Z" in date_string_tz:
            sep ="Z"

        dt=date_string_tz.split(sep)[0]
        dt= datetime.strptime(dt, "%Y-%m-%dT%H:%M:%S")
        return dt
    except ValueError:
        return None

