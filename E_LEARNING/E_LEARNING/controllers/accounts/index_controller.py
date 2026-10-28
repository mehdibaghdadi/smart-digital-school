from ...imports import  *

class IndexView(Api):
    route_prefix = ""    
    route_base = "/" 

    @route("",methods=Api.GET)
    @login_required
    def index(self):  
        role = current_user.role
        url = url_for("AccountView:login")

        if role == ROLES.Student.value :
            url = url_for("DashboardStudentView:index")

        elif role == ROLES.Instructor.value :
            url = url_for("DashboardInstructorView:index")

        elif role == ROLES.School.value :
            url = url_for("DashboardSchoolView:index")

        elif role == ROLES.Admin.value :
            url = url_for("IndexAdminView:index")

        return redirect(url)

    @login_required
    @route("/contact",methods=Api.GET)
    def contact(self):  
        role = current_user.role
        url = url_for("AccountView:login")

        if role == ROLES.Student.value :
            url = url_for("IndexStudentView:index")

        elif role == ROLES.Instructor.value :
            url = url_for("IndexInstructorView:index")

        elif role == ROLES.School.value :
            url = url_for("IndexSchoolView:index")

        elif role == ROLES.Admin.value :
            url = url_for("IndexAdminView:index")

        return redirect(url)

    
    @route("/privacy", methods=Api.GET_POST)
    def privacy(self):
        return render_template("/accounts/privacy.html")
    
    @route("/terms-conditions", methods=Api.GET_POST)
    def terms_conditions(self):
        return render_template("/accounts/terms-conditions.html")
