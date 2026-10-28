from ...imports import *


# ---------------view
class QuizInstructorView(Api):
    route_prefix = ""
    route_base = "/instructor/quiz/"

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("/edit", defaults={"id": 0}, methods=Api.GET)
    @route("/edit/<int:id>", methods=Api.GET)
    def edit(self, id):

        if not id:
            return Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        quiz = (QuizInstructorManager()).get_quiz(id)

        course_id = 0
        if quiz.json["status"] == 200:
            course_id = quiz.json["response"]["scope_id"]
        else:
            return Api.json_response(HTTPStatus.NOT_FOUND, ARS.not_found)

        from .course_instructor_controller import CourseInstructorManager as api

        course = api().getCourse(course_id)
        if course.json["status"] == 200:
            course = course.json["response"]
            course_edit_url = "{}/{}".format(
                url_for("CourseInstructorView:edit_1"), course_id
            )

            course_instructor_view360_url = url_for(
                "CourseInstructorView:courseBySubjectView360_0",
                school_subject_id=course["school_subject_id"],
                course_id=course_id,
            )

        else:
            course = None

        quiz_instructor_view360_url = url_for("QuizFormView:form_0", id=id)
        return render_template(
            "/instructors/quiz/quiz-edit.html",
            quiz=quiz,
            quiz_id=id,
            course_id=course_id,
            course=course,
            course_edit_url=course_edit_url,
            course_instructor_view360_url=course_instructor_view360_url,
            quiz_instructor_view360_url=quiz_instructor_view360_url,
            roles=ROLES.Any.value,
            update_url=url_for("QuizInstructorManager:update_quiz", quiz_id=id),
            delete_url=url_for("QuizInstructorManager:delete_quiz", quiz_id=id),
        )


