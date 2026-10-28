
from ...imports import  *

class ReportingSchoolView(Api):
    route_prefix = ""    
    route_base = "/reporting/school/"     
       
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/report-instructor-courses/",methods=Api.GET)
    def reportInstructorCourses(self):  
        school_id = current_user.id     
        
        return render_template("/reportings/school/rpt-instructor-courses.html",
                               school_id=school_id)
    
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/report-instructor-enrollment-courses/",methods=Api.GET)
    def reportInstructorEnrollmentCourses(self):  
        school_id = current_user.id     
        
        return render_template("/reportings/school/rpt-instructor-enrollment-courses.html",
                               school_id=school_id)
    
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/report-instructor-feedback-courses/",methods=Api.GET)
    def reportInstructorFeedbackCourses(self):  
        school_id = current_user.id     
        
        return render_template("/reportings/school/rpt-feedback-instructor-courses.html",
                               school_id=school_id)
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/report-my-students/",methods=Api.GET)
    def reportMyStudents(self):  
        school_id = current_user.id    
        
        return render_template("/reportings/school/rpt-my-students.html",
                               school_id=school_id
                               ) 
    
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/report-my-instructors/",methods=Api.GET)
    def reportMyInstructors(self):  
        school_id = current_user.id          
        return render_template("/reportings/school/rpt-my-instructors.html",
                               school_id=school_id)
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/report-school-subjects/",methods=Api.GET)
    def reportSchoolSubjects(self):  
        school_id = current_user.id          
        return render_template("/reportings/school/rpt-school-subjects.html",
                               school_id=school_id)
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/report-school-qualifications/",methods=Api.GET)
    def reportSchoolQualifications(self):  
        school_id = current_user.id          
        return render_template("/reportings/school/rpt-school-qualifications.html",
                               school_id=school_id)
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/report-courses-assistance/",methods=Api.GET)
    def reportCoursesAssistance(self):  
        school_id = current_user.id     
        
        return render_template("/reportings/school/rpt-courses-assistance.html",
                               school_id=school_id)