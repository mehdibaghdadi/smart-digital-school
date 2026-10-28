#System
from datetime import datetime , timedelta
from dateutil.relativedelta import relativedelta
from decimal import Decimal 
from flask import (Response,render_template,make_response, request, flash,abort, redirect, url_for,session)
from flask import g, current_app as app
from flask_cors import  cross_origin
from flask_login import login_required, current_user,login_user,logout_user
from http import HTTPStatus
from json import JSONEncoder 
from sqlalchemy import extract,or_
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import make_transient
from sqlalchemy.sql import exists
from sqlalchemy.sql.expression import func
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
import base64
import json 
import os
import requests  
import time
#Database modules 
from ..models.db_commands import  * 
from ..models.db_context import  _dbCxt as dbSession
from ..models.db_entities_tables import  * 
from ..models.db_entities_views import  * 

#Others modules 
from ..resources.api_resources import ApiResources as ARS 
from ..commun.account.login_session import loginSession
from ..commun.database.db_enums import  ROLES,STATUS_LEARNING_PROGRESS,PACKAGE,PAYMENT_METHOD,PAYMENT_STATUS
from ..commun.menu.menu import *
from ..utilities.database.sqlalchemy_pagination import paginate
from ..utilities.filters.decorator import role_required 
from ..utilities.filters.limiter import limiter, LimiterConfig as limit
from ..utilities.filters.token_authenticate import auth 
from ..utilities.filters.validator import src_fallback 
from ..utilities.flask.encoder import EncoderImage ,EncoderToken
from ..utilities.flask.flask_services import SendMail,uploadImage,getImage,delete_file_async
from ..utilities.flask.flask_view import (BaseController as Api , route ,register_flaskviews,jsonify ,allowed_file_images,get_dir_images,create_dir_images,representsInt,representsDecimal,convertTimezoneToDate )



