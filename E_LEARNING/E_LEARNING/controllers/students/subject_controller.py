from ...imports import  *

class SubjectStudentView(Api):
    route_prefix = ""    
    route_base = "/student/subject/" 

    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/list",methods=Api.GET)
    def index(self):          
        student_id = current_user.id
        subject_list = (SubjectStudentManager()).getListSubject(student_id)
        course_subject_url= url_for("CourseView:listBySubject_1")
        return render_template("/students/subject/subject-list.html",
                               course_subject_url=course_subject_url,
                               subject_list = subject_list)

#---------------Api
class SubjectStudentManager(Api):  
    route_base = "/student-subject-manager/"
    @route("/list/<student_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListSubject(self,student_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            sb = StudentSubjectCourseView.query.filter_by(student_id=student_id)\
                .order_by(StudentSubjectCourseView.total_course.desc(),StudentSubjectCourseView.label_subject)\
                .all()  
            if not sb:
                return notFound 
            sb = [ i.serialize() for i in sb]
            return Api.json_response(HTTPStatus.OK,sb) 
        except Exception as inst :
            return Api.json_exception(inst)    


