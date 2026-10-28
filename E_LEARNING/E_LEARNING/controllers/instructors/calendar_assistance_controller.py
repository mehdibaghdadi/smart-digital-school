from datetime import date
from hashlib import new
from ...imports import *


class CalendarAssistanceInstructorView(Api):
    route_prefix = ""
    route_base = "/instructor/calendar-assistance/"

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route(
        "/ongoing",
        defaults={"accepted": -1},
        methods=Api.GET,
        endpoint="CalendarAssistanceInstructorView_ongoing",
    )
    @route(
        "/canceled",
        defaults={"accepted": 0},
        methods=Api.GET,
        endpoint="CalendarAssistanceInstructorView_canceled",
    )
    @route(
        "/accepted",
        defaults={"accepted": 1},
        methods=Api.GET,
        endpoint="CalendarAssistanceInstructorView_accepted",
    )
    @route(
        "/done",
        defaults={"accepted": 2},
        methods=Api.GET,
        endpoint="CalendarAssistanceInstructorView_done",
    )
    @route(
        "/all",
        defaults={"accepted": -2},
        methods=Api.GET,
        endpoint="CalendarAssistanceInstructorView_all",
    )
    @route(
        "/all_by_ids",
        defaults={"accepted": 3, "list_calendar_assistance_ids": ""},
        methods=Api.GET,
        endpoint="CalendarAssistanceInstructorView_all_by_ids",
    )
    @route(
        "/all_by_ids/<list_calendar_assistance_ids>",
        defaults={"accepted": 3},
        methods=Api.GET,
        endpoint="CalendarAssistanceInstructorView_all_by_ids_main",
    )
    def index(self, accepted=None, list_calendar_assistance_ids=None):
        from .calendar_event_controller import CalendarEventInstructorManager

        instructor_id = current_user.id
        school_id = current_user.school_id
        s_api = CalendarAssistanceInstructorManager()
        demands_list = None

        if accepted == 3:
            demands_list = s_api.getListDemandsByIds(list_calendar_assistance_ids)
        else:
            demands_list = s_api.getListDemands(instructor_id, accepted)

        url_save_response = url_for(
            "CalendarAssistanceInstructorManager:saveResponseAssistance",
            instructor_id=instructor_id,
            param_accepted=accepted,
        )
        url_save_group_response = url_for(
            "CalendarAssistanceInstructorManager:saveResponseGroupAssistance",
            instructor_id=instructor_id,
            param_accepted=accepted,
        )
        url_update_file_attachement_assistance = url_for(
            "CalendarAssistanceInstructorManager:updateFileAttachementAssistance",
            instructor_id=instructor_id,
        )

        s_api_event = CalendarEventInstructorManager()
        dt = datetime.today()
        dt = dt.replace(hour=0, minute=0, second=0, microsecond=0)

        if accepted != -1:
            dt = datetime.min

        listTasksFromToday = s_api_event.getListTasksFrom(instructor_id, dt)
        list_type_events = s_api_event.getListTypeEvents()
        edit_chapter_section_url = url_for("CourseView:courseBySubject_1")

        return render_template(
            "/instructors/assistance/demand-assistance-list.html",
            demands_list=demands_list,
            url_save_response=url_save_response,
            url_save_group_response=url_save_group_response,
            url_update_file_attachement_assistance=url_update_file_attachement_assistance,
            edit_chapter_section_url=edit_chapter_section_url,
            listTasksFromToday=listTasksFromToday,
            list_type_events=list_type_events,
            instructor_id=instructor_id,
            school_id=school_id,
        )

    # ---------------Api


