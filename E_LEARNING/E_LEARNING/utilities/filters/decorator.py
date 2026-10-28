from flask import abort
from flask import Flask, url_for, session, jsonify,flash,render_template, current_app as app
from flask_login import current_user,logout_user,LoginManager
from functools import wraps
from werkzeug.utils import redirect
from ...utilities.flask.flask_view import (BaseController as Api)

login_manager = LoginManager()

def role_required(role="Any"):
    def wrapper(fn):
        @wraps(fn)
        def decorated_view(*args, **kwargs):
            code=200
            try:
                try:
                    if not current_user or not current_user.is_authenticated:
                        code=401 
                    if (current_user.role != role) and (role != "Any"):
                        code=401                    
                except Exception as e:
                    code=500
                    Api.json_exception(e)      
                
                if code==200:
                    return fn(*args, **kwargs)
                elif code == 401:
                     abort(401)
                elif code == 500:
                     abort(500)
                
                return fn(*args, **kwargs)
            except Exception as e:
                Api.json_exception(e)    
                abort(e.code or 500)

        return decorated_view
    return wrapper
