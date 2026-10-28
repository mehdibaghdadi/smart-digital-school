from ...imports import *
from flask_babel import lazy_gettext as _


class CourseView(Api):
    route_prefix = ""
    route_base = "/course/"

    # ----------------- COMMUN : ALL ROLES ------
    # course by subject :
    @login_required
    @route(
        "/view-360/<school_subject_id>/<course_id>/<checkby_student_id>",
        methods=Api.GET,
    )
    @route(
        "/view-360",
        defaults={"school_subject_id": 0, "course_id": 0, "checkby_student_id": 0},
        methods=Api.GET,
    )
    @route(
        "/view-360/<school_subject_id>/<course_id>",
        defaults={"checkby_student_id": 0},
        methods=Api.GET,
    )
    def courseBySubject(self, school_subject_id, course_id, checkby_student_id=0):

        student_id = current_user.id
        role = loginSession.get_role_session()

        isStudent = role == ROLES.Student.value
        isInstructor = role == ROLES.Instructor.value
        isSchool = role == ROLES.School.value

        # check by student
        checkby_student_id = (
            int(checkby_student_id) if representsInt(checkby_student_id) else 0
        )
        checkbyStudent = checkby_student_id > 0 and (isSchool or isInstructor)
        if checkbyStudent:
            student_id = checkby_student_id

        getDataStudent = isStudent or checkbyStudent

        school_subject_id = (
            int(school_subject_id) if representsInt(school_subject_id) else 0
        )
        course_id = int(course_id) if representsInt(course_id) else 0

        if school_subject_id <= 0 or course_id <= 0:
            abort(404)
        # Api
        s_api = CourseManager()
        course = s_api.getCourseBySubject(school_subject_id, course_id)
        list_chapter_content = s_api.getListChapterContent(course_id)
        if course is None or course.status_code != 200:
            abort(404)

        # course main
        # ------------------
        current_course = course.json["response"]
        course_title = " {}".format(current_course["label_subject"])
        is_favorite = s_api.isCourseFavorite(student_id, course_id).json["response"]

        # enrollment student
        course_enrollment = (
            s_api.enrollment(student_id, course_id) if getDataStudent else None
        )
        ce = (
            course_enrollment.json["response"]
            if course_enrollment and course_enrollment.json["status"] == 200
            else None
        )
        enrollment_id = int(ce["id"]) if ce else 0

        # feedback student
        feedback = s_api.getFeedBack(enrollment_id) if enrollment_id > 0 else None

        # demand assistance
        assistance_course = (
            s_api.getInstructorAssistance(student_id, course_id)
            if getDataStudent
            else None
        )

        # learning progress
        learning_progress_course = (
            s_api.getListLearningProgress(student_id,enrollment_id) if getDataStudent else None
        )

        # student profile
        student_profile = (
            StudentProfile.query.filter_by(id=student_id).one_or_none()
            if checkbyStudent and not isStudent
            else None
        )
        if student_profile:
            img = getImage(student_profile.image)
            setattr(student_profile, "image", img)

        # apis and links
        # ------------------
        url_back = url_for(
            "CourseView:listBySubject_0", school_subject_id=school_subject_id
        )

        url_course_edit = url_for("CourseInstructorView:edit_0", id=course_id)
        course_add_to_favorite_url = url_for(
            "CourseManager:addCourseToFavorite_0",
            student_id=student_id,
            course_id=course_id,
        )
        course_delete_from_favorite_url = url_for(
            "CourseManager:deleteCourseFromFavorite_0",
            student_id=student_id,
            course_id=course_id,
        )
        course_feedback_url = url_for("CourseManager:saveFeedBack")
        instructor_assistance_url = url_for(
            "CourseManager:saveInstructorAssistance",
            student_id=student_id,
            course_id=course_id,
        )
        delete_instructor_assistance_url = url_for(
            "CourseManager:deleteInstructorAssistance",
            student_id=student_id,
            course_id=course_id,
        )
        learning_progress_begin_url = url_for(
            "CourseManager:setLearningProgressBegin", enrollment_id=enrollment_id
        )
        learning_progress_end_url = url_for(
            "CourseManager:setLearningProgressEnd", enrollment_id=enrollment_id
        )
        list_quizzes_url = url_for(
            "CourseManager:get_quizzes_by",
            student_id=(student_id if getDataStudent else 0),
            scope="course",
            scope_id=course_id,
        )
        quiz_form_url = url_for("QuizFormView:form_1")

        return render_template(
            "/courses/course-360.html",
            student_id=student_id,
            student_profile=student_profile,
            title=course_title,
            url_back=url_back,
            is_favorite=is_favorite,
            current_course=current_course,
            list_chapter_content=list_chapter_content,
            course_enrollment=course_enrollment,
            learning_progress_course=learning_progress_course,
            feedback=feedback,
            assistance_course=assistance_course,
            course_add_to_favorite_url=course_add_to_favorite_url,
            course_delete_from_favorite_url=course_delete_from_favorite_url,
            course_feedback_url=course_feedback_url,
            instructor_assistance_url=instructor_assistance_url,
            delete_instructor_assistance_url=delete_instructor_assistance_url,
            isStudent=isStudent,
            isInstructor=isInstructor,
            getDataStudent=getDataStudent,
            url_course_edit=url_course_edit,
            learning_progress_begin_url=learning_progress_begin_url,
            learning_progress_end_url=learning_progress_end_url,
            list_quizzes_url=list_quizzes_url,
            quiz_form_url=quiz_form_url,
        )

    # ----------------- Students -----------------

    @classmethod
    def render_list_courses(
        self, student_id, url_back, course_list, IsFav=False, IsHistorique=False
    ):
        s_api = CourseManager()
        list_courses_progress = s_api.getListCoursesProgress(student_id)
        course_list_favorite = (
            s_api.getListFKCourseFavorite(student_id) if not IsFav else None
        )
        title_suffix = " - {} : {}".format(_('Cours Disponibles'), len(course_list.json["response"]))
        course_url = url_for("CourseView:courseBySubject_1")
        course_delete_from_favorite_url = url_for(
            "CourseManager:deleteCourseFromFavorite_1", student_id=student_id
        )
        course_add_to_favorite_url = url_for(
            "CourseManager:addCourseToFavorite_1", student_id=student_id
        )

        return render_template(
            "/students/course/course-list.html",
            IsFav=IsFav,
            IsHistorique=IsHistorique,
            title= title_suffix,
            url_back=url_back,
            course_url=course_url,
            list_courses_progress=list_courses_progress,
            course_list_favorite=course_list_favorite,
            course_add_to_favorite_url=course_add_to_favorite_url,
            course_delete_from_favorite_url=course_delete_from_favorite_url,
            course_list=course_list,
        )

    # list course by subject
    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/list-by-subject", defaults={"school_subject_id": 0}, methods=Api.GET)
    @route("/list-by-subject/<school_subject_id>", methods=Api.GET)
    def listBySubject(self, school_subject_id):
        student_id = current_user.id

        school_subject_id = (
            int(school_subject_id) if representsInt(school_subject_id) else 0
        )
        if school_subject_id <= 0:
            return redirect(url_for("SubjectStudentView:index"))

        s_api = CourseManager()

        course_list = s_api.getListBySubject(student_id, school_subject_id)
        url_back = url_for("SubjectStudentView:index")

        return self.render_list_courses(student_id, url_back, course_list)

    # course favorite
    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/list-course-favorite", methods=Api.GET)
    def listCourseFavorite(self):

        student_id = current_user.id
        s_api = CourseManager()

        course_list = s_api.getListCourseFavorite(student_id)
        url_back = url_for("SubjectStudentView:index")

        return self.render_list_courses(student_id, url_back, course_list, True)

    # course history
    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/list-course-history", methods=Api.GET)
    def listCourseHistory(self):

        student_id = current_user.id
        s_api = CourseManager()

        course_list = s_api.getListCourseHistory(student_id)
        url_back = url_for("SubjectStudentView:index")

        return self.render_list_courses(student_id, url_back, course_list, False, True)

    # course by instructor
    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/list-course-instructor", defaults={"instructor_id": 0}, methods=Api.GET)
    @route("/list-course-instructor/<instructor_id>", methods=Api.GET)
    def listCourseInstructor(self, instructor_id):
        student_id = current_user.id

        instructor_id = int(instructor_id) if representsInt(instructor_id) else 0
        if instructor_id <= 0:
            return redirect(url_for("InstructorStudentView:list"))

        s_api = CourseManager()

        course_list = s_api.getListCourseInstructor(student_id, instructor_id)
        url_back = url_for("InstructorStudentView:list")

        return self.render_list_courses(student_id, url_back, course_list)

    # list course student
    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/list-course-student", methods=Api.GET)
    def listCourseStudent(self):
        student_id = current_user.id
        s_api = CourseManager()

        course_list = s_api.getListByStudent(student_id)
        url_back = url_for("SubjectStudentView:index")

        return self.render_list_courses(student_id, url_back, course_list)


