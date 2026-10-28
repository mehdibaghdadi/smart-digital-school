from flask import  make_response, jsonify ,current_app as app
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

#limit request per xxx
limiter = Limiter(key_func=get_remote_address,app=app,                  
                  storage_uri = "memory://",
                  )

"""
Configuration of API limiters
"""
class LimiterConfig():

    login = app.config["RATE_LIMIT_LOGIN"]
    fast = app.config["RATE_LIMIT_FAST"]
    medium = app.config["RATE_LIMIT_MEDIUM"]
    slow = app.config["RATE_LIMIT_SLOW"]
"""
Over limit handler
"""
@app.errorhandler(429)
def ratelimit_handler(e):
    return make_response(
            jsonify(error=f"{e.description}" )
            , 429
    )