from ...imports import  *

class IndexAdminView(Api):
    route_prefix = ""    
    route_base = "/admin/" 

    @login_required
    @route("",methods=Api.GET)
    def index(self):  
        return render_template("/admins/index.html")

