from ...imports import  *

class IndexInstructorView(Api):
    route_prefix = ""    
    route_base = "/instructor/" 

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("",methods=Api.GET)
    def index(self):  
        url = url_for("IndexView:index")        
        return redirect(url)
        
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/contact",methods=Api.GET)
    def contact(self):  
        school_id = current_user.school_id

        from .profile_controller import ProfileInstructorManager
        s_api = ProfileInstructorManager()
        school = s_api.getSchool(school_id)
        return render_template("/instructors/contact.html",
                               school = school
                               )    
