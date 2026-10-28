from ...imports import *


# ---------------view
class CourseInstructorView(Api):
    route_prefix = ""
    route_base = "/instructor/course/"

    # private function : communs infos for course list
    def __index_case(self, instructor_id, course_list):
        course_edit_url = url_for("CourseInstructorView:edit_1")
        course_create_url = url_for("CourseInstructorView:course_start")
        course_visibility_url = url_for(
            "CourseInstructorManager:updateVisibility", instructor_id=instructor_id
        )
        course_delete_url = url_for(
            "CourseInstructorManager:delete_all", instructor_id=instructor_id
        )
        course_chapter_list_url = url_for(
            "ChapterInstructorManager:getListChapter", course_id="course_id"
        )
        course_chapter_edit_url = url_for("ChapterInstructorView:edit_1")
        course_quiz_list_url = url_for("QuizInstructorManager:get_quizzes_by_scope",scope="course" ,scope_id="-100")
        course_quiz_edit_url = url_for("QuizInstructorView:edit_1") 

        return render_template(
            "/instructors/course/course-list.html",
            course_list=course_list,
            course_edit_url=course_edit_url,
            course_create_url=course_create_url,
            course_visibility_url=course_visibility_url,
            course_delete_url=course_delete_url,
            course_chapter_list_url=course_chapter_list_url,
            course_chapter_edit_url=course_chapter_edit_url,
            course_quiz_list_url= course_quiz_list_url,
            course_quiz_edit_url=course_quiz_edit_url
        )

   #----------- course home 
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/course-start", methods=Api.GET)
    def course_start(self):
        instructor_id = current_user.id
        course_create_url = url_for("CourseInstructorView:create_manually")
        course_ai_wizard = url_for("CourseAiInstructorView:course_ai_wizard")
        return render_template(
            "/instructors/course/course-start.html",
            instructor_id =instructor_id, 
            course_create_url=course_create_url,
            course_ai_wizard=course_ai_wizard
        )
   

    # --------- create course manually
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/create-manually", methods=Api.GET)
    def create_manually(self):
        instructor_id = current_user.id
        s_api = CourseInstructorManager()

        from ..packages.package_controller import PackageManager

        pack = (PackageManager()).get(current_user.package_id)
        max_courses_per_prof = pack["max_courses_per_prof"]
        course_count = s_api.getCountCourses(instructor_id)
        max_courses_per_prof_exceeded = course_count >= max_courses_per_prof

        language = s_api.getListLanguage()
        subject = s_api.getListSubject(instructor_id)

        course_chapter_edit_url = url_for("ChapterInstructorView:edit_1")
        course_update_url = url_for(
            "CourseInstructorManager:saveUpdate", instructor_id=instructor_id
        )
        course_edit_url = url_for("CourseInstructorView:edit_1")
        return render_template(
            "/instructors/course/course-edit.html",
            course_id=0,
            subject=subject,
            language=language,
            course_update_url=course_update_url,
            course_edit_url=course_edit_url,
            max_courses_per_prof=max_courses_per_prof,
            max_courses_per_prof_exceeded=max_courses_per_prof_exceeded,
        )

    # ----------- edit course
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/edit", defaults={"id": 0}, methods=Api.GET)
    @route("/edit/<id>", methods=Api.GET)
    def edit(self, id=0):
        instructor_id = current_user.id
        id = int(id)
        s_api = CourseInstructorManager()

        from ..packages.package_controller import PackageManager

        pack = (PackageManager()).get(current_user.package_id)
        max_courses_per_prof = pack["max_courses_per_prof"]
        course_count = s_api.getCountCourses(instructor_id)
        max_courses_per_prof_exceeded = course_count >= max_courses_per_prof

        course_instructor_view360_url = ""
        course = s_api.getCourse(id)

        if course.status_code != 200:
            abort(404)
        else:
            current_course = course.json["response"]
            course_instructor_view360_url = url_for(
                "CourseInstructorView:courseBySubjectView360_0",
                school_subject_id=current_course["school_subject_id"],
                course_id=current_course["id"],
            )

        language = s_api.getListLanguage()
        subject = s_api.getListSubject(instructor_id)
        course_update_url = url_for(
            "CourseInstructorManager:saveUpdate", instructor_id=instructor_id
        )
        course_create_url = url_for("CourseInstructorView:course_start")
        course_list_url = url_for("CourseInstructorView:index")

        from .course_chapter_controller import ChapterInstructorManager

        s_chapter_api = ChapterInstructorManager()
        chapter = s_chapter_api.getListChapter(id)
        course_chapter_edit_url = url_for("ChapterInstructorView:edit_1")
        course_chapter_create_url = url_for(
            "ChapterInstructorView:create", course_id=id
        )
        course_chapter_update_url = url_for(
            "ChapterInstructorManager:saveUpdate", course_id=id
        )
        course_chapter_delete_url = url_for(
            "ChapterInstructorManager:delete_all", course_id=id
        )
        course_chapter_sequence_update_url = url_for(
            "ChapterInstructorManager:saveUpdateSequence", course_id=id
        )
        course_chapter_visibility_url = url_for(
            "ChapterInstructorManager:updateVisibility", course_id=id
        )

        course_quiz_sequence_update_url = url_for(
            "QuizInstructorManager:saveUpdateSequence", course_id=id
        )

        course_quiz_visibility_url = url_for("QuizInstructorManager:updateVisibility")

        return render_template(
            "/instructors/course/course-edit.html",
            course_id=id,
            course=course,
            chapter=chapter,
            subject=subject,
            language=language,
            course_update_url=course_update_url,
            course_create_url=course_create_url,
            course_list_url=course_list_url,
            course_chapter_edit_url=course_chapter_edit_url,
            course_chapter_update_url=course_chapter_update_url,
            course_chapter_delete_url=course_chapter_delete_url,
            course_chapter_create_url=course_chapter_create_url,
            course_chapter_sequence_update_url=course_chapter_sequence_update_url,
            course_chapter_visibility_url=course_chapter_visibility_url,
            course_quiz_sequence_update_url=course_quiz_sequence_update_url,
            course_quiz_visibility_url = course_quiz_visibility_url,
            course_instructor_view360_url=course_instructor_view360_url,
            max_courses_per_prof=max_courses_per_prof,
            max_courses_per_prof_exceeded=max_courses_per_prof_exceeded,
        )

    # ---------- course view 360
    @route(
        "/view-360", defaults={"school_subject_id": 0, "course_id": 0}, methods=Api.GET
    )
    @route("/view-360/<school_subject_id>/<course_id>", methods=Api.GET)
    def courseBySubjectView360(self, school_subject_id, course_id):
        from ..course_learning_views.course_view_controller import CourseView
        return CourseView.courseBySubject(self, school_subject_id, course_id)
    # ---------- course list all
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("", methods=Api.GET)
    def index(self):
        instructor_id = current_user.id
        s_api = CourseInstructorManager()
        course_list = s_api.getListCourse(instructor_id)
        return self.__index_case(instructor_id, course_list)

    # --------- course list visibility
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/visibility/1", defaults={"is_visible": 1}, methods=Api.GET)
    @route("/visibility/0", defaults={"is_visible": 0}, methods=Api.GET)
    @route("/visibility/<is_visible>", methods=Api.GET)
    def visibility(self, is_visible):
        instructor_id = current_user.id
        s_api = CourseInstructorManager()
        course_list = s_api.getListCourseVisibility(instructor_id, is_visible)
        return self.__index_case(instructor_id, course_list)


