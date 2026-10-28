from ...imports import *


class ChapterInstructorView(Api):
    route_prefix = ""
    route_base = "/instructor/course-chapter/"

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/create/<course_id>", methods=Api.GET)
    def create(self, course_id):
        course_id = int(course_id)
        return render_template("/instructors/chapter/chapter-edit.html", chapter_id=0)

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/edit", defaults={"id": 0}, methods=Api.GET)
    @route("/edit/<id>", methods=Api.GET)
    def edit(self, id=0):

        instructor_id = current_user.id
        id = int(id)
        from ..packages.package_controller import PackageManager
        from .course_chapter_content_controller import ChapterContentInstructorManager

        pack = (PackageManager()).get(current_user.package_id)
        max_content_per_chapter = pack["max_courses_per_prof"]
        content_count = (ChapterContentInstructorManager()).getCountContents(id)
        max_content_per_chapter_exceeded = content_count >= max_content_per_chapter

        s_api = ChapterInstructorManager()
        chapter = s_api.getChapter(id)

        if chapter.status_code != 200:
            abort(404)

        data_course = json.loads(chapter.data)
        course_id = int(data_course["response"]["course_id"])
        school_subject_id = int(data_course["response"]["school_subject_id"])
        course_instructor_view360_url = url_for(
            "CourseInstructorView:courseBySubjectView360_0",
            school_subject_id=school_subject_id,
            course_id=course_id,
        )

        from .course_chapter_content_controller import ChapterContentInstructorManager

        s_content_api = ChapterContentInstructorManager()
        content = s_content_api.getListContent(id)

        course_edit_url = url_for("CourseInstructorView:edit_1")
        course_chapter_update_url = url_for(
            "ChapterInstructorManager:saveUpdate", course_id=course_id
        )
        course_chapter_list_url = url_for(
            "ChapterInstructorManager:getListChapter", course_id=course_id
        )

        course_chapter_content_update_url = url_for(
            "ChapterContentInstructorManager:saveUpdate", chapter_id=id
        )
        course_chapter_content_delete_url = url_for(
            "ChapterContentInstructorManager:delete_all", chapter_id=id
        )
        course_chapter_content_visibility_url = url_for(
            "ChapterContentInstructorManager:updateVisibility", chapter_id=id
        )
        course_chapter_content_importance_url = url_for(
            "ChapterContentInstructorManager:updateImportance", chapter_id=id
        )
        course_chapter_content_sequence_update_url = url_for(
            "ChapterContentInstructorManager:saveUpdateSequence", chapter_id=id
        )
        course_chapter_edit_url = url_for("ChapterInstructorView:edit_1")

        template = render_template(
            "/instructors/chapter/chapter-edit.html",
            chapter_id=id,
            chapter=chapter,
            content=content,
            course_edit_url=course_edit_url,
            course_chapter_update_url=course_chapter_update_url,
            course_chapter_content_update_url=course_chapter_content_update_url,
            course_chapter_content_delete_url=course_chapter_content_delete_url,
            course_chapter_content_visibility_url=course_chapter_content_visibility_url,
            course_chapter_content_importance_url=course_chapter_content_importance_url,
            course_chapter_content_sequence_update_url=course_chapter_content_sequence_update_url,
            course_chapter_list_url=course_chapter_list_url,
            course_chapter_edit_url=course_chapter_edit_url,
            course_instructor_view360_url=course_instructor_view360_url,
            max_content_per_chapter=max_content_per_chapter,
            max_content_per_chapter_exceeded=max_content_per_chapter_exceeded,
        )
        return template


