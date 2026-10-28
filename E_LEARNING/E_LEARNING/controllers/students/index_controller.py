from ...imports import  *

class IndexStudentView(Api):
    route_prefix = ""    
    route_base = "/student/" 

    @login_required
    @role_required(role=ROLES.Student.value)
    @route("",methods=Api.GET)
    def index(self):  
        url = url_for("IndexView:index")        
        return redirect(url)

    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/contact",methods=Api.GET)
    def contact(self):  
        return render_template("/students/index.html")

