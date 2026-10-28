app.controller("QuizFormCtrl", ['$scope', '$http', '$filter', function ($scope, $http, $filter) {
    var vm = this;
    vm.enableSubmit = false; // Indicate if the submit button should be enabled
    vm.get_quiz_result_url = "";
    vm.quiz = {
        quiz_name: '',
        time_limit: null,
        begin_timestamp: null,
        questions: []
    };
    $scope.loading = false; // Indicate if the quiz data is being loaded

    // Initialiser les données du quiz
    vm.init = function (quizData, get_quiz_result_url) {
        $scope.loading = true;
        vm.quiz = quizData;
        vm.get_quiz_result_url = get_quiz_result_url;
        // Préparer les réponses sélectionnées
        vm.quiz.questions.forEach(function (q) {
            q.selected = null; // Valeur par défaut (aucune sélection)
            q.choices = q.choices || [];
            q.idx = q.idx || idx++;
            q.hasAnswer = false;
            if (typeof q.choices === 'string') {
                try { q.choices = JSON.parse(q.choices); } catch (e) { }
            }
        });
        // Initialiser le score à 0
        vm.quiz.total_questions = vm.quiz.questions.length;
        vm.quiz.correct_answers = 0;
        vm.quiz.score = 0;
        vm.submitted = false;
        vm.quiz.begin_timestamp = moment(new Date()).format('YYYY-MM-DDTHH:mm:ss');


        //check if the quiz is already submitted
        vm.getQuizResult();
    };
    // Read
    vm.getQuizResult = function () {
        $http.get(vm.get_quiz_result_url)
            .then(function (response) {
                var info = response.data.response;

                // Injecter les résultats dans les questions
                if (info.answers_detail && vm.quiz && vm.quiz.questions) {
                    vm.quiz.total_questions = info.total_questions;
                    vm.quiz.correct_answers = info.correct_answers;
                    vm.quiz.score = info.score;
                    vm.quiz.submitted = true;
                    vm.quiz.begin_timestamp = new Date(info.begin_timestamp) ;
                    vm.quiz.end_timestamp = new Date(info.end_timestamp);

                    vm.quiz.questions.forEach(function (q) {
                        // Trouver la réponse correspondante
                        let answer = info.answers_detail.find(ans => ans.question_id === q.id);
                        if (answer) {
                            q.hasAnswer = true; // Marquer la question comme ayant une réponse
                            q.selected = answer.selected_choice_index;
                            q.correct_answer_index = answer.correct_answer_index;
                            q.is_correct = answer.is_correct;
                        }
                    });
                }
                $scope.loading = false;
                vm.enableSubmit = false;
                $scope.$applyAsync();
            })
            .catch(function (error) {
                vm.enableSubmit = true;
                $scope.loading = false;
                $scope.$applyAsync();
                console.error(error);
            });
    };


    // Soumettre les réponses
    vm.submitAnswers = function (url_submit) {
        // Vérification que toutes les questions ont été répondues
        var msg_delete = '<div class="alert  p-2" role="alert">{0}</div>'.format(JSR.did_you_finish_this_quiz);
        toastr.confirm(msg_delete,
            function () {
                vm.confirmSubmitAnswers(url_submit);
            }, null);
    }

    vm.confirmSubmitAnswers = function (url_submit) {
        // Vérification que toutes les questions ont été répondues
        let unanswered = vm.quiz.questions.filter(q => q.selected === undefined || q.selected === null);

        if (unanswered.length > 0) {
            toastr.warning(JSR.must_response_before_submit, "", { timeOut: 5000 });
            return; // on arrête la soumission
        }

        let responses = vm.quiz.questions.map(function (q) {
            return {
                question_id: q.id,
                selected_choice_index: q.selected
            };
        });
        var end_timestamp = moment(new Date()).format('YYYY-MM-DDTHH:mm:ss') 
        let payload = {
            quiz_id: vm.quiz.id,
            begin_timestamp: vm.quiz.begin_timestamp,
            end_timestamp: end_timestamp,
            answers: responses,

        };

        $scope.loading = true;

        // Appel API pour soumettre les réponses
        $http.post(url_submit, payload)
            .then(function (response) {
                $scope.loading = false;
                var info = response.data.response;
                var msgTitle = '<div class="alert alert-success p-2" role="alert">{0}</div>'.format(JSR.quiz_submitted_successfully);
                var rsltmsg = '<div class="p-1 text-center">{0} : <b class="text-lg">{1}%</b><hr/>{2} : <b  class="text-lg">{3}/{4}</b></div>'.format(JSR.correct, info.score, JSR.score, info.correct_answers, info.total_questions);

                toastr.success(msgTitle + rsltmsg, "", { timeOut: 200000 });

                vm.getQuizResult();
            })
            .catch(function (error) {
                $scope.loading = false;

                if (error.status == 400 || error.status == 403) {
                    toastr.error(error.data.error, "", { timeOut: 3000 });
                }
                console.error(error);
            });
    };

    vm.getFeedbackMessage = function (quiz) {

        if (!quiz || quiz.total_questions === 0) return "Aucun résultat disponible.";

        var score = (quiz.correct_answers / quiz.total_questions) * 100;

        if (score === 100) {
            return JSR.quiz_score_100;
        } else if (score >= 80) {
            return JSR.quiz_score_80;
        } else if (score >= 60) {
            return JSR.quiz_score_60;
        } else if (score >= 40) {
            return JSR.quiz_score_40;
        } else if (score >= 20) {
            return JSR.quiz_score_20;
        } else {
            return JSR.quiz_score_inf_20;
        }
    };

    vm.getDuration = function (begin_timestamp, end_timestamp) {
        if (begin_timestamp && end_timestamp) {
            const start = new Date(begin_timestamp);
            const end = new Date(end_timestamp);
            const diffMs = end - start;

            const totalSeconds = Math.floor(diffMs / 1000);
            const hours = Math.floor(totalSeconds / 3600);
            const minutes = Math.floor((totalSeconds % 3600) / 60);
            const seconds = totalSeconds % 60;

            const timestamp_html = `${minutes}mn ${seconds}s`;

            if (hours > 0) 
                timestamp_html = `${hours}h ${timestamp_html}`;

            return timestamp_html;
        }
        return '';
    };

}]);
