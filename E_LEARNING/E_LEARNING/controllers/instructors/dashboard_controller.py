from sqlalchemy.dialects.mysql.types import YEAR
from ...imports import  *

class DashboardInstructorView(Api):
    route_prefix = ""    
    route_base = "/instructor/dashboard/" 

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("",methods=Api.GET)
    def index(self):  
        instructor_id = current_user.id
        role = current_user.role
        #-api
        courses_report_url = url_for('DashboardInstructorManager:getCoursesReport',instructor_id=instructor_id)      
        enrollments_report_url = url_for('DashboardInstructorManager:getEnrollmentsReport',instructor_id=instructor_id)      
        message_box_report_url = url_for('MessagingManager:getMessageCountRead',id_user=instructor_id,role=role,is_read=False)      
        calendar_assistance_report_url = url_for('DashboardInstructorManager:getCalendarAssistanceReport',instructor_id=instructor_id)      
        course_chapter_contents_report_url = url_for('DashboardInstructorManager:getCourseChapterContentsReport_1',instructor_id=instructor_id)        
        dt_start = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)        
        list_tasks_url = url_for('DashboardInstructorManager:getListTasks',instructor_id=instructor_id,date_start=dt_start)  
        subjectExist= (DashboardInstructorManager()).ifSubjectExist(instructor_id=instructor_id)
        #-links
        course_list_url = url_for("CourseInstructorView:index")
        enrollement_list_url = url_for("ReportingInstructorView:reportEnrollmentCourses")
        calendar_assistance_url = url_for("CalendarAssistanceInstructorView_ongoing")
        course_list_online_url = url_for("CourseInstructorView:visibility_2")

        message_box_list_url = url_for("MessagingView:index")
        
        return render_template("/instructors/dashboard.html",
                               subjectExist = subjectExist,
                               courses_report_url=courses_report_url,
                               enrollments_report_url=enrollments_report_url,
                               message_box_report_url = message_box_report_url,
                               course_chapter_contents_report_url=course_chapter_contents_report_url,
                               calendar_assistance_report_url = calendar_assistance_report_url,
                               list_tasks_url=list_tasks_url,
                               #view
                               course_list_url = course_list_url,
                               enrollement_list_url = enrollement_list_url,
                               calendar_assistance_url = calendar_assistance_url,
                               course_list_online_url = course_list_online_url,
                               message_box_list_url = message_box_list_url,
                               )

#---------------Api

class DashboardInstructorManager(Api):  

    route_base = "/instructor-dashboard-manager/"

    @route("/courses-report/<instructor_id>",methods=Api.GET)
    @limiter.limit(limit.medium,error_message=limit.medium)
    @auth.login_required
    def getCoursesReport(self,instructor_id):
        #time.sleep(3)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            qList = DashboardInstructorCourseView.query.filter_by(instructor_id=instructor_id).all()
            if not qList:
                return notFound   

            qList = [ i.serialize() for i in qList] 

            return Api.json_response(HTTPStatus.OK,qList)
        except Exception as inst :
            return Api.json_exception(inst)  
        
    @route("/enrollments-report/<instructor_id>",methods=Api.GET)
    @limiter.limit(limit.medium,error_message=limit.medium)
    @auth.login_required
    def getEnrollmentsReport(self,instructor_id):
        #time.sleep(4)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            enr = DashboardInstructorEnrollementView.query.filter_by(instructor_id=instructor_id).one_or_none()
            if enr is None:
                return notFound   

            enr =enr.serialize()

            return Api.json_response(HTTPStatus.OK,enr)
        except Exception as inst :
            return Api.json_exception(inst)  

        
    @route("/calendar-assistance-report/<instructor_id>",methods=Api.GET)
    @limiter.limit(limit.medium,error_message=limit.medium)
    @auth.login_required
    def getCalendarAssistanceReport(self,instructor_id):
        #time.sleep(4)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            ca = DashboardInstructorCalendarAssistanceView.query.filter_by(instructor_id=instructor_id).one_or_none()
            if ca is None:
                return notFound   

            ca =ca.serialize()

            return Api.json_response(HTTPStatus.OK,ca)
        except Exception as inst :
            return Api.json_exception(inst) 


    @route("/course-chapter-contents-report/<instructor_id>", defaults={'date_start': None,'date_end': None},methods=Api.GET)
    @route("/course-chapter-contents-report/<instructor_id>/<date_start>/<date_end>",methods=Api.GET)
    @limiter.limit(limit.medium,error_message=limit.medium)
    @auth.login_required
    def getCourseChapterContentsReport(self,instructor_id,date_start,date_end):
        #time.sleep(5)
        if date_start is None and date_end is None:
             date_end= datetime.today()
             date_start= datetime.today().replace(year=date_end.year-100)

        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            qList = DashboardInstructorCourseChapterContentSP(instructor_id,date_start,date_end)
            if qList is None or not len(qList):
                return notFound 

            return Api.json_response(HTTPStatus.OK,qList)
        except Exception as inst :
            return Api.json_exception(inst)  

    @route("/list-tasks/<instructor_id>/<date_start>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListTasks(self,instructor_id,date_start):  
        #time.sleep(6)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            cl = InstructorCalendarAssistanceCountView.query.options(noload('*'))\
                                                         .filter_by(instructor_id=instructor_id)\
                                                         .filter(InstructorCalendarAssistanceCountView.start>=date_start)\
                                                         .order_by(InstructorCalendarAssistanceCountView.start)\
                                                         .all()
            if not cl:
                return notFound 
            cl = [ i.serialize() for i in cl]  
          
            return Api.json_response(HTTPStatus.OK,cl) 
        except Exception as inst :
            return Api.json_exception(inst)  


    # check if exists
    def ifSubjectExist(self,instructor_id):          
        try: 
            rslt = dbSession.query(InstructorSubjectView.query.filter_by(instructor_id=instructor_id).exists()).scalar()
            return rslt
        except Exception as inst :
            Api.log_exception(inst)
            return False