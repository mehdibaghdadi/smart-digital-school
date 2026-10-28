from ...imports import *


# ---------------view
class QuizFormView(Api):
    route_prefix = ""
    route_base = "/quiz/"

    @login_required
    @role_required(role=ROLES.Any.value)
    @route("/form/<int:id>/<int:checkby_student_id>",  methods=Api.GET)
    @route("/form", defaults={"id": 0, "checkby_student_id": 0}, methods=Api.GET)
    @route("/form/<int:id>", defaults={ "checkby_student_id": 0},  methods=Api.GET)
    def form(self, id,checkby_student_id=0):

        student_id =current_user.id
        role = loginSession.get_role_session()

        isStudent = role == ROLES.Student.value
        isInstructor = role == ROLES.Instructor.value
        isSchool = role == ROLES.School.value

        # check by student
        # checkby_student_id = (
        #     int(checkby_student_id) if representsInt(checkby_student_id) else 0
        # )
        checkbyStudent = checkby_student_id > 0 and (isSchool or isInstructor)
        if checkbyStudent:
            student_id = checkby_student_id

        getDataStudent = isStudent or checkbyStudent

        if not id:
            return Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        quiz = (QuizFormManager()).get_quiz(id)

        course_id = 0
        if quiz.json["status"] == 200:
            course_id = quiz.json["response"]["scope_id"]
        else:
            return Api.json_response(HTTPStatus.NOT_FOUND, ARS.not_found)

        course = (QuizFormManager()).getCourse(course_id)
        if course.json["status"] == 200:
            course = course.json["response"]
            course_edit_url = "{}/{}".format(
                url_for("CourseInstructorView:edit_1"), course_id
            )
            school_subject_id=course["school_subject_id"]
            if not checkbyStudent:
                course_instructor_view360_url = url_for(
                    "CourseView:courseBySubject_0",
                    school_subject_id=school_subject_id,
                    course_id=course_id,
                )
            else:
                course_instructor_view360_url = url_for(
                    "ReportingView:CourseView",
                    school_subject_id=school_subject_id,
                    course_id=course_id,
                    student_id=student_id,
                )

        else:
            course = None

        # student profile
        student_profile = (
            StudentProfile.query.filter_by(id=student_id).one_or_none()
            if checkbyStudent and not isStudent
            else None
        )
        if student_profile:
            img = getImage(student_profile.image)
            setattr(student_profile, "image", img)

        get_quiz_result_url=url_for("QuizFormManager:get_quiz_result",quiz_id=id, student_id=(student_id if getDataStudent else 0))
        edit_quiz_url=url_for("QuizInstructorView:edit_0",id=id)
        submit_quiz_url=url_for("QuizFormManager:submit_quiz", student_id=student_id)

        return render_template(
            "/courses/quizzes/quiz-form.html",
            quiz=quiz,
            quiz_id=id,
            student_profile=student_profile,
            course_id=course_id,
            course=course,
            course_view360_url=course_instructor_view360_url,
            roles=ROLES.Any.value,
            isStudent=isStudent,
            isInstructor=isInstructor,
            edit_quiz_url=edit_quiz_url,
            get_quiz_result_url=get_quiz_result_url,
            submit_quiz_url=submit_quiz_url
        )


class QuizFormManager(Api):
    route_base = "/quiz-form-manager/"

    # -------------------------------------------------------------------- READ

    @route("/<int:quiz_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def get_quiz(self, quiz_id):
        quiz = Quiz.query.get(quiz_id)
        if not quiz:
            return Api.json_response(HTTPStatus.NOT_FOUND, ARS.not_found)
        qz = quiz.serialize()
        return Api.json_response(HTTPStatus.OK, qz)

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


    @route("/<int:quiz_id>/<int:student_id>/result", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def get_quiz_result(self, quiz_id,student_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        # Vérifier que le quiz existe
        quiz = Quiz.query.get(quiz_id)
        if not quiz:
            return notFound

        # Récupérer toutes les réponses de l'étudiant pour ce quiz
        student_answers = StudentAnswer.query.filter_by(
            student_id=student_id,
            quiz_id=quiz_id
        ).all()

        if not student_answers:
            return notFound

        result = []
        correct_count = 0
        begin_timestamp= datetime.utcnow().min
        end_timestamp= datetime.utcnow().min

        for answer in student_answers:
            question = Question.query.get(answer.question_id)
            is_correct = question.correct_answer == answer.selected_choice_index

            begin_timestamp = answer.begin_timestamp if answer.begin_timestamp > begin_timestamp else begin_timestamp
            end_timestamp = answer.end_timestamp if answer.end_timestamp > end_timestamp else end_timestamp

            if is_correct:
                correct_count += 1

            result.append({
                "question_id": question.id,
                "question_text": question.question_text,
                "choices": json.loads(question.choices),
                "selected_choice_index": answer.selected_choice_index,
                "correct_answer_index": question.correct_answer,
                "is_correct": is_correct,
            })

        total_questions = len(quiz.questions)
        score = round((correct_count / total_questions) * 100, 0)

        rslt ={
            "quiz_id": quiz.id,
            "quiz_name": quiz.quiz_name,
            "total_questions": total_questions,
            "correct_answers": correct_count,
            "score": score,
            "answers_detail": result,
            "begin_timestamp": begin_timestamp ,
            "end_timestamp": end_timestamp ,
        }
        return  Api.json_response(HTTPStatus.OK, rslt);


    # ------------------------------------------------------------------ SUBMIT
    @route("/<int:student_id>/submit", methods=Api.POST)
    @limiter.limit(limit.medium, error_message=limit.medium)
    @auth.login_required
    def submit_quiz(self,student_id):
        try:
            data = request.get_json()
            quiz_id = data.get('quiz_id')
            begin_timestamp = data.get('begin_timestamp')
            end_timestamp = data.get('end_timestamp')
            answers = data.get('answers')  # list of {question_id, selected_choice_index}
            
            if not quiz_id or not answers:
                return jsonify({'error': 'quiz_id or answers is missing'}), 400
            
            quiz = Quiz.query.get(quiz_id)
            if not quiz:
                return jsonify({'error': 'Quiz not found'}), 404
            
            # Vérifier si déjà soumis
            existing = StudentAnswer.query.filter_by(
                student_id=student_id,
                quiz_id=quiz_id
            ).first()
            
            if existing:
                return jsonify({'error': 'You already submitted this quiz'}), 403
            
            correct_count = 0
            total_questions = len(quiz.questions)
            
            for ans in answers:
                question_id = ans.get('question_id')
                selected_index = ans.get('selected_choice_index')
                selected_index = int(selected_index) if selected_index is not None else -1
            
                question = Question.query.filter_by(id=question_id, quiz_id=quiz_id).first()
                if not question or selected_index==-1:
                    continue
            
                if question.correct_answer == selected_index:
                    correct_count += 1
            
                student_answer = StudentAnswer(
                    student_id=student_id,
                    quiz_id=quiz_id,
                    question_id=question_id,
                    selected_choice_index=selected_index,
                    begin_timestamp=begin_timestamp,
                    end_timestamp=end_timestamp
                )
                dbSession.add(student_answer)
                dbSession.commit()
            
            score = round((correct_count / total_questions) * 100, 0)
            
            rslt = {
                'message': 'Quiz submitted successfully',
                'score': score,
                'correct_answers': correct_count,
                'total_questions': total_questions
            }
            return  Api.json_response(HTTPStatus.OK, rslt);
        except Exception as inst:
            return Api.json_exception(inst)
