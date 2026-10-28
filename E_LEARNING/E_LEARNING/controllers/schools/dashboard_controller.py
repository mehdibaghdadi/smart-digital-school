from sqlalchemy.dialects.mysql.types import YEAR
from ...imports import  *

class DashboardSchoolView(Api):
    route_prefix = ""    
    route_base = "/school/dashboard/" 

    @login_required
    @role_required(role=ROLES.School.value)
    @route("",methods=Api.GET)
    def index(self):  
        school_id = current_user.id
        role = current_user.role
        #-api
        courses_report_url = url_for('DashboardSchoolManager:getCoursesReport',school_id=school_id)      
        enrollments_report_url = url_for('DashboardSchoolManager:getEnrollmentsReport',school_id=school_id)      
        message_box_report_url = url_for('MessagingManager:getMessageCountRead',id_user=school_id,role=role,is_read=False)  
        course_chapter_contents_report_url = url_for('DashboardSchoolManager:getCourseChapterContentsReport_1',school_id=school_id)        
        calendar_assistance_report_url = url_for('DashboardSchoolManager:getCalendarAssistanceReport',school_id=school_id)      
        subjectExist= (DashboardSchoolManager()).ifSubjectExist(school_id=school_id)
        dt_start = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)        
        list_tasks_url = url_for('DashboardSchoolManager:getListTasks',school_id=school_id,date_start=dt_start)  
        
        #-links
        course_list_url = url_for("ReportingSchoolView:reportInstructorCourses")
        enrollement_list_url = url_for("ReportingSchoolView:reportInstructorEnrollmentCourses")        
        course_list_online_url = url_for("ReportingSchoolView:reportInstructorCourses")
        calendar_assistance_url = url_for("ReportingSchoolView:reportCoursesAssistance")
        message_box_list_url = url_for("MessagingView:index")
        return render_template("/schools/dashboard.html",
                               subjectExist = subjectExist,
                               courses_report_url=courses_report_url,
                               enrollments_report_url=enrollments_report_url,
                               message_box_report_url=message_box_report_url,
                               course_chapter_contents_report_url=course_chapter_contents_report_url,
                               calendar_assistance_report_url = calendar_assistance_report_url,
                               list_tasks_url = list_tasks_url,
                               #view
                               course_list_url = course_list_url,
                               enrollement_list_url = enrollement_list_url,
                               course_list_online_url = course_list_online_url,
                               calendar_assistance_url = calendar_assistance_url,
                               message_box_list_url = message_box_list_url,
                               )

#---------------Api

class DashboardSchoolManager(Api):  

    route_base = "/school-dashboard-manager/"

    @route("/courses-report/<school_id>",methods=Api.GET)
    @limiter.limit(limit.medium,error_message=limit.medium)
    @auth.login_required
    def getCoursesReport(self,school_id):
        #time.sleep(3)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            qList = DashboardSchoolCourseView.query.filter_by(school_id=school_id).all()
            if not qList:
                return notFound   

            qList = [ i.serialize() for i in qList] 

            return Api.json_response(HTTPStatus.OK,qList)
        except Exception as inst :
            return Api.json_exception(inst)  
        
    @route("/enrollments-report/<school_id>",methods=Api.GET)
    @limiter.limit(limit.medium,error_message=limit.medium)
    @auth.login_required
    def getEnrollmentsReport(self,school_id):
        #time.sleep(4)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            enr = DashboardSchoolEnrollementView.query.filter_by(school_id=school_id).one_or_none()
            if enr is None:
                return notFound   

            enr =enr.serialize()

            return Api.json_response(HTTPStatus.OK,enr)
        except Exception as inst :
            return Api.json_exception(inst) 

     
    @route("/calendar-assistance-report/<school_id>",methods=Api.GET)
    @limiter.limit(limit.medium,error_message=limit.medium)
    @auth.login_required
    def getCalendarAssistanceReport(self,school_id):
        #time.sleep(4)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            ca = DashboardSchoolCalendarAssistanceView.query.filter_by(school_id=school_id).one_or_none()
            if ca is None:
                return notFound   

            ca =ca.serialize()

            return Api.json_response(HTTPStatus.OK,ca)
        except Exception as inst :
            return Api.json_exception(inst) 


    @route("/course-chapter-contents-report/<school_id>", defaults={'date_start': None,'date_end': None},methods=Api.GET)
    @route("/course-chapter-contents-report/<school_id>/<date_start>/<date_end>",methods=Api.GET)
    @limiter.limit(limit.medium,error_message=limit.medium)
    @auth.login_required
    def getCourseChapterContentsReport(self,school_id,date_start,date_end):
        #time.sleep(5)
        if date_start is None and date_end is None:
             date_end= datetime.today()
             date_start= datetime.today().replace(year=date_end.year-100)

        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            qList = DashboardSchoolCourseChapterContentSP(school_id,date_start,date_end)
            if qList is None or not len(qList):
                return notFound 

            return Api.json_response(HTTPStatus.OK,qList)
        except Exception as inst :
            return Api.json_exception(inst)  

    # check if exists
    def ifSubjectExist(self,school_id):          
        try: 
            rslt = dbSession.query(SchoolSubjectView.query.filter_by(school_id=school_id).exists()).scalar()
            return rslt
        except Exception as inst :
            Api.log_exception(inst)
            return False
    
    @route("/list-tasks/<school_id>/<date_start>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListTasks(self,school_id,date_start):  
        #time.sleep(6)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            cl = SchoolCalendar.query.options(noload('*'))\
                                                         .filter_by(school_id=school_id)\
                                                         .filter(SchoolCalendar.end>=date_start)\
                                                         .order_by(SchoolCalendar.start)\
                                                         .all()
            if not cl:
                return notFound 
            cl = [ i.serialize() for i in cl]  
          
            return Api.json_response(HTTPStatus.OK,cl) 
        except Exception as inst :
            return Api.json_exception(inst)         