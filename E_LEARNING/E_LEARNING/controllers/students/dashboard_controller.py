from sqlalchemy.dialects.mysql.types import YEAR
from sqlalchemy.orm import selectinload
from E_LEARNING.utilities.flask.flask_menu import is_visible
from ...imports import *


class DashboardStudentView(Api):
    route_prefix = ""
    route_base = "/student/dashboard/"

    @login_required
    @role_required(role=ROLES.Student.value)
    @route("", methods=Api.GET)
    def index(self):
        student_id = current_user.id
        role = current_user.role
        # -api
        courses_report_url = url_for(
            "DashboardStudentManager:getCoursesReport", student_id=student_id
        )
        enrollments_report_url = url_for(
            "DashboardStudentManager:getEnrollmentsReport", student_id=student_id
        )
        message_box_report_url = url_for(
            "MessagingManager:getMessageCountRead",
            id_user=student_id,
            role=role,
            is_read=False,
        )
        course_chapter_contents_report_url = url_for(
            "DashboardStudentManager:getCourseChapterContentsReport_1",
            student_id=student_id,
        )
        dt_start = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)
        calendar_assistance_report_url = url_for(
            "DashboardStudentManager:getCalendarAssistanceReport",
            student_id=student_id,
            date_start=dt_start,
        )
        list_tasks_url = url_for(
            "DashboardStudentManager:getListTasks",
            student_id=student_id,
            date_start=dt_start,
        )

        # -links
        course_list_url = url_for("CourseView:listCourseStudent")
        enrollement_list_url = url_for("CourseView:listCourseHistory")
        instructor_list_url = url_for("InstructorStudentView:list")
        subject_list_url = url_for("SubjectStudentView:index")
        message_box_list_url = url_for("MessagingView:index")
        calendar_assistance_url = url_for("CalendarAssistanceStudentView_accepted")

        return render_template(
            "/students/dashboard/dashboard.html",
            courses_report_url=courses_report_url,
            enrollments_report_url=enrollments_report_url,
            message_box_report_url=message_box_report_url,
            course_chapter_contents_report_url=course_chapter_contents_report_url,
            list_tasks_url=list_tasks_url,
            calendar_assistance_report_url=calendar_assistance_report_url,
            # view
            course_list_url=course_list_url,
            enrollement_list_url=enrollement_list_url,
            instructor_list_url=instructor_list_url,
            subject_list_url=subject_list_url,
            message_box_list_url=message_box_list_url,
            calendar_assistance_url=calendar_assistance_url,
        )

    @route("/monitoring", defaults={"student_id": -1}, methods=["GET"])
    @route("/monitoring/<int:student_id>", methods=["GET"])
    @login_required
    def monitoring(self, student_id):
        from ..commun.country_controller import CountryManager

        role = current_user.role
        current_user_id = current_user.id

        if role == ROLES.Student.value:
            student_id = current_user_id 

        # Check if the student_id is valid
        if role == ROLES.Student.value and student_id != current_user_id:
            abort(401)

        # Retrieve the student profile
        student = StudentProfile.query.get(student_id)

        # If the user is an instructor, check if the student belongs to the instructor's course
        if role == ROLES.Instructor.value:
            allowed = dbSession.query(
                exists().where(
                    and_(
                        InstructorStudentSubjectQualificationView.instructor_id
                        == current_user_id,
                        InstructorStudentSubjectQualificationView.student_id
                        == student_id,
                    )
                )
            ).scalar()
            if not allowed:
                abort(401)

        # If the user is a school, check if the student belongs to that school
        if role == ROLES.School.value:
            st = Student.query.get(student_id)
            if not st or st.school_id != current_user_id:
                abort(401)

        # Chargement des données
        img = getImage(student.image)
        setattr(student, "image", img)

        country = (CountryManager()).getCountry(student.country_id)

        enrollments = (
            EnrollmentCourseView.query.filter_by(student_id=student_id)
            .order_by(EnrollmentCourseView.last_activity.desc())
            .all()
        )
        progress_courses = (
            CourseProgressView.query.filter_by(student_id=student_id)
            .order_by(CourseProgressView.enrollment_id.desc())
            .all()
        )
        quiz_results = (
            StudentQuizResultView.query.filter_by(student_id=student_id)
            .order_by(StudentQuizResultView.latest_timestamp.desc())
            .all()
        )
        demands = (
            StudentInstructorCalendarAssistanceView.query.filter_by(
                student_id=student_id
            )
            .order_by(StudentInstructorCalendarAssistanceView.date_demand.desc())
            .all()
        )
        activity = (
            StudentActivityView.query.filter_by(student_id=student_id)
            .order_by(StudentActivityView.date_activity.desc())
            .limit(10)
            .all()
        )
        log_connections = (
            UserConnectionLog.query.filter_by(
                user_id=student_id, role=ROLES.Student.value
            )
            .order_by(UserConnectionLog.timestamp.desc())
            .limit(10)
            .all()
        )

        return render_template(
            "commun/student/monitoring.html",
            student=student,
            country=country,
            enrollments=enrollments,
            progress_courses=progress_courses,
            quiz_results=quiz_results,
            demands=demands,
            activity=activity,
            log_connections=log_connections,
        )