class CalendarAssistanceInstructorManager(Api):
    route_base = "/instructor-calendar-assistance-manager/"

    @route(
        "/list-demands/<instructor_id>/<accepted>",
        defaults={"accepted": None},
        methods=Api.GET,
    )
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListDemands(self, instructor_id, param_accepted):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            ca = InstructorCalendarAssistanceView.query.options(noload("*")).filter_by(
                instructor_id=instructor_id
            )

            match param_accepted:
                case -1:
                    ca = ca.filter_by(accepted=None)
                case 0:
                    ca = ca.filter_by(accepted=False)
                case 1:
                    ca = ca.filter_by(accepted=True).filter(
                        or_(
                            InstructorCalendar.query.filter(
                                InstructorCalendar.id
                                == InstructorCalendarAssistanceView.instructor_calendar_id,
                                InstructorCalendar.end >= datetime.today(),
                            ).exists(),
                            InstructorCalendarAssistanceView.instructor_calendar_id
                            == None,
                        )
                    )
                case 2:
                    ca = ca.filter_by(accepted=True).filter(
                        InstructorCalendar.query.filter(
                            InstructorCalendar.id
                            == InstructorCalendarAssistanceView.instructor_calendar_id,
                            InstructorCalendar.end < datetime.today(),
                        ).exists(),
                    )

            ca = ca.order_by(InstructorCalendarAssistanceView.date_demand.desc()).all()
            if not ca:
                return notFound
            ca = [i.serialize() for i in ca]

            return Api.json_response(HTTPStatus.OK, ca)
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/list-demands-ids",
        defaults={"list_instructor_calendar_assistance_ids": None},
        methods=Api.GET,
        endpoint="CalendarAssistanceInstructorManager_list_demands_ids",
    )
    @route(
        "/list-demands-ids/<list_instructor_calendar_assistance_ids>", methods=Api.GET
    )
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListDemandsByIds(self, list_instructor_calendar_assistance_ids):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        # time.sleep(3)
        try:
            if not list_instructor_calendar_assistance_ids:
                return notFound

            ids = list(list_instructor_calendar_assistance_ids.split(","))

            ca = InstructorCalendarAssistanceView.query.options(noload("*")).filter(
                InstructorCalendarAssistanceView.id.in_(ids)
            )

            ca = ca.order_by(InstructorCalendarAssistanceView.date_demand.desc()).all()
            if not ca:
                return notFound
            ca = [i.serialize() for i in ca]

            return Api.json_response(HTTPStatus.OK, ca)
        except Exception as inst:
            return Api.json_exception(inst)

    # Private: __getListDemandsById
    def __getListDemandsById(self, id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        # time.sleep(3)
        try:
            if not id:
                return notFound

            ca = (
                InstructorCalendarAssistanceView.query.options(noload("*"))
                .filter(InstructorCalendarAssistanceView.id == id)
                .one()
            )

            if not ca:
                return notFound

            return Api.json_response(HTTPStatus.OK, ca.serialize())
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/save-response-assistance/<instructor_id>/<param_accepted>", methods=Api.POST
    )
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def saveResponseAssistance(self, instructor_id, param_accepted):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        # time.sleep(5)
        try:
            assistance = json.loads(request.data)
            demand_id = assistance["demand_id"]
            accepted = assistance["accepted"]
            instructor_calendar_id = assistance["instructor_calendar_id"]
            response_demand = assistance["response_demand"]
            response_demand_link = assistance["response_demand_link"]
            attachment_url = assistance["attachment_url"]

            param_accepted = int(param_accepted) if representsInt(param_accepted) else 0
            demand_id = int(demand_id) if representsInt(demand_id) else 0
            accepted = int(accepted) if representsInt(accepted) else 0
            instructor_calendar_id = (
                int(instructor_calendar_id)
                if representsInt(instructor_calendar_id)
                else 0
            )

            q_assist = None

            if demand_id <= 0:
                return notFound

            q_assist = (
                InstructorCalendarAssistance.query.options(noload("*"))
                .filter_by(id=demand_id)
                .one_or_none()
            )

            if not q_assist:
                return notFound

            update_instructor_calendar_id = (
                instructor_calendar_id if instructor_calendar_id > 0 else None
            )

            if update_instructor_calendar_id:
                old_calendar = (
                    InstructorCalendar.query.options(noload("*"))
                    .filter_by(id=update_instructor_calendar_id)
                    .one_or_none()
                )
                if old_calendar:
                    old_calendar.event_description = (
                        response_demand
                        if not old_calendar.event_description
                        or len(old_calendar.event_description) <= 0
                        else old_calendar.event_description
                    )

            q_assist.instructor_calendar_id = update_instructor_calendar_id
            q_assist.accepted = accepted
            q_assist.response_demand = response_demand
            q_assist.response_demand_link = response_demand_link
            q_assist.attachment_url = (
                attachment_url if len(attachment_url) > 0 else q_assist.attachment_url
            )
            q_assist.acceptance_date = datetime.today()
            dbSession.commit()

            ca_response = self.__getListDemandsById(q_assist.id)
            return ca_response
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/save-response-group-assistance/<instructor_id>/<param_accepted>",
        methods=Api.POST,
    )
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def saveResponseGroupAssistance(self, instructor_id, param_accepted):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        # time.sleep(5)
        try:
            assistance = json.loads(request.data)
            isNew = assistance["isNew"]
            demand_group_ids = assistance["groupIds"]
            accepted = assistance["accepted"]
            instructor_calendar_id = assistance["instructor_calendar_id"]
            response_demand = assistance["response_demand"]
            response_demand_link = assistance["response_demand_link"]
            event_calendar_id = assistance["event_calendar_id"]
            event_calendar_title = assistance["event_calendar_title"]
            dateStr = assistance["dateStr"]
            dateEnd = assistance["dateEnd"]
            attachment_url = assistance["attachment_url"]
            new_calendar = None

            param_accepted = int(param_accepted) if representsInt(param_accepted) else 0

            if not demand_group_ids:
                return notFound

            # builds list ids
            demand_group_ids = list(demand_group_ids.split(","))

            if isNew:
                new_calendar = InstructorCalendar(
                    title=event_calendar_title,
                    event_calendar_id=event_calendar_id,
                    start=convertTimezoneToDate(dateStr),
                    end=convertTimezoneToDate(dateEnd),
                    allDay=0,
                    event_description=response_demand,
                    backgroundColor="#000000",
                    instructor_id=instructor_id,
                )

                dbSession.add(new_calendar)
                dbSession.commit()
                instructor_calendar_id = new_calendar.id  # get new id
            else:
                old_calendar = (
                    InstructorCalendar.query.options(noload("*"))
                    .filter_by(id=instructor_calendar_id)
                    .one_or_none()
                )
                if old_calendar:
                    old_calendar.event_description = (
                        response_demand
                        if not old_calendar.event_description
                        or len(old_calendar.event_description) <= 0
                        else old_calendar.event_description
                    )
                    dbSession.commit()

            instructor_calendar_id = (
                int(instructor_calendar_id)
                if representsInt(instructor_calendar_id)
                else 0
            )

            # insert
            InstructorCalendarAssistance.query.filter(
                InstructorCalendarAssistance.id.in_(demand_group_ids)
            ).update(
                {
                    InstructorCalendarAssistance.instructor_calendar_id: (
                        instructor_calendar_id if instructor_calendar_id > 0 else None
                    ),
                    InstructorCalendarAssistance.accepted: accepted,
                    InstructorCalendarAssistance.response_demand: response_demand,
                    InstructorCalendarAssistance.response_demand_link: response_demand_link,
                    InstructorCalendarAssistance.acceptance_date: datetime.today(),
                    InstructorCalendarAssistance.attachment_url: (
                        attachment_url
                        if len(attachment_url) > 0
                        else InstructorCalendarAssistance.attachment_url
                    ),
                },
                synchronize_session=False,
            )
            dbSession.commit()

            ca = InstructorCalendarAssistanceView.query.options(noload("*")).filter(
                InstructorCalendarAssistanceView.id.in_(demand_group_ids)
            )

            ca = ca.order_by(InstructorCalendarAssistanceView.date_demand.desc()).all()
            if not ca:
                return notFound
            ca = [i.serialize() for i in ca]

            ca_response = {
                "list_demand": ca,
                "new_calendar": new_calendar.serialize() if new_calendar else "{}",
                "isNew": isNew,
            }
            return Api.json_response(HTTPStatus.OK, ca_response)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/update-file-attachment-assistance/<instructor_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def updateFileAttachementAssistance(self, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.deletion_canceled)
        # time.sleep(5)
        try:
            assistance = json.loads(request.data)
            demand_id = assistance["demand_id"]
            attachment_url = assistance["attachment_url"]
            demand_id = int(demand_id) if representsInt(demand_id) else 0

            q_assist = None

            if demand_id <= 0:
                return notFound

            q_assist = (
                InstructorCalendarAssistance.query.options(noload("*"))
                .filter_by(id=demand_id)
                .one_or_none()
            )

            if not q_assist:
                return notFound

            InstructorCalendarAssistance.query.filter(
                InstructorCalendarAssistance.attachment_url == q_assist.attachment_url
            ).update(
                {
                    InstructorCalendarAssistance.attachment_url: (
                        None
                        if not attachment_url or len(attachment_url) <= 0
                        else attachment_url
                    ),
                },
                synchronize_session=False,
            )
            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, q_assist.serialize())
        except Exception as inst:
            return Api.json_exception(inst)