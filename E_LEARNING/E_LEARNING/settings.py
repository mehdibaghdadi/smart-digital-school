from flask import request
import os
from dotenv import load_dotenv
from datetime import timedelta
from E_LEARNING.resources.menu_resources import MenuResources
from E_LEARNING.resources.jinja2_resources import Jinja2Resources
from E_LEARNING.resources.javascript_resources import JavascriptResources

load_dotenv()

MODE_DEBUG = os.environ.get("MODE_DEBUG", "1") == "1"
LOCAL_IP = "localhost"
#LOCAL_IP = "192.168.100.233"

class Config(object):
    PYTHONIOENCODING = "UTF-8"
    APP_TITLE = "Smart Digital School"
    DEFAULT_PICTURE_PROFILE = "/static/app-assets/img/avatar-sds.jpg"
    MAX_CONTENT_LENGTH = (101 * 2) * 1024 * 1024  # 200 Mb limit
    URL_FILE_MANAGER = "http://{}/".format("URL_FILE_MANAGER")
    # Set up the App SECRET_KEY
    SECRET_KEY = os.getenv("SECRET_KEY", "")
    TOKEN_API = os.getenv("TOKEN_API", "")
    
    SESSION_PROTECTION = "basic"
    MYSQL_HOST = {
    "engine": os.getenv("MYSQL_ENGINE","mysql+pymysql"),
    "host": os.getenv("MYSQL_HOST","localhost"),
    "port": int(os.getenv("MYSQL_PORT", 3306)),
    "user": os.getenv("MYSQL_USER",""),
    "password": os.getenv("MYSQL_PASSWORD",""),
    "database": os.getenv("MYSQL_DATABASE","elearningdb"),
    }    
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_POOL_RECYCLE = 3600

    RATE_LIMIT_LOGIN = "5/30 second"
    RATE_LIMIT_FAST = "10/2 second"
    RATE_LIMIT_MEDIUM = "5/2 second"
    RATE_LIMIT_SLOW = "1/5 second"

    SESSION_PERMANENT = True
    SESSION_TYPE = 'filesystem'
    PERMANENT_SESSION_LIFETIME = timedelta(days=30)
    PERMANENT_SESSION_LIFETIME_REMEMBER = timedelta(days=30)
    PERMANENT_SESSION_LIFETIME_FORGET = timedelta(minutes=60)
    SESSION_COOKIE_HTTPONLY = True
    REMEMBER_COOKIE_HTTPONLY = True
    REMEMBER_COOKIE_REFRESH_EACH_REQUEST = True

    MAIL_SERVER = "smtp.gmail.com"
    MAIL_PORT = 587
    MAIL_USERNAME = os.getenv("MAIL_USERNAME", "")
    MAIL_DEFAULT_SENDER = os.getenv("MAIL_DEFAULT_SENDER", os.getenv("MAIL_USERNAME", ""))
    MAIL_PASSWORD = os.getenv("MAIL_PASSWORD", "")
    MAIL_USE_TLS = True
    MAIL_USE_SSL = False

    APP_LOGGING_FILE = "./logs/elearning.log"
    APP_LOGGING_FILE_MAX_BYTES = 5 * 1024 * 1024

    BABEL_DEFAULT_LOCALE = "en"
    BABEL_LANGUAGES = {"fr": "Français", "en": "English", "es": "Español"}
    BABEL_TRANSLATION_DIRECTORIES = "./translations"

    # Resources
    MENU_RESOURCES = MenuResources
    JINJA2_RESOURCES = Jinja2Resources
    JAVASCRIPT_RESOURCES = JavascriptResources

    # FileManager methods
    CONTENT_UPLOAD_FILE_URL = "upload-manager/upload/{0}/{1}"
    CONTENT_DELETE_FILE_URL = "upload-manager/delete"
    CONTENT_UPDATE_UPLOAD_FILE_URL = "upload-manager/upload/{0}/{1}/delete/{2}"
    CONTENT_DOWNLOAD_MEDIA_URL = "download-manager/media/"
    CONTENT_DOWNLOAD_FILE_URL = "download-manager/filelink"
    CONTENT_GET_IMAGE_URL = "download-manager/image"
    GENERATE_PDF_URL = "pdf-generator/generate-pdf"
    BANK_TRANSFERT_URL = "banktransfert/"

    # COUNTRY WITH CITIES
    COUNTRY_WITH_CITIES = [116]

    # THEMES
    THEMES = [
        {"id":"0","css": "original.css","def": "original","color": "#001d40"},
        {"id":"1","css": "purple.css","def": "purple","color": "#8323af"},
        {"id":"2","css": "brown.css","def": "brown","color": "#8e3f00"},
        {"id":"3","css": "olive.css","def": "olive","color": "#00730e"},
        {"id":"4","css": "grena-pink.css","def": "grena-pink","color": "#aa2163"},
    ]
    THEME_DEFAULT_ID = "0"
    ALERT_PACKAGE_REMAINING_DAYS = 5
    DESIRED_PAYMENT =["bank_transfer","contact_sales"]

class ProductionConfig(Config):

    SERVER_NAME_APP = "https://app.smartdigitalschool.com"
    E_FILE_MANAGER_API = "https://app.smartdigitalschool.com:8445/api/"
    E_GATEWAY_API = "https://app.smartdigitalschool.com:8444/api/"
    E_SIGNALR_API = "https://app.smartdigitalschool.com:8447/"
    EPAYMENT_SITE = "https://app.smartdigitalschool.com:8446/{0}/"
    WEB_SITE = "https://smartdigitalschool.com/"
    E_AI_COURSE_API= "https://app.smartdigitalschool.com:5001/api/"

    PAYPAL_CLIENT_ID = os.getenv("PAYPAL_CLIENT_ID", "")
    PAYPAL_SECRET = os.getenv("PAYPAL_SECRET", "")
    PAYPAL_API = 'https://api.sandbox.paypal.com'  # Mode Sandbox pour les tests
    
    SQLALCHEMY_ECHO = False
    ENV = "production"
    FLASK_ENV = "production"
    FLASK_DEBUG = False
    DEBUG = False
    TESTING = False

class DebugConfig(Config):
    
    SERVER_NAME_APP = f"https://{LOCAL_IP}:8443"
    E_FILE_MANAGER_API = f"https://{LOCAL_IP}:8445/api/"
    E_GATEWAY_API = f"https://{LOCAL_IP}:8444/api/"
    E_SIGNALR_API = f"https://{LOCAL_IP}:8447/"
    EPAYMENT_SITE = f"https://{LOCAL_IP}:8446/{{0}}/"
    WEB_SITE = f"https://{LOCAL_IP}:8448/"
    E_AI_COURSE_API= f"https://{LOCAL_IP}:8449/api/"

    PAYPAL_CLIENT_ID = os.getenv("PAYPAL_CLIENT_ID", "")
    PAYPAL_SECRET = os.getenv("PAYPAL_SECRET", "")
    PAYPAL_API = 'https://api.sandbox.paypal.com'  # Mode Sandbox pour les tests

    SQLALCHEMY_ECHO = True
    ENV = "development"
    FLASK_ENV = "development"
    FLASK_DEBUG = True
    DEBUG = True
    TESTING = True
