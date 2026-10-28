from sqlalchemy.dialects.mysql.types import YEAR

from E_LEARNING.utilities.flask.flask_menu import is_visible
from ...imports import  *

class CalendarStudentView(Api):
    route_prefix = ""    
    route_base = "/student/my-calendar/" 

    @login_required
    @role_required(role=ROLES.Student.value)
    @route("",methods=Api.GET)
    def index(self):  
        student_id = current_user.id
        role = current_user.role
        #-api
        dt_start = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)        
        list_tasks_url = url_for('CalendarStudentManager:getListTasks',student_id=student_id,date_start=dt_start)  
        url_list_demands_ids = url_for("CalendarStudentManager_list_demands_ids")
        
        return render_template("/students/calendar/my-calendar.html",
                               list_tasks_url=list_tasks_url,
                               url_list_demands_ids = url_list_demands_ids
                               )

#---------------Api

class CalendarStudentManager(Api):  
    route_base = "/student-calendar-manager/"           

    
    @route("/list-demands-ids",defaults={'list_instructor_calendar_assistance_ids': None},methods=Api.GET,endpoint="CalendarStudentManager_list_demands_ids")
    @route("/list-demands-ids/<list_instructor_calendar_assistance_ids>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListDemandsByIds(self,list_instructor_calendar_assistance_ids):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found) 
        #time.sleep(3)
        try: 
            if not list_instructor_calendar_assistance_ids:
                return notFound 

            ids= list(list_instructor_calendar_assistance_ids.split(","))

            ca = InstructorCalendarAssistanceView.query.options(noload('*'))\
                .filter(InstructorCalendarAssistanceView.id.in_(ids))
            
            ca =ca.order_by(InstructorCalendarAssistanceView.date_demand.desc()).all()
            if not ca:
                return notFound 
            ca = [ i.serialize() for i in ca]  
          
            return Api.json_response(HTTPStatus.OK,ca) 
        except Exception as inst :
            return Api.json_exception(inst)
   

    @route("/list-tasks/<student_id>/<date_start>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListTasks(self,student_id,date_start):  
        #time.sleep(6)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            cl = StudentCalendarAssistanceCountView.query.options(noload('*'))\
                                                         .filter_by(student_id=student_id)\
                                                         .order_by(StudentCalendarAssistanceCountView.start)\
                                                         .all()
            if not cl:
                return notFound 
            cl = [ i.serialize() for i in cl]  
          
            return Api.json_response(HTTPStatus.OK,cl) 
        except Exception as inst :
            return Api.json_exception(inst)  