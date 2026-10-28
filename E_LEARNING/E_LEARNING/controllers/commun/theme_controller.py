from sqlalchemy.engine import url
from ...imports import *

class ThemeView(Api):
    route_prefix = ""    
    route_base = "/theme/" 
    
    @login_required
    @role_required(role=ROLES.Any.value)
    @route("/", methods=Api.GET)
    def index(self): 
        api = ThemeManager()
        tlist = api.listTheme().json['response']       
        url_set_theme = url_for('ThemeManager:setTheme')
        return render_template("/commun/theme/look-and-feel.html",
                               theme_list=tlist,
                               url_set_theme=url_set_theme)

# ---------------Api
class ThemeManager(Api):
    route_base = "/theme-manager/"

    @route("/get-theme", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    def getTheme(self):
         
        theme = request.cookies.get("theme-app")
        if theme:
            theme = json.loads(theme)
        else:
            theme_list = app.config["THEMES"]
            theme = next((theme for theme in theme_list if theme["id"] == app.config["THEME_DEFAULT_ID"]), None)
            g.theme_sds = json.dumps(theme)
            
        return Api.json_response(HTTPStatus.OK, theme)

    @route("/list-theme", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    def listTheme(self):
        theme_list = app.config["THEMES"]
        return Api.json_response(HTTPStatus.OK, theme_list)

    @route("/set-theme", methods=Api.GET_POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    def setTheme(self):
        try:
            data = json.loads(request.data)
            theme = json.dumps(data)  # Serialize the dictionary to a JSON string
            g.theme_sds = theme
            return Api.json_response(HTTPStatus.OK, data)
        except Exception as inst:
            return Api.json_exception(inst)

@app.before_request
def before_request():
    g.theme_sds = None

# Middleware to set the cookie after the request
@app.after_request
def after_request(response):
    if g.theme_sds:
        response.set_cookie('theme-app', g.theme_sds, max_age=60*60*24*365*10)  # Set to 10 years
    return response

# Make this object globally available in template context
@app.context_processor
def utility_app_themes():
    api = ThemeManager()
    th = api.getTheme().json['response']
    return dict(current_theme=th)