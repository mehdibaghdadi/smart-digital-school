from ...imports import  *

class CalendarEventInstructorView(Api):
    route_prefix = ""    
    route_base = "/instructor/calendar-event/" 

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/",methods=Api.GET)
    def index(self):  
        instructor_id = current_user.id
        s_api = CalendarEventInstructorManager()
        list_tasks = s_api.getListTasks(instructor_id)
        list_type_events = s_api.getListTypeEvents()
        url_save_update = url_for("CalendarEventInstructorManager:saveUpdate",instructor_id=instructor_id)
        url_list_demands_ids = url_for("CalendarAssistanceInstructorManager_list_demands_ids")
        url_view_list_demands_ids = url_for("CalendarAssistanceInstructorView_all_by_ids")
        
        return render_template("/instructors/calendar/calendar-planning-event.html",
                               list_tasks = list_tasks,
                               list_type_events = list_type_events,
                               url_list_demands_ids = url_list_demands_ids,
                               url_view_list_demands_ids = url_view_list_demands_ids,
                               url_save_update = url_save_update)

#---------------Api
class CalendarEventInstructorManager(Api):  
    route_base = "/instructor-calendar-event-manager/"
    
    @route("/list-tasks/<instructor_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListTasks(self,instructor_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            cl = InstructorCalendarAssistanceCountView.query.options(noload('*')).filter_by(instructor_id=instructor_id)\
                                                         .order_by(InstructorCalendarAssistanceCountView.start)\
                                                         .all()
            if not cl:
                return notFound 
            cl = [ i.serialize() for i in cl]  
          
            return Api.json_response(HTTPStatus.OK,cl) 
        except Exception as inst :
            return Api.json_exception(inst)    
    
    @route("/list-tasks-from/<instructor_id>/<date_start>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListTasksFrom(self,instructor_id,date_start):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            cl = InstructorCalendarView.query.options(noload('*'))\
                                   .filter_by(instructor_id=instructor_id)\
                                   .filter((InstructorCalendar.start>=date_start) | (date_start<=InstructorCalendar.end))\
                                   .order_by(InstructorCalendar.start.desc())\
                                   .all()
            if not cl:
                return notFound 
            cl = [ i.serialize() for i in cl]  
          
            return Api.json_response(HTTPStatus.OK,cl) 
        except Exception as inst :
            return Api.json_exception(inst)

    @route("/list-type-events",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListTypeEvents(self):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            
            language = g.current_language if g.current_language else "en"
            event_calendar_cl = f"event_calendar_{language}"
            column_to_select = getattr(EventCalendar, event_calendar_cl)

            # Query all records, but defer loading the other columns
            event_list = (
                EventCalendar.query.options(noload("*"))
                .with_entities(EventCalendar.id, column_to_select)
                .order_by(column_to_select)   
            )

            # Convert the query result to a list of dictionaries
            event_dict = [
                {"id": s.id, "event_calendar": getattr(s, event_calendar_cl)}
                for s in event_list
            ]
            return Api.json_response(HTTPStatus.OK,event_dict) 
        except Exception as inst :
            return Api.json_exception(inst)   

    @route("/save-update/<instructor_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def saveUpdate(self,instructor_id):  
        #time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        try:
    
            calendar_list = json.loads(request.data)
            if not instructor_id or not calendar_list :
                return notFound
    
            instructor_id = int(instructor_id)

            list_insert = [ InstructorCalendar(
                                               title=x['title'],
                                               event_calendar_id=x['event_calendar_id'],
                                               start=convertTimezoneToDate(x['start']),
                                               end=convertTimezoneToDate(x['end']),
                                               allDay=x['allDay'],
                                               event_description=x['event_description'],
                                               backgroundColor=x['backgroundColor'],
                                               instructor_id=instructor_id)  
                                            for x in calendar_list if (x['id'] <= 0)] 
            
            list_exist = [ InstructorCalendar(id=x['id'],
                                              title=x['title'],
                                              event_calendar_id=x['event_calendar_id'],
                                              start=convertTimezoneToDate(x['start']),
                                              end=convertTimezoneToDate(x['end']),
                                              allDay=x['allDay'],
                                               event_description=x['event_description'],
                                              backgroundColor=x['backgroundColor'])  
                                            for x in calendar_list if (x['id'] > 0)] 
    
            if(len(list_exist) > 0):
                list_update = InstructorCalendar.query.options(noload('*')).filter_by(instructor_id=instructor_id)
                update_exists = False
                #update
                for s in list_exist:
                    for d in list_update:
                        if d.id == s.id and (d.event_calendar_id != s.event_calendar_id or d.start != s.start or d.end != s.end or d.allDay != s.allDay or d.backgroundColor != s.backgroundColor):
                            d.title = s.title
                            d.event_calendar_id = s.event_calendar_id
                            d.start = s.start
                            d.end = s.end
                            d.allDay = s.allDay
                            d.event_description = s.event_description
                            d.backgroundColor = s.backgroundColor
                            update_exists=True

                if update_exists:
                    dbSession.commit()
                #delete
                list_delete = [ e.id for e in list_update if e.id not in [x.id for x in list_exist]]
                if(len(list_delete) > 0):
                        dbSession.query(InstructorCalendar)\
                            .filter(InstructorCalendar.id.in_(list_delete),
                            InstructorCalendar.instructor_id == instructor_id).delete(synchronize_session=False)  
                        dbSession.commit()
            #insert
            if(len(list_insert) > 0):
                dbSession.add_all(list_insert)   
                dbSession.commit()

            return self.getListTasks(instructor_id)
        except Exception as inst :
            return Api.json_exception(inst) 