# --------------- Api --------------------------------------------------------------------
class CourseManager(Api):
    route_base = "/student-course-manager/"

    @route("/list-by-student/<student_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListByStudent(self, student_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:

            list_cb = StudentCourseInstructorList(student_id, None, None)

            if not list_cb:
                return notFound

            return Api.json_response(HTTPStatus.OK, list_cb)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-school-subject/<school_subject_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getSchoolSubject(self, school_subject_id):
        try:
            s = (
                SchoolSubjectView.query.options(noload("*"))
                .filter_by(id=school_subject_id)
                .one_or_none()
            )
            return s
        except Exception as inst:
            Api.json_exception(inst)
            return None

    @route("/course-by-subject/<school_subject_id>/<course_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getCourseBySubject(self, school_subject_id, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            cb = CourseInstructorView.query.filter_by(
                school_subject_id=school_subject_id, id=course_id
            ).one_or_none()
            if not cb:
                return notFound
            cb = cb.serialize()
            return Api.json_response(HTTPStatus.OK, cb)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-chapter-content/<course_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListChapterContent(self, course_id):

        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            lcc = (
                CourseChapterContentView.query.filter_by(
                    course_id=course_id,
                    chapter_is_visible=True,
                    content_is_visible=True,
                )
                .order_by(
                    CourseChapterContentView.chapter_sequence.asc(),
                    CourseChapterContentView.content_sequence.asc(),
                )
                .all()
            )
            if not lcc:
                return notFound
            lcc = [i.serialize() for i in lcc]
            return Api.json_response(HTTPStatus.OK, lcc)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-course-by-subject/<student_id>/<school_subject_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListBySubject(self, student_id, school_subject_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            sb = StudentCourseInstructorList(student_id, school_subject_id, None)
            if not sb:
                return notFound

            return Api.json_response(HTTPStatus.OK, sb)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-course-favorite/<student_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListCourseFavorite(self, student_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            sb = (
                CourseInstructorView.query.filter_by(is_visible=True)
                .filter(
                    CourseFavorite.query.filter_by(
                        student_id=student_id, course_id=CourseInstructorView.id
                    ).exists()
                )
                .order_by(CourseInstructorView.date_update.desc())
                .all()
            )
            if not sb:
                return notFound
            sb = [i.serialize() for i in sb]
            return Api.json_response(HTTPStatus.OK, sb)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-course-history/<student_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListCourseHistory(self, student_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            sb = (
                CourseInstructorEnrollmentView.query.filter_by(
                    is_visible=True, student_id=student_id
                )
                .order_by(CourseInstructorEnrollmentView.last_activity.desc())
                .all()
            )
            if not sb:
                return notFound
            sb = [i.serialize() for i in sb]
            return Api.json_response(HTTPStatus.OK, sb)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/is-course-favorite/<student_id>/<course_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def isCourseFavorite(self, student_id, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, False)
        try:
            sb = (
                CourseFavorite.query.filter_by(
                    student_id=student_id, course_id=course_id
                ).first()
                is not None
            )
            if not sb:
                return notFound

            return Api.json_response(HTTPStatus.OK, True)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-fk-course-favorite/<student_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListFKCourseFavorite(self, student_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            sb = CourseFavorite.query.filter_by(student_id=student_id).all()
            if not sb:
                return notFound
            sb = [i.serialize() for i in sb]
            return Api.json_response(HTTPStatus.OK, sb)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-course-instructor/<student_id>/<instructor_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListCourseInstructor(self, student_id, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            sb = StudentCourseInstructorList(student_id, None, instructor_id)
            if not sb:
                return notFound

            return Api.json_response(HTTPStatus.OK, sb)
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/add-course-to-favorite/<student_id>",
        defaults={"course_id": 0},
        methods=Api.POST,
    )
    @route("/add-course-to-favorite/<student_id>/<course_id>", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def addCourseToFavorite(self, student_id, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        student_id = int(student_id) if representsInt(student_id) else 0
        course_id = int(course_id) if representsInt(course_id) else 0

        if student_id == 0 or course_id == 0:
            return notFound

        try:
            fav = CourseFavorite.query.filter_by(
                student_id=student_id, course_id=course_id
            ).first()
            if fav is None:
                fav = CourseFavorite()
                fav.course_id = course_id
                fav.student_id = student_id
                dbSession.add(fav)
                dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"id": fav.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/delete-course-from-favorite/<student_id>",
        defaults={"course_id": 0},
        methods=Api.POST,
    )
    @route("/delete-course-from-favorite/<student_id>/<course_id>", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def deleteCourseFromFavorite(self, student_id, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.deletion_canceled)
        student_id = int(student_id) if representsInt(student_id) else 0
        course_id = int(course_id) if representsInt(course_id) else 0

        if student_id == 0 or course_id == 0:
            return notFound

        try:
            dbSession.query(CourseFavorite).filter_by(
                student_id=student_id, course_id=course_id
            ).delete(synchronize_session=False)
            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"id": course_id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/get-feedback/<enrollment_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getFeedBack(self, enrollment_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        enrollment_id = int(enrollment_id) if representsInt(enrollment_id) else 0
        if not enrollment_id:
            return notFound
        try:
            fdb = (
                Feedback.query.options(noload("*"))
                .filter_by(enrollment_id=enrollment_id)
                .one_or_none()
            )
            if not fdb:
                return notFound

            return Api.json_response(HTTPStatus.OK, fdb.serialize())
        except Exception as inst:
            return notFound

    @route("/save-feedback", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def saveFeedBack(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        feedback = json.loads(request.data)
        enrollment_id = feedback["enrollment_id"]
        enrollment_id = int(enrollment_id) if representsInt(enrollment_id) else 0

        feedback_text = feedback["feedback_text"]
        rating_score = feedback["rating_score"]
        rating_score = int(rating_score) if representsInt(rating_score) else 1

        if not enrollment_id:
            return notFound

        try:
            fdb = (
                Feedback.query.options(noload("*"))
                .filter_by(enrollment_id=enrollment_id)
                .one_or_none()
            )
            if not fdb:
                fdb = Feedback()
                fdb.enrollment_id = enrollment_id

            fdb.feedback_text = feedback_text
            fdb.rating_score = rating_score
            fdb.submission_date = datetime.today()

            if fdb.id is None:
                dbSession.add(fdb)

            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"id": fdb.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/enrollment/<student_id>/<course_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def enrollment(self, student_id, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)

        if not course_id or not student_id:
            return notFound

        try:
            enr = (
                Enrollment.query.options(noload("*"))
                .filter_by(student_id=student_id, course_id=course_id)
                .one_or_none()
            )
            if not enr:
                enr = Enrollment()
                enr.enrollment_date = datetime.today()
                enr.student_id = student_id
                enr.course_id = course_id
                enr.is_paid_subscription = False

            enr.last_activity = datetime.today()

            if enr.id is None:
                dbSession.add(enr)

            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, enr.serialize())
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/save-instructor-assistance/<student_id>/<course_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def saveInstructorAssistance(self, student_id, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        try:
            assistance = json.loads(request.data)

            student_id = int(student_id) if representsInt(student_id) else 0
            course_id = int(course_id) if representsInt(course_id) else 0

            demand_id = assistance["demand_id"]
            demand_id = int(demand_id) if representsInt(demand_id) else 0

            course_id_in = assistance["course_id"]
            course_id_in = int(course_id_in) if representsInt(course_id_in) else 0

            chapter_id = assistance["chapter_id"]
            chapter_id = int(chapter_id) if representsInt(chapter_id) else 0

            content_id = assistance["content_id"]
            content_id = int(content_id) if representsInt(content_id) else 0

            description_demand = assistance["description_demand"]

            q_assist = None

            if demand_id <= 0:
                if (
                    student_id <= 0
                    or course_id <= 0
                    or course_id_in != course_id
                    or chapter_id <= 0
                    or content_id <= 0
                ):
                    return notFound
            else:
                q_assist = (
                    InstructorCalendarAssistance.query.options(noload("*"))
                    .filter_by(id=demand_id)
                    .one_or_none()
                )

            if not q_assist:
                q_assist = InstructorCalendarAssistance()
                q_assist.student_id = student_id
                q_assist.course_id = course_id
                q_assist.course_chapter_id = chapter_id
                q_assist.course_chapter_content_id = content_id

            q_assist.description_demand = description_demand
            q_assist.date_demand = datetime.today()

            if q_assist.id is None:
                dbSession.add(q_assist)

            dbSession.commit()

            q_assist = (
                InstructorCalendarAssistance.query.options(noload("*"))
                .filter_by(student_id=student_id, course_id=course_id)
                .all()
            )
            q_assist = [i.serialize() for i in q_assist]

            return Api.json_response(HTTPStatus.OK, q_assist)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/get-instructor-assistance/<student_id>/<course_id>", methods=Api.POST)
    @limiter.limit(
        limit.fast,
        error_message=limit.fast,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def getInstructorAssistance(self, student_id, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        try:
            student_id = int(student_id) if representsInt(student_id) else 0
            course_id = int(course_id) if representsInt(course_id) else 0

            if student_id <= 0 or course_id <= 0:
                return notFound

            assist = (
                InstructorCalendarAssistance.query.options(noload("*"))
                .filter_by(student_id=student_id, course_id=course_id)
                .all()
            )

            if not assist:
                return notFound

            assist = [i.serialize() for i in assist]

            return Api.json_response(HTTPStatus.OK, assist)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/delete-instructor-assistance/<student_id>/<course_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def deleteInstructorAssistance(self, student_id, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        try:
            assistance = json.loads(request.data)

            student_id = int(student_id) if representsInt(student_id) else 0
            course_id = int(course_id) if representsInt(course_id) else 0

            demand_id = assistance["demand_id"]
            demand_id = int(demand_id) if representsInt(demand_id) else 0

            q_assist = None

            if demand_id <= 0 or student_id <= 0 or course_id <= 0:
                return notFound

            else:
                q_assist = (
                    InstructorCalendarAssistance.query.options(noload("*"))
                    .filter_by(id=demand_id)
                    .one_or_none()
                )

            if not q_assist:
                return notFound
            try:
                dbSession.delete(q_assist)
                dbSession.commit()
            except SQLAlchemyError as e:
                return Api.json_response(
                    HTTPStatus.BAD_REQUEST, ARS.deletion_content_canceled
                )

            q_assist = (
                InstructorCalendarAssistance.query.options(noload("*"))
                .filter_by(student_id=student_id, course_id=course_id)
                .all()
            )
            q_assist = [i.serialize() for i in q_assist]

            return Api.json_response(HTTPStatus.OK, q_assist)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-courses-progress/<student_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListCoursesProgress(self, student_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            data = CourseProgressView.query.filter_by(student_id=student_id).all()
            if not data:
                return notFound
            cp = [i.serialize() for i in data]
            return Api.json_response(HTTPStatus.OK, cp)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-learning-progress/<student_id>/<enrollment_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListLearningProgress(self, student_id,enrollment_id):

        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            data = LearningProgressView.query.filter(
                LearningProgressView.enrollment_id == enrollment_id,
                LearningProgressView.student_id == student_id
            ).all()
            if not data:
                return notFound
            lp = [i.serialize() for i in data]
            return Api.json_response(HTTPStatus.OK, lp)
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/set-learning-progress-begin/<enrollment_id>",
        methods=Api.POST,
    )
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def setLearningProgressBegin(self, enrollment_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        try:
            data = json.loads(request.data)
            course_chapter_content_id = data["course_chapter_content_id"]
            date_start = data["date_start"]

            lp = (
                LearningProgress.query.options(noload("*"))
                .filter_by(
                    enrollment_id=enrollment_id,
                    course_chapter_content_id=course_chapter_content_id,
                )
                .one_or_none()
            )
            if lp is None:
                lp = LearningProgress()
                lp.enrollment_id = enrollment_id
                lp.course_chapter_content_id = course_chapter_content_id
                lp.begin_timestamp = date_start
                lp.status = STATUS_LEARNING_PROGRESS.Begin.value
                dbSession.add(lp)

                dbSession.commit()

            return Api.json_response(HTTPStatus.OK, lp.serialize())
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/set-learning-progress-end/<enrollment_id>",
        methods=Api.POST,
    )
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def setLearningProgressEnd(self, enrollment_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        try:
            data = json.loads(request.data)
            course_chapter_content_id = data["course_chapter_content_id"]
            date_end = data["date_end"]
            lp = (
                LearningProgress.query.options(noload("*"))
                .filter_by(
                    enrollment_id=enrollment_id,
                    course_chapter_content_id=course_chapter_content_id,
                    status=STATUS_LEARNING_PROGRESS.Begin.value,
                )
                .one_or_none()
            )
            if lp:
                lp.completion_timestamp = date_end
                lp.status = STATUS_LEARNING_PROGRESS.Completion.value
                dbSession.commit()

            lp = lp.serialize() if lp else {}

            return Api.json_response(HTTPStatus.OK, lp)
        except Exception as inst:
            return Api.json_exception(inst)

    @route(
        "/get-quizzes-by/<int:student_id>/<string:scope>/<int:scope_id>",
        methods=Api.GET,
    )
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def get_quizzes_by(self, student_id, scope, scope_id):
        valid_scopes = {"course", "chapter", "content"}
        if scope not in valid_scopes:
            return Api.json_response(
                HTTPStatus.BAD_REQUEST,
                {"error": f"scope doit être dans {valid_scopes}"},
            )

        # 1) Charger tous les résultats de l'étudiant pour ce scope
        results = StudentQuizResultView.query.filter_by(
            student_id=student_id, scope=scope, scope_id=scope_id
        ).all()

        # Construire un dict { quiz_id: result_obj }
        result_map = {r.quiz_id: r for r in results}

        # 2) Charger tous les quiz de ce scope
        quizzes = Quiz.query.filter(
            Quiz.scope == scope, Quiz.scope_id == scope_id,Quiz.is_visible == True
        ).all()
        if not quizzes:
            return Api.json_response(HTTPStatus.NOT_FOUND, ARS.not_found)

        # 3) Construire la réponse finale
        response_data = []
        for quiz in quizzes:
            total_questions = len(quiz.questions) or 0
            if total_questions:
                item = quiz.serialize()
                r = result_map.get(quiz.id)
                if r:
                    item.update(
                        {
                            "student_id": r.student_id,
                            "score": r.score or 0,
                            "correct_answers": r.correct_answers or 0,
                            "total_questions": r.total_questions or 0,
                            "done": True,
                        }
                    )
                else:
                    item.update(
                        {
                            "student_id": student_id,
                            "score": 0,
                            "correct_answers": 0,
                            "total_questions": total_questions,
                            "done": False,
                        }
                    )
                response_data.append(item)

        return Api.json_response(HTTPStatus.OK, response_data)
