import base64
from flask import Flask, url_for, session, jsonify,flash,request, current_app as app
from flask_httpauth import HTTPTokenAuth
from flask_login import current_user,logout_user
from functools import wraps
from werkzeug.utils import redirect
from ..flask.encoder import EncoderToken
#HTTPTokenAuth
auth = HTTPTokenAuth(scheme='Bearer')
tokens = {
    "secret-token": app.config['TOKEN_API']
}

@auth.verify_token
def verify_token(token):

    if current_user and current_user.is_authenticated  :
       return current_user.id

    return EncoderToken.decode_token(token)

