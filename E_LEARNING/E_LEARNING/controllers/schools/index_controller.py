from ...imports import  *

class IndexSchoolView(Api):
    route_prefix = ""    
    route_base = "/school/" 


    @login_required
    @role_required(role=ROLES.School.value)
    @route("",methods=Api.GET)
    def index(self):  
        url = url_for("IndexView:index")        
        return redirect(url)

    @login_required
    @role_required(role=ROLES.School.value)
    @route("/contact",methods=Api.GET)
    def contact(self):  
        return render_template("/schools/index.html")