# -----------------------
#       Api
# ------------------------
class CourseInstructorManager(Api):
    route_base = "/instructor-course-manager/"

    @classmethod
    def getCountCourses(self, instructor_id) -> int:

        try:
            nbr = Course.query.filter_by(instructor_id=instructor_id).count()
            return nbr
        except Exception as inst:
            Api.json_exception(inst)
            return -1

    @route("/list-course/<instructor_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListCourse(self, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = (
                CourseView.query.filter_by(instructor_id=instructor_id)
                .order_by(CourseView.date_start_course.desc())
                .all()
            )
            if not qList:
                return notFound
            qList = [i.serialize() for i in qList]
            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-course/<instructor_id>/visibility/<is_visible>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListCourseVisibility(self, instructor_id, is_visible):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = (
                CourseView.query.filter_by(
                    instructor_id=instructor_id, is_visible=is_visible
                )
                .order_by(CourseView.date_start_course.desc())
                .all()
            )
            if not qList:
                return notFound
            qList = [i.serialize() for i in qList]
            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/course/<id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getCourse(self, id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            cv = CourseView.query.filter_by(id=id).one()
            if not cv:
                return notFound

            return Api.json_response(HTTPStatus.OK, cv.serialize())
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-subject/<instructor_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListSubject(self, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            sb = (
                InstructorSubjectView.query.filter_by(instructor_id=instructor_id)
                .order_by(
                    InstructorSubjectView.label_subject,
                    InstructorSubjectView.education,
                    InstructorSubjectView.code,
                )
                .all()
            )
            if not sb:
                return notFound
            sb = [i.serialize() for i in sb]
            return Api.json_response(HTTPStatus.OK, sb)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-language", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListLanguage(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            lg = Language.query.options(noload("*")).order_by(Language.language_name)
            lg = [i.serialize() for i in lg]
            return Api.json_response(HTTPStatus.OK, lg)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/update-visibility/<instructor_id>", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def updateVisibility(self, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        course = json.loads(request.data)
        id = course["id"]
        is_visible = course["is_visible"]

        if not id or not instructor_id or is_visible is None:
            return notFound

        id = int(id)

        try:
            c = (
                Course.query.options(noload("*"))
                .filter_by(id=id, instructor_id=instructor_id)
                .one()
            )
            if c:
                c.is_visible = is_visible
                dbSession.commit()
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": c.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/save-update/<instructor_id>", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def saveUpdate(self, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        course = json.loads(request.data)
        id = course["id"]
        course_title = course["course_title"]
        language_id = course["language_id"]
        school_subject_id = course["school_subject_id"]
        is_visible = course["is_visible"]
        course_brief = course["course_brief"]
        course_fee = course["course_fee"]
        date_start_course = course["date_start_course"]
        date_end_course = course["date_end_course"]

        if id is None or instructor_id is None:
            return notFound

        id = int(id)

        try:
            c = Course()
            if id > 0:
                c = (
                    Course.query.options(noload("*"))
                    .filter_by(id=id, instructor_id=instructor_id)
                    .one()
                )
                if c is None:
                    return notFound

            c.course_title = course_title
            c.language_id = language_id
            c.school_subject_id = school_subject_id
            c.is_visible = is_visible
            c.course_brief = course_brief
            c.course_fee = course_fee
            c.date_update = datetime.today()
            c.date_start_course= date_start_course
            c.date_end_course= date_end_course

            # New
            if id <= 0:
                instructor = (
                    Instructor.query.options(noload("*"))
                    .filter_by(id=instructor_id)
                    .one()
                )
                instructor.num_of_published_courses = (
                    instructor.num_of_published_courses
                    if instructor.num_of_published_courses
                    else 0
                ) + 1
                c.instructor_id = instructor_id
                c.num_of_chapters = 0
                c.date_creation = datetime.today()

                dbSession.add(c)
            # Save
            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"id": c.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/delete-all/<instructor_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def delete_all(self, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.deletion_canceled)
        dbError = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_course_canceled
        )
        chExistError = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_course_canceled_infos
        )
        course = json.loads(request.data)
        course_id = course["id"]

        if not instructor_id or not course_id or not course:
            return notFound

        try:
            ch_exist = (
                CourseChapter.query.options(noload("*"))
                .filter_by(course_id=course_id)
                .first()
                is not None
            )
            if ch_exist:
                return chExistError

            cr = (
                Course.query.options(noload("*"))
                .filter_by(id=course_id, instructor_id=instructor_id)
                .one()
            )
            if cr:
                try:
                    instructor = (
                        Instructor.query.options(noload("*"))
                        .filter_by(id=instructor_id)
                        .one()
                    )
                    instructor.num_of_published_courses = (
                        instructor.num_of_published_courses - 1
                        if instructor.num_of_published_courses > 0
                        else 0
                    )

                    dbSession.query(CourseFavorite).filter(
                        CourseFavorite.course_id == course_id
                    ).delete(synchronize_session="fetch")

                    dbSession.query(Enrollment).filter(
                        Enrollment.course_id == course_id
                    ).delete(synchronize_session="fetch")

                    dbSession.query(InstructorCalendarAssistance).filter(
                        InstructorCalendarAssistance.course_id == course_id
                    ).delete(synchronize_session="fetch")

                    dbSession.query(Quiz).filter(
                        Quiz.scope_id == course_id, Quiz.scope == "course"
                    ).delete(synchronize_session="fetch")

                    dbSession.delete(cr)
                    dbSession.commit()
                except SQLAlchemyError as e:
                    return dbError
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": cr.id})
        except Exception as inst:
            return Api.json_exception(inst)