from ...imports import  *


#---------------Api
class LanguageManager(Api):  
    route_base = "/language-manager/"
    
    @route('/get-language', methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    def getLang(self):
        best_match = request.accept_languages.best_match(app.config['BABEL_LANGUAGES'].keys())
        lang = request.cookies.get("lang-app",best_match)
        
        return Api.json_response(HTTPStatus.OK,lang) 
    
    
    @route('/set-language', methods=Api.GET_POST)
    @limiter.limit(limit.fast,error_message=limit.fast)    
    def setLang(self):
        try:
            lang =  request.args.get('lang', app.config['BABEL_DEFAULT_LOCALE'])              
            g.current_language = lang  
            
            return Api.json_response(HTTPStatus.OK,lang)
        except Exception as inst :
            return Api.json_exception(inst)

@app.before_request
def before_request():
    g.current_language = None

@app.after_request
def after_request(response):
    if g.current_language:
        response.set_cookie('lang-app', g.current_language, max_age=60*60*24*365*10)  # Set to 10 years
    return response