from ...imports import  *

class CalendarEventSchoolView(Api):
    route_prefix = ""    
    route_base = "/school/calendar-event/" 

    @login_required
    @role_required(role=ROLES.School.value)
    @route("/",methods=Api.GET)
    def index(self):  
        school_id = current_user.id
        s_api = CalendarEventSchoolManager()
        list_tasks = s_api.getListTasks(school_id)        
        url_save_update = url_for("CalendarEventSchoolManager:saveUpdate",school_id=school_id)  
        
        return render_template("/schools/calendar/calendar-planning-event.html",
                               list_tasks = list_tasks,
                               url_save_update = url_save_update)

#---------------Api
class CalendarEventSchoolManager(Api):  
    route_base = "/school-calendar-event-manager/"
    
    @route("/list-tasks/<school_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListTasks(self,school_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            cl = SchoolCalendar.query.options(noload('*')).filter_by(school_id=school_id)\
                                                         .order_by(SchoolCalendar.start)\
                                                         .all()
            if not cl:
                return notFound 
            cl = [ i.serialize() for i in cl]  
          
            return Api.json_response(HTTPStatus.OK,cl) 
        except Exception as inst :
            return Api.json_exception(inst)     
        
    @route("/list-tasks-from/<school_id>/<date_start>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListTasksFrom(self,school_id,date_start):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            cl = SchoolCalendar.query.options(noload('*'))\
                                   .filter_by(school_id=school_id)\
                                   .filter((SchoolCalendar.start>=date_start) | (date_start<=SchoolCalendar.end))\
                                   .order_by(SchoolCalendar.start.desc())\
                                   .all()
            if not cl:
                return notFound 
            cl = [ i.serialize() for i in cl]  
          
            return Api.json_response(HTTPStatus.OK,cl) 
        except Exception as inst :
            return Api.json_exception(inst)


    @route("/save-update/<school_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def saveUpdate(self,school_id):  
        #time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        try:
    
            calendar_list = json.loads(request.data)
            if not school_id or not calendar_list :
                return notFound
    
            school_id = int(school_id)

            list_insert = [ SchoolCalendar(
                                               title=x['title'],                                               
                                               start=convertTimezoneToDate(x['start']),
                                               end=convertTimezoneToDate(x['end']),
                                               allDay=x['allDay'],
                                               backgroundColor=x['backgroundColor'],
                                               school_id=school_id)  
                                            for x in calendar_list if (x['id'] <= 0)] 
            
            list_exist = [ SchoolCalendar(id=x['id'],
                                              title=x['title'],                                              
                                              start=convertTimezoneToDate(x['start']),
                                              end=convertTimezoneToDate(x['end']),
                                              allDay=x['allDay'],
                                              backgroundColor=x['backgroundColor'])  
                                            for x in calendar_list if (x['id'] > 0)] 
    
            if(len(list_exist) > 0):
                list_update = SchoolCalendar.query.options(noload('*')).filter_by(school_id=school_id)
                update_exists = False
                #update
                for s in list_exist:
                    for d in list_update:
                        if d.id == s.id and (d.title != s.title or d.start != s.start or d.end != s.end or d.allDay != s.allDay or d.backgroundColor != s.backgroundColor):
                            d.title = s.title
                            d.start = s.start
                            d.end = s.end
                            d.allDay = s.allDay
                            d.backgroundColor = s.backgroundColor
                            update_exists=True

                if update_exists:
                    dbSession.commit()
                #delete
                list_delete = [ e.id for e in list_update if e.id not in [x.id for x in list_exist]]
                if(len(list_delete) > 0):
                        dbSession.query(SchoolCalendar)\
                            .filter(SchoolCalendar.id.in_(list_delete),
                            SchoolCalendar.school_id == school_id).delete(synchronize_session=False)  
                        dbSession.commit()
            #insert
            if(len(list_insert) > 0):
                dbSession.add_all(list_insert)   
                dbSession.commit()

            return self.getListTasks(school_id)
        except Exception as inst :
            return Api.json_exception(inst) 