# ---------------Api


class DashboardStudentManager(Api):

    route_base = "/student-dashboard-manager/"

    @route("/courses-report/<student_id>", methods=Api.GET)
    @limiter.limit(limit.medium, error_message=limit.medium)
    @auth.login_required
    def getCoursesReport(self, student_id):
        # time.sleep(3)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            q = DashboardStudentCourseView.query.filter_by(
                student_id=student_id
            ).one_or_none()
            if not q:
                return notFound

            return Api.json_response(HTTPStatus.OK, q.serialize())
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/enrollments-report/<student_id>", methods=Api.GET)
    @limiter.limit(limit.medium, error_message=limit.medium)
    @auth.login_required
    def getEnrollmentsReport(self, student_id):
        # time.sleep(4)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            enr = DashboardStudentEnrollementView.query.filter_by(
                student_id=student_id
            ).one_or_none()
            if enr is None:
                return notFound

            enr = enr.serialize()

            return Api.json_response(HTTPStatus.OK, enr)
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/course-chapter-contents-report/<student_id>",
        defaults={"date_start": None, "date_end": None},
        methods=Api.GET,
    )
    @route(
        "/course-chapter-contents-report/<student_id>/<date_start>/<date_end>",
        methods=Api.GET,
    )
    @limiter.limit(limit.medium, error_message=limit.medium)
    @auth.login_required
    def getCourseChapterContentsReport(self, student_id, date_start, date_end):
        # time.sleep(5)
        if date_start is None and date_end is None:
            date_end = datetime.today()
            date_start = datetime.today().replace(year=date_end.year - 1)

        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = DashboardStudentCourseChapterContentSP(
                student_id, date_start, date_end
            )
            if qList is None or not len(qList):
                return notFound

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/calendar-assistance-report/<student_id>/<date_start>", methods=Api.GET)
    @limiter.limit(limit.medium, error_message=limit.medium)
    @auth.login_required
    def getCalendarAssistanceReport(self, student_id, date_start):
        # time.sleep(4)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            ca = DashboardStudentCalendarAssistanceView.query.filter_by(
                student_id=student_id
            ).one_or_none()
            if ca is None:
                return notFound

            ca = ca.serialize()

            return Api.json_response(HTTPStatus.OK, ca)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-tasks/<student_id>/<date_start>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListTasks(self, student_id, date_start):
        # time.sleep(6)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            cl = (
                StudentCalendarAssistanceCountView.query.options(noload("*"))
                .filter_by(student_id=student_id)
                .filter(StudentCalendarAssistanceCountView.end >= date_start)
                .order_by(StudentCalendarAssistanceCountView.start)
                .all()
            )
            if not cl:
                return notFound
            cl = [i.serialize() for i in cl]

            return Api.json_response(HTTPStatus.OK, cl)
        except Exception as inst:
            return Api.json_exception(inst)
