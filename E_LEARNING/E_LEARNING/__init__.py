from dotenv import load_dotenv
from datetime import datetime
from E_LEARNING.settings import MODE_DEBUG
from E_LEARNING.commun.database.db_enums import *
from E_LEARNING.utilities.database.serializer import CustomJSONProvider
from E_LEARNING.utilities.flask import flask_logging as log 
from E_LEARNING.utilities.flask.encoder import EncoderToken
from flask import (
    g,
    Flask,
    current_app,
    make_response,
    jsonify,
    request,
    session,
    render_template,
    Response,
)
from flask_cors import CORS
from flask_login import LoginManager, current_user
from flask_mail import Mail
from flask_minify import minify
from os import environ
from urllib.parse import quote as url_quote
from werkzeug.middleware.proxy_fix import ProxyFix
import werkzeug, sys,base64
from flask_babel import Babel,format_date
import gevent
from gevent import monkey

# Patch les appels I/O pour être non-bloquants
monkey.patch_all()

# Initialization
# --------------
APP_VERSION_FILE = (
    datetime.now().strftime("%Y-%m-%d-%H-%M")
    if MODE_DEBUG
    else environ.get("APP_VERSION", "1.0.0")
)

app = Flask(__name__)

# translator
babel = Babel(app)

# custom encoding Flask
app.json_provider_class = CustomJSONProvider
app.json = CustomJSONProvider(app)

# zip
minify(app=app, html=True, js=True, cssless=True)

# mail sender
mail = Mail()

# user login manager
login_manager = LoginManager()
login_manager.login_view = "AccountView:login"

# Cross origin
cors = CORS(app, resources={r"/*": {"origins": "*"}})

# App configuration
get_config_mode = "E_LEARNING.settings.DebugConfig" if MODE_DEBUG else "E_LEARNING.settings.ProductionConfig"
app.config.from_object(get_config_mode)
app.config["PROPAGATE_EXCEPTIONS"] = True
login_manager.init_app(app)
mail.init_app(app)

# LOGGER configuration
# --------------------
logger = log.get_logger(__name__, app.config["APP_LOGGING_FILE"])
sys.tracebacklimit = 1 if MODE_DEBUG else 0


# Errors Handlers
# ---------------
@app.errorhandler(Exception)
def err_generic(e):
    code = getattr(e, 'code', 500)

    error_map = {
        400: ("Bad Request", "The request was invalid or cannot be processed."),
        401: ("Unauthorized", "You must be logged in to access this page."),
        403: ("Access Denied", "You do not have permission to access this page."),
        404: ("Page Not Found", "The page you are looking for does not exist or has been moved."),
        405: ("Method Not Allowed", "This HTTP method is not allowed for the requested URL."),
        408: ("Request Timeout", "The request took too long and timed out."),
        429: ("Too Many Requests", "You have made too many requests in a short period."),

        500: ("Internal Server Error", "An unexpected error occurred. Please try again later."),
        501: ("Not Implemented", "This feature is not implemented on the server."),
        502: ("Bad Gateway", "The server received an invalid response."),
        503: ("Service Unavailable", "The server is currently unavailable. Please try again later."),
        504: ("Gateway Timeout", "The server timed out while waiting for a response.")
    }

    # Fallback values
    title, message = error_map.get(code, (
        "Unexpected Error",
        "An unknown error occurred. Please contact support."
    ))

    return render_template("_base/errors/error-handler.html",
        code=code,
        title=title,
        message=message
    ), code


# Global variables
# -----------------
@app.context_processor
def utility_cxt_processor():
    def app_version():
        return APP_VERSION_FILE
   
    # Base64 encode the binary data to make it web-safe
    token_base64 = EncoderToken.create_token()

    return dict(
        app_version=app_version, ROLES=ROLES, PACKAGE=PACKAGE, DEBUG=MODE_DEBUG,
        TOKEN_API=token_base64,format_date=format_date
    )


# Register Views/Routes
# ---------------------
with app.app_context():
    import E_LEARNING.controllers


# Babel Lang
def get_locale():
    best_match = request.accept_languages.best_match(
        app.config["BABEL_LANGUAGES"].keys()
    )
    g.current_language = request.cookies.get("lang-app", best_match)
    return g.current_language


babel.init_app(app, locale_selector=get_locale)
