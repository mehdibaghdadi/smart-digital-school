from email.policy import default
from ...imports import  *

class ReportingView(Api):
    route_prefix = ""    
    route_base = "/reporting/" 


    @login_required
    @route("/course-view/<school_subject_id>/<course_id>/<student_id>",methods=Api.GET)
    def CourseView(self,school_subject_id, course_id, student_id):
        from ..course_learning_views.course_view_controller import CourseView
        return CourseView.courseBySubject(self,school_subject_id,course_id,student_id)

    @login_required
    @route("/monitoring-student-view",defaults={"student_id":0},methods=Api.GET)
    @route("/monitoring-student-view/<student_id>",methods=Api.GET)
    def MonitoringStudentView(self,student_id):
        from ..students.dashboard_controller import DashboardStudentView
        return DashboardStudentView.monitoring(self,student_id)
