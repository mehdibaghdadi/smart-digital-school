from datetime import date
from ...imports import *


class CalendarAssistanceStudentView(Api):
    route_prefix = ""
    route_base = "/student/calendar-assistance/"

    @login_required
    @role_required(role=ROLES.Student.value)
    @route(
        "/ongoing",
        defaults={"accepted": -1},
        methods=Api.GET,
        endpoint="CalendarAssistanceStudentView_ongoing",
    )
    @route(
        "/canceled",
        defaults={"accepted": 0},
        methods=Api.GET,
        endpoint="CalendarAssistanceStudentView_canceled",
    )
    @route(
        "/accepted",
        defaults={"accepted": 1},
        methods=Api.GET,
        endpoint="CalendarAssistanceStudentView_accepted",
    )
    @route(
        "/done",
        defaults={"accepted": 2},
        methods=Api.GET,
        endpoint="CalendarAssistanceStudentView_done",
    )
    @route(
        "/all",
        defaults={"accepted": -2},
        methods=Api.GET,
        endpoint="CalendarAssistanceStudentView_all",
    )
    def index(self, accepted=None):
        student_id = current_user.id
        s_api = CalendarAssistanceStudentManager()
        demands_list = s_api.getListDemands(student_id, accepted)
        course_url = url_for("CourseView:courseBySubject_1")

        return render_template(
            "/students/assistance/calendar-demand-assistance.html",
            demands_list=demands_list,
            course_url=course_url,
        )


# ---------------Api
class CalendarAssistanceStudentManager(Api):
    route_base = "/student-calendar-assistance-manager/"

    @route(
        "/list-demands/<student_id>/<accepted>",
        defaults={"accepted": None},
        methods=Api.GET,
    )
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListDemands(self, student_id, param_accepted):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            ca = StudentInstructorCalendarAssistanceView.query.options(
                noload("*")
            ).filter_by(student_id=student_id)

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
                                == StudentInstructorCalendarAssistanceView.instructor_calendar_id,
                                InstructorCalendar.end >= datetime.today(),
                            ).exists(),
                            StudentInstructorCalendarAssistanceView.instructor_calendar_id
                            == None,
                        )
                    )
                case 2:
                    ca = ca.filter_by(accepted=True).filter(
                        InstructorCalendar.query.filter(
                            InstructorCalendar.id
                            == StudentInstructorCalendarAssistanceView.instructor_calendar_id,
                            InstructorCalendar.end < datetime.today(),
                        ).exists(),
                    )

            ca = ca.order_by(
                StudentInstructorCalendarAssistanceView.date_demand.desc()
            ).all()
            if not ca:
                return notFound
            ca = [i.serialize() for i in ca]

            return Api.json_response(HTTPStatus.OK, ca)
        except Exception as inst:
            return Api.json_exception(inst)