
# course_ai_controller.py
from http import HTTPStatus
from flask import request, current_app


# Adaptez ces imports selon votre projet
from ...imports import *

# Utilitaires locaux
def _now():
    from datetime import datetime
    return datetime.utcnow()

# -----------------------
# Views
# -----------------------
class CourseAiInstructorView(Api):
    route_prefix = ""
    route_base = "/instructor/course-ai/"
    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/course-ai-wizard", methods=Api.GET)
    def course_ai_wizard(self):
        instructor_id = current_user.id
        course_create_url = url_for("CourseInstructorView:create_manually")
        course_ai_wizard = url_for("CourseAiInstructorView:course_ai_wizard")
        course_publish_url = url_for(
            "CourseAIManager:publish", instructor_id=instructor_id
        )
        return render_template(
            "/instructors/course/course-ai-wizard.html",
            instructor_id =instructor_id, 
            course_create_url=course_create_url,
            course_ai_wizard=course_ai_wizard,
            course_publish_url=course_publish_url
        )



# -----------------------
# API
# -----------------------
class CourseAIManager(Api):
   
    route_base = "/course-ai-manager/"


    @route("/publish/<instructor_id>", methods=Api.POST)
    @auth.login_required
    def publish(self,instructor_id):
        try:
            payload = request.get_json(force=True)
        except Exception as e:
            self.log_exception(e)
            return self.json_response(HTTPStatus.BAD_REQUEST, {"message": "Invalid JSON"})

        # Accept { "course": {...} } or { "response": {...} } etc.
        course_obj = None
        if isinstance(payload, dict) and "course" in payload:
            course_obj = payload["course"]
        elif isinstance(payload, dict) and "response" in payload:
            course_obj = payload["response"]
        else:
            course_obj = payload if isinstance(payload, dict) else None

        if not course_obj:
            return self.json_response(HTTPStatus.BAD_REQUEST, {"message": "Missing course payload"})

        title = ( course_obj.get("course_title") or "")
        summary = (course_obj.get("course_summary") or "")
        modules = course_obj.get("modules") or []
        quizzes= course_obj.get("quizzes") or []

        try:
            if Course is not None:
                c = Course(
                    course_title = title,
                    course_brief = summary,
                    instructor_id = instructor_id,
                    num_of_chapters = max(1, len(modules)),
                    course_fee = 0,
                    language_id = 2,# par défaut français
                    school_subject_id = 1,
                    is_visible = 0,
                    date_creation = _now(),
                    date_update = _now(),
                    date_start_course = _now()
                )
                dbSession.add(c)
                dbSession.flush()

                seq_ch = 1
                for m in modules:
                    ch = CourseChapter(
                        course_id = c.id,
                        chapter_title = (m.get("module_title") or ""),
                        chapter_description = (m.get("module_description") or ""),
                        num_of_reading = 0,
                        num_of_contents = max(1, len(m.get("lessons", []))),
                        is_visible = 1,
                        sequence = seq_ch,
                        date_chapter_creation = _now(),
                        date_chapter_update = _now()
                    )
                    dbSession.add(ch)
                    dbSession.flush()

                    seq_content = 1
                    for lesson in m.get("lessons", []):
                        ccontent = CourseChapterContent(
                            course_chapter_id = ch.id,
                            content_type_id = 4, # type "text"
                            is_important = 0,
                            time_required_in_sec = 0,
                            is_open_for_free = "1",
                            is_visible = 1,
                            content_url = None,
                            content_brief = (lesson.get("lesson_summary") or ""),
                            content_text = lesson.get("lesson_content") or lesson.get("lesson_summary") or "",
                            date_creation = _now(),
                            date_update = _now(),
                            sequence = seq_content,
                            content_cover_url = None,
                            file_size_in_bytes = None
                        )
                        dbSession.add(ccontent)
                        seq_content += 1

                    seq_ch += 1

                # optional quizzes
                try:
                    q_seq = 1
                    for q in quizzes:   # quizzes = payload.get("quizzes", [])
                        quiz = Quiz(
                            quiz_name=(q.get("quiz_name") or ""),
                            scope="course",
                            scope_id=c.id,           # c = course créé plus haut
                            time_limit=int(q.get("time_limit") or 0),
                            date_creation=_now(),
                            date_update=_now(),
                            sequence=q_seq,
                            is_visible=True,
                        )
                        dbSession.add(quiz)
                        dbSession.flush()
                        q_seq += 1

                        # questions
                        qq_seq = 1
                        for qn in q.get("questions", []):
                            try:
                                question_text = qn.get("question") or qn.get("text") or ""
                                choices = qn.get("choices") or []

                                # correct_answer
                                ca = qn.get("correct_answer")
                                if isinstance(ca, int):
                                    correct_idx = ca
                                elif isinstance(ca, str) and ca.isdigit():
                                    correct_idx = int(ca)
                                else:
                                    correct_idx = 0

                                question = Question(
                                    idx=qq_seq,
                                    question_text=question_text[:8000],
                                    choices=json.dumps(choices, ensure_ascii=False),
                                    correct_answer=correct_idx,
                                    quiz_id=quiz.id,
                                )
                                dbSession.add(question)
                                dbSession.flush()
                                qq_seq += 1

                            except Exception as inst:
                                return Api.json_exception(inst)

                except Exception as inst:
                    return Api.json_exception(inst)

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
                dbSession.commit()
                return Api.json_response(HTTPStatus.OK, {"id": c.id})
            else:
                fake_course_id = 0
                return Api.json_response(HTTPStatus.OK, {"id": fake_course_id})
        except Exception as e:
            
            Api.json_exception(e)
            try:
                dbSession.rollback()
            except Exception:
                pass
            return Api.json_response(HTTPStatus.BAD_REQUEST, {"message": "DB error", "detail": str(e)})

  
    # remplace les méthodes save_draft() et publish() dans course_ai_controller.py
    @route("/save_draft", methods=Api.POST)
    @auth.login_required
    def save_draft(self):
        try:
            payload = request.get_json(force=True)
        except Exception as e:
            self.log_exception(e)
            return self.json_response(HTTPStatus.BAD_REQUEST, {"message": "Invalid JSON"})

        # Accept either { "draft": {...} } or directly { "response": {...} } or nested shapes
        draft_obj = None
        if isinstance(payload, dict) and "draft" in payload:
            draft_obj = payload["draft"]
        elif isinstance(payload, dict) and "response" in payload:
            draft_obj = payload["response"]
        else:
            # maybe the front sent the course directly
            draft_obj = payload if isinstance(payload, dict) else None

        if not draft_obj:
            return self.json_response(HTTPStatus.BAD_REQUEST, {"message": "Missing draft payload"})

        # Optional: basic sanitization
        title = (draft_obj.get("title") or draft_obj.get("course_title") or "")[:1000]
        summary = (draft_obj.get("summary") or draft_obj.get("course_brief") or "")[:4000]
        modules = draft_obj.get("modules") or []

        try:
            if  Course is not None:
                c = Course(
                    course_title = title,
                    course_brief = summary,
                    instructor_id = getattr(self, "current_user", None).id if getattr(self, "current_user", None) else 0,
                    num_of_chapters = max(1, len(modules)),
                    course_fee = 0,
                    language_id = 1,
                    school_subject_id = 1,
                    is_visible = 0,  # draft
                    date_creation = _now(),
                    date_update = _now(),
                    date_start_course = _now()
                )
                dbSession.add(c)
                dbSession.flush()  # obtenir c.id

                seq_ch = 1
                for m in modules:
                    ch = CourseChapter(
                        course_id = c.id,
                        chapter_title = (m.get("title") or "")[:1000],
                        num_of_reading = 0,
                        num_of_contents = max(1, len(m.get("lessons", []))),
                        is_visible = 0,
                        sequence = seq_ch,
                        date_chapter_creation = _now(),
                        date_chapter_update = _now()
                    )
                    dbSession.add(ch)
                    dbSession.flush()

                    seq_content = 1
                    for lesson in m.get("lessons", []):
                        ccontent = CourseChapterContent(
                            course_chapter_id = ch.id,
                            content_type_id = 1,
                            is_important = 0,
                            time_required_in_sec = None,
                            is_open_for_free = "0",
                            is_visible = 1,
                            content_url = None,
                            content_text = lesson.get("content") or lesson.get("summary") or "",
                            content_brief = (lesson.get("summary") or "")[:4000],
                            date_creation = _now(),
                            date_update = _now(),
                            sequence = seq_content,
                            content_cover_url = None,
                            file_size_in_bytes = None
                        )
                        dbSession.add(ccontent)
                        seq_content += 1

                    seq_ch += 1

                dbSession.commit()
                return self.json_response(HTTPStatus.OK, {"id": c.id})
            else:
                fake_id = int(_now().timestamp())
                return self.json_response(HTTPStatus.OK, {"id": fake_id})
        except Exception as e:
            current_app.logger.exception("DB error on save_draft: %s", e)
            try:
                dbSession.rollback()
            except Exception:
                pass
            return self.json_response(HTTPStatus.BAD_REQUEST, {"message": "DB error", "detail": str(e)})
