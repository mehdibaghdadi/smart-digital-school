from ...imports import  *

class InstructorStudentView(Api):
    route_prefix = ""    
    route_base = "/student/instructor/" 
    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/list",methods=Api.GET)
    def list(self):  
        student_id = current_user.id
        s_api = InstructorStudentManager()
        instructor_course_list = s_api.getList(student_id)

        course_list_url = url_for("CourseView:listCourseInstructor_1")
        return render_template("/students/instructor/instructor-list.html",
                               instructor_course_list = instructor_course_list,
                               course_list_url = course_list_url
                               )


#---------------Api
class InstructorStudentManager(Api):  
    route_base = "/student-instructor-manager/"

    @route("/list/<student_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getList(self,student_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)
        try:            

            il = dbSession.query(InstructorStudentSubjectQualificationView.instructor_id.distinct().label("id"))\
                .filter(                    
                        InstructorStudentSubjectQualificationView.student_id== student_id                                            
                    ).all()

            if not il :
                return notFound

            il = [ p for p, in il]
            qList = Instructor.query.options(noload('*'))\
                                            .filter(Instructor.active_account==True,Instructor.id.in_(il))\
                                            .order_by(Instructor.last_name.asc()).all()

            if not qList:
                return notFound 
            
            for user in qList:
                img = getImage(user.image)
                setattr(user,'image' ,img)
          
            qList = [ i.serialize() for i in qList]
            return Api.json_response(HTTPStatus.OK,qList) 
        except Exception as inst :
            return Api.json_exception(inst) 