class QuizInstructorManager(Api):
    route_base = "/instructor/quiz-manager/"

    # ------------------------------------------------------------------ CREATE
    @route("/create", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def create_quiz(self):
        """
        Exemple JSON attendu
        {
          "quiz_name": "Histoire",
          "scope": "chapter",     # course | chapter | content
          "scope_id": 42,
          "time_limit": 1,       # en minutes (optionnel)
          "questions": [
            { "question_text":"...", "choices":["A","B","C"], "correct_answer":1 }
          ]
        }
        """
        payload = request.get_json() or {}
        required = ("quiz_name", "scope", "scope_id", "sequence","is_visible")
        if not all(k in payload for k in required):
            return Api.json_response(
                HTTPStatus.BAD_REQUEST,
                {"error": f"Champs requis manquants : {', '.join(required)}"},
            )

        quiz = Quiz(
            quiz_name=payload["quiz_name"],
            scope=payload["scope"],
            scope_id=payload["scope_id"],
            sequence=payload["sequence"],
            time_limit=payload.get("time_limit"),          
            is_visible = payload["is_visible"] or False,
            date_creation = datetime.now(),
            date_update = datetime.now(),
        )

        # — Questions ---------------------------------------------------------
        for q in payload.get("questions", []):
            if not {"question_text", "choices", "correct_answer"} <= q.keys():
                continue  # ignore question incomplète
            question = Question(
                idx=q.get("idx", 0),
                question_text=q["question_text"],
                choices=json.dumps(q["choices"], ensure_ascii=False),
                correct_answer=q["correct_answer"],
            )
            quiz.questions.append(question)

        try:
            dbSession.add(quiz)
            dbSession.commit()
            return Api.json_response(HTTPStatus.OK, quiz.serialize())
        except Exception as exc:
            dbSession.rollback()
            return Api.json_exception(exc)

    # -------------------------------------------------------------------- READ
    @route("/get-by/<string:scope>/<int:scope_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def get_quizzes_by_scope(self, scope, scope_id):
        """
        Récupère tous les quiz rattachés à un scope donné.
        Réponse JSON :
        [
          {
            "id": 7,
            "quiz_name": "...",
            "scope": "chapter",
            "scope_id": 42,
            "time_limit": 900,
            "questions": [...]
          },
          ...
        ]
        """
        valid_scopes = {"course", "chapter", "content"}
        if scope not in valid_scopes:
            return Api.json_response(
                HTTPStatus.BAD_REQUEST,
                {"error": f"scope doit être dans {valid_scopes}"},
            )

        quizzes = Quiz.query.filter_by(scope=scope, scope_id=scope_id).all()
        if not quizzes:
            return Api.json_response(HTTPStatus.NOT_FOUND, ARS.not_found)

        return Api.json_response(HTTPStatus.OK, [q.serialize() for q in quizzes])

    @route("/all", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def get_quizzes(self):
        quizzes = Quiz.query.all()
        return Api.json_response(HTTPStatus.OK, [q.serialize() for q in quizzes])

    @route("/<int:quiz_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def get_quiz(self, quiz_id):
        quiz = Quiz.query.get(quiz_id)
        if not quiz:
            return Api.json_response(HTTPStatus.NOT_FOUND, ARS.not_found)
        qz = quiz.serialize()
        return Api.json_response(HTTPStatus.OK, qz)

    # ------------------------------------------------------------------ UPDATE
    @route("/<int:quiz_id>/update", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def update_quiz(self, quiz_id):
        quiz = Quiz.query.get(quiz_id)
        if not quiz:
            return Api.json_response(HTTPStatus.NOT_FOUND, ARS.not_found)

        data = request.get_json() or {}

        # ---- champs simples --------------------------------------------------
        for k in ("quiz_name", "scope", "scope_id", "time_limit"):
            if k in data:
                setattr(quiz, k, data[k])

        # ---- gestion des questions ------------------------------------------
        existing_by_id = {q.id: q for q in quiz.questions}
        ids_in_payload = set()

        for qd in data.get("questions", []):
            q_id = qd.get("id")

            if q_id and q_id > 0:  # -------- UPDATE --------
                ids_in_payload.add(q_id)
                q = existing_by_id.get(q_id)
                if not q:
                    continue
                q.idx = qd.get("idx", 1)

                if "question_text" in qd:
                    q.question_text = qd["question_text"]
                if "choices" in qd:
                    q.choices = json.dumps(qd["choices"], ensure_ascii=False)
                if "correct_answer" in qd:
                    q.correct_answer = qd["correct_answer"]

            else:  # -------- CREATE --------
                if {"question_text", "choices", "correct_answer"} <= qd.keys():
                    dbSession.add(
                        Question(
                            question_text=qd["question_text"],
                            choices=json.dumps(qd["choices"], ensure_ascii=False),
                            correct_answer=qd["correct_answer"],
                            quiz=quiz,
                            idx= qd.get("idx", 1)
                        )
                    )

        # -------- DELETE (questions retirées du payload) ----------------------
        if "questions" in data:
            cond = (
                and_(Question.quiz_id == quiz.id, not_(Question.id.in_(ids_in_payload)))
                if ids_in_payload
                else (Question.quiz_id == quiz.id)
            )
            Question.query.filter(cond).delete(synchronize_session="fetch")

        # ---- commit / rollback ----------------------------------------------
        try:
            quiz.date_update = datetime.utcnow()

            dbSession.commit()
            return Api.json_response(HTTPStatus.OK, quiz.serialize())
        except Exception as exc:
            dbSession.rollback()
            return Api.json_exception(exc)

    @route("/save-update-sequence/<course_id>", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def saveUpdateSequence(self, course_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        quizList = json.loads(request.data)

        if quizList is None or len(quizList) == 0 or course_id is None:
            return notFound

        try:            

            from sqlalchemy.sql import case

            Quiz.query.filter(Quiz.scope_id == course_id,Quiz.scope == "course", Quiz.id.in_(quizList))\
                                  .update({
                                        Quiz.sequence: case(
                                            quizList,
                                            value=Quiz.id,)}, synchronize_session=False)
            dbSession.commit()
            return Api.json_response(HTTPStatus.OK, {"sequence": "ok"})
        except Exception as inst:
            return Api.json_exception(inst)



    

    @route("/update-visibility", methods=Api.POST)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def updateVisibility(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        quiz = json.loads(request.data)
        id = quiz["id"]
        is_visible = quiz["is_visible"]

        if not id or is_visible is None:
            return notFound

        id = int(id)

        try:
            qz = (
                Quiz.query.options(noload("*"))
                .filter_by(id=id)
                .one()
            )
            if qz:
                Quiz.date_update = datetime.now()
                qz.is_visible = is_visible
                dbSession.commit()
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": qz.id})
        except Exception as inst:
            return Api.json_exception(inst)

    # ------------------------------------------------------------------ DELETE
    @route("/<int:quiz_id>/delete", methods=Api.POST)  # POST si front limité
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def delete_quiz(self, quiz_id):
        quiz = Quiz.query.get(quiz_id)
        if not quiz:
            return Api.json_response(HTTPStatus.NOT_FOUND, ARS.not_found)
        scope_id = quiz.scope_id

        try:
            dbSession.delete(quiz)
            dbSession.flush()

            quizzes = (
                        Quiz.query.filter(Quiz.scope_id == scope_id)
                        .order_by(Quiz.date_update)
                        .all()
                    )
            if  quizzes and len(quizzes) > 0:
                for idx, q in enumerate(quizzes):
                    q.sequence= idx+1


            dbSession.commit()
            return Api.json_response(HTTPStatus.OK, {"id": quiz.id})
        except Exception as exc:
            dbSession.rollback()
            return Api.json_exception(exc)