# ---------------Api
class ChapterInstructorManager(Api):
    route_base = "/instructor-course-chapter-manager/"

    @route("/chapter/<id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getChapter(self, id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            cv = CourseChapterView.query.filter_by(id=id).one()
            if not cv:
                return notFound

            return Api.json_response(HTTPStatus.OK, cv.serialize())
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-chapter/<course_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListChapter(self, course_id):
        # time.sleep(3)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            ch = (
                CourseChapter.query.options(noload("*"))
                .filter_by(course_id=course_id)
                .order_by(CourseChapter.sequence)
                .all()
            )
            if not ch:
                return notFound
            ch = [i.serialize() for i in ch]

            return Api.json_response(HTTPStatus.OK, ch)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/update-visibility/<course_id>", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def updateVisibility(self, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        chapter = json.loads(request.data)
        id = chapter["id"]
        is_visible = chapter["is_visible"]

        if not id or not course_id or is_visible is None:
            return notFound

        id = int(id)

        try:
            ch = (
                CourseChapter.query.options(noload("*"))
                .filter_by(id=id, course_id=course_id)
                .one()
            )
            if ch:
                CourseChapter.date_chapter_update = datetime.now()
                ch.is_visible = is_visible
                dbSession.commit()
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": ch.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/save-update/<course_id>", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def saveUpdate(self, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        chapter = json.loads(request.data)
        id = chapter["id"]
        chapter_title = chapter["chapter_title"]
        chapter_description = chapter.get("chapter_description")
        sequence = chapter["sequence"]
        is_visible = chapter["is_visible"]

        if id is None or course_id is None:
            return notFound

        id = int(id)

        try:
            c = CourseChapter()
            if id > 0:
                c = (
                    CourseChapter.query.options(noload("*"))
                    .filter_by(id=id, course_id=course_id)
                    .one()
                )
                if c is None:
                    return notFound
            else:
                c.date_chapter_creation = datetime.now()

            c.chapter_title = chapter_title
            c.chapter_description = chapter_description if chapter_description else None
            c.is_visible = is_visible
            c.date_chapter_update = datetime.now()

            if id <= 0:
                c.course_id = course_id
                c.sequence = sequence
                c.num_of_reading = 0
                c.num_of_contents = 0
                dbSession.add(c)
                # update course
                course = Course.query.options(noload("*")).filter_by(id=course_id).one()
                course.num_of_chapters += 1

            # Save
            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"id": c.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/save-update-sequence/<course_id>", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def saveUpdateSequence(self, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        chapterList = json.loads(request.data)

        if chapterList is None or len(chapterList) == 0 or course_id is None:
            return notFound

        try:
            from sqlalchemy.sql import case

            CourseChapter.query.filter(CourseChapter.course_id == course_id, CourseChapter.id.in_(chapterList))\
                                  .update({
                                        CourseChapter.sequence: case(
                                            chapterList,
                                            value=CourseChapter.id,)}, synchronize_session=False)

            dbSession.commit()
            return Api.json_response(HTTPStatus.OK, {"sequence": "ok"})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/delete-all/<course_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def delete_all(self, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.deletion_canceled)
        dbError = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_chapter_canceled
        )
        ctExistError = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_chapter_canceled_infos
        )
        chapter = json.loads(request.data)
        id = chapter["id"]

        if not course_id or not id or not chapter:
            return notFound

        try:
            ct_exist = (
                CourseChapterContent.query.options(noload("*"))
                .filter_by(course_chapter_id=id)
                .first()
                is not None
            )
            if ct_exist:
                return ctExistError

            ch = (
                CourseChapter.query.options(noload("*"))
                .filter_by(id=id, course_id=course_id)
                .one()
            )
            if ch:
                try:
                    dbSession.delete(ch)
                    dbSession.flush()

                    # update course
                    course = (
                        Course.query.options(noload("*")).filter_by(id=course_id).one()
                    )
                    course.num_of_chapters = (
                        course.num_of_chapters - 1 if course.num_of_chapters > 0 else 0
                    )
                    #update sequences chapters
                    chapters = (
                        CourseChapter.query.filter(CourseChapter.course_id == course_id)
                        .order_by(CourseChapter.sequence)
                        .all()
                    )
                    if chapters and len(chapters) > 0:
                        for idx, chapter in enumerate(chapters):
                            chapter.sequence = idx+1

                    # Save
                    dbSession.commit()
                except SQLAlchemyError as e:
                    return dbError
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": ch.id})
        except Exception as inst:
            return Api.json_exception(inst)