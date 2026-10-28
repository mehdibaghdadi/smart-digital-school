from ...imports import  *

class ReportingInstructorView(Api):
    route_prefix = ""    
    route_base = "/reporting/instructor/" 


    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/enrollment/",methods=Api.GET)
    def enrollmentCourse(self):  
        instructor_id = current_user.id
        s_api = ReportingInstructorManager()
        course_list = s_api.getListEnrollementCourse(instructor_id)

        course_edit_url = url_for("CourseInstructorView:edit_1")       

        return render_template("/instructors/course/enrollment.html",
                                course_list=course_list,
                                course_edit_url=course_edit_url
                                )

    
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/report-feedback-courses/",methods=Api.GET)
    def reportFeedbackCourses(self):  
        instructor_id = current_user.id         
        
        return render_template("/reportings/instructor/rpt-feedback-courses.html",
                               instructor_id=instructor_id)
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/report-enrollment-courses/",methods=Api.GET)
    def reportEnrollmentCourses(self):  
        instructor_id = current_user.id     
        school_id = current_user.school_id     
       
        return render_template("/reportings/instructor/rpt-enrollment-courses.html",
                               instructor_id=instructor_id,
                               school_id=school_id,
                               )

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/report-quiz-courses/",methods=Api.GET)
    def reportQuizCourses(self):  
        instructor_id = current_user.id     
        school_id = current_user.school_id     
        
        return render_template("/reportings/instructor/rpt-quiz-courses.html",
                               instructor_id=instructor_id,
                               school_id=school_id,
                               )

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/report-my-students/",methods=Api.GET)
    def reportMyStudents(self):  
        instructor_id = current_user.id          
        
        return render_template("/reportings/instructor/rpt-my-students.html",
                               instructor_id=instructor_id
                               )
    

#---------------Api
class ReportingInstructorManager(Api):  
    route_base = "/instructor-course-manager/"

    @route("/list-course/<instructor_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListEnrollementCourse(self,instructor_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)
        try: 
            qList = EnrollmentCourseView.query.filter_by(instructor_id=instructor_id).order_by(EnrollmentCourseView.enrollment_date.desc()).all()
            if not qList:
                return notFound             
            qList = [ i.serialize() for i in qList]
            return Api.json_response(HTTPStatus.OK,qList) 
        except Exception as inst :
            return Api.json_exception(inst) 