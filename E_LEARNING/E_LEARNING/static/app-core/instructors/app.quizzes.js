var initQuiz = { quiz_name: '', time_limit: 0, questions: [], sequence: 1, is_visible: 1 };
var initQuestion = { id: 0, idx: 0, question_text: '', choices: ['', ''], correct_answer: 0 };

// EditQuiz
app.controller('EditCourseQuizCtrl', ['$http', '$scope', '$filter', '$element', '$window', '$timeout',
    function ($http, $scope, $filter, $el, $window, $timeout) {
        const vm = this;
        vm.courseId = $el.attr('data-course-id');
        const api = '/api/instructor/quiz-manager';
        $scope.edit_quiz_url = "";

        const route = p => `${api}${p}`;

        vm.quizzes = [];
        vm.newQuiz = angular.copy(initQuiz);
        vm.editQuiz = angular.copy(initQuiz);
        vm.newQuestion = angular.copy(initQuestion);
        vm.editing = null;
        let tempQuestionId = -1;
        // ------------------- init ---------------------------------------------
        vm.init = function (initQ, edit_quiz_url) {

            $scope.edit_quiz_url = edit_quiz_url;
            if (initQ) {
                vm.editQuiz.id = initQ.id;
                vm.editQuiz.quiz_name = initQ.quiz_name;
                vm.editQuiz.time_limit = initQ.time_limit || 0;
                vm.editQuiz.questions = initQ.questions || [];
                var idx = 1;
                angular.forEach(vm.editQuiz.questions, function (q) {
                    q.choices = q.choices || [];
                    q.idx = q.idx || idx++;
                    if (typeof q.choices === 'string') {
                        try { q.choices = JSON.parse(q.choices); } catch (e) { }
                    }

                });
                $scope.$applyAsync();          // digest
                $timeout(initSortable, 500); // DOM prêt → sortable
                setTimeout(vm.refresh, 0)

            }
        };

        vm.refresh = () => {
            $http.get(route(`/get-by/course/${vm.courseId}`))
                .then(function (r) {
                    if (r.data.status == 200) {
                        vm.quizzes = sortQuizzesBySequence(r.data.response);
                        angular.forEach(vm.quizzes, function (val, key) {
                            val.href = "{0}/{1}".format($scope.edit_quiz_url, val.id)
                            val.currentId = vm.editQuiz.id == val.id;
                        });
                        console.log(vm.quizzes);

                    }

                }, function (response) {

                    console.log(response);
                });
        };

        // --------------- helpers pour choix -----------------------------------
        vm.addChoice = () => vm.newQuestion.choices.push('');
        vm.removeChoice = function (choices, idx, question) {
            choices.splice(idx, 1);

            if (question.correct_answer === idx) {
                // Si la bonne réponse supprimée → on remet à null
                question.correct_answer = null;
            } else if (question.correct_answer > idx) {
                // Sinon si elle est après → on décrémente
                question.correct_answer--;
            }

            $scope.$applyAsync();
        };
        var sortQuizzesBySequence = function (lst) {
            return $filter('orderBy')(lst, 'sequence', false);
        }

        // --------------- questions  -------------------------------------------
        vm.addQuestion = () => {

            vm.addChoice = () => vm.newQuestion.choices.push('');
            vm.addChoice = () => vm.newQuestion.choices.push('');

            // Calculer le max des idx existants
            const maxIdx = vm.editQuiz.questions.length
                ? Math.max(...vm.editQuiz.questions.map(q => q.idx || 0))
                : 0;

            // Assigner idx = max + 1 à la nouvelle question
            const newQ = angular.copy(vm.newQuestion);
            newQ.idx = maxIdx + 1;
            newQ.id = tempQuestionId--; // décrémente pour chaque ajout

            vm.editQuiz.questions.push(newQ);
            vm.newQuestion = angular.copy(initQuestion); // reset


            reindexQuestions();  // ← à garder si nécessaire dans ton flow
            $timeout(() => {
                initSortable();
                const collapseId = `#c${newQ.idx}`;
                const $collapse = $(collapseId);
                if ($collapse.length) {
                    $('.collapse.in').collapse('hide');
                    $collapse.collapse('show');

                    // Focus sur le premier champ
                    const $input = $collapse.find('textarea, input').first();
                    if ($input.length) $input.focus();
                }
            }, 500);
        };

        vm.removeQuestion = function ($event, qId) {

            $event.preventDefault();
            if (qId <= 0) {
                removeQuestion(qId);
                return;
            }

            var msg_delete = '<div class="alert alert-danger" role="alert">{0}'.format(JSR.alert_action_irreversible)
                + '<hr/>' + JSR.msg_delete_confirm + '</div>';

            toastr.confirm(msg_delete,
                function () {
                    removeQuestion(qId);
                }, null);

        };


        var removeQuestion = function (qId) {
            vm.editQuiz.questions = vm.editQuiz.questions.filter(function (q) {
                return q.id !== qId;          // garde tout sauf la question ciblée
            });
            reindexQuestions();

        }

        // --------------- CRUD --------------------------------------------------

        vm.addQuiz = () => {
            console.log('addQuiz', vm.editQuiz);
            if (!vm.editQuiz.quiz_name || vm.editQuiz.questions.length === 0) {
                toastr.warning(JSR.questions_empty_list_notification, "", { timeOut: 10000 });
                return;
            }
            app.canSubmit(false);

            const payload = {
                quiz_name: vm.editQuiz.quiz_name,
                scope: 'course',
                scope_id: parseInt(vm.courseId, 10),
                time_limit: vm.editQuiz.time_limit || null,
                questions: vm.editQuiz.questions
            };
            var update_url = vm.editQuiz.id ? `/${vm.editQuiz.id}/update` : '/create';
            $http.post(route(update_url), payload).then((r) => {
                var q = r.data.response;
                vm.init(q);
                toastr.success(JSR.update_success, "", { timeOut: 3000 });
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        };



        // ---- Créer un quiz ----------------------------------------------------

        vm.createQuiz = function ($event) {
            setTimeout(() => {
                vm.newQuiz = angular.copy(initQuiz);


                var sequence = 0;
                if (vm.quizzes.length > 0) {
                    angular.forEach(vm.quizzes, function (val) {
                        if (val.sequence > sequence)
                            sequence = val.sequence;
                    });
                }
                sequence += 1;
                vm.newQuiz.sequence = sequence;
                $scope.$applyAsync();
                $("#editModalQuiz").modal('show');

            }, 100);
        }

        vm.submitQuiz = function (url_edit) {

            if (!vm.newQuiz.quiz_name) return;
            app.canSubmit(false);

            const payload = {
                quiz_name: vm.newQuiz.quiz_name,
                scope: 'course',
                scope_id: parseInt(vm.courseId, 10),
                time_limit: vm.newQuiz.time_limit || null,
                sequence: vm.newQuiz.sequence || 1,
                questions: vm.newQuiz.questions,
                is_visible: vm.newQuiz.is_visible || false
            };
            $http.post(route('/create'), payload)
                .then((r) => {
                    vm.newQuiz = { quiz_name: '', time_limit: null, questions: [] };
                    if (r.status == 200) {
                        var o = r.data.response;

                        var msg = "<div class='p-2'><div>{0}</div><i class='fa fa-arrow-right-long fa-2x'></i></div>".format(JSR.registration_completed)
                        toastr.success(msg, JSR.quiz, { timeOut: 10000, disableClick: true });
                        setTimeout(function () {                            
                            $window.location.href ="{0}/{1}".format($scope.edit_quiz_url, o.id)
                        }, 1000)


                    }
                    app.canSubmit(true);
                    vm.refresh();

                }, function (response) {
                    app.responseStatus(response);
                });

        };


        // --------------- HELPERS --------------------------------------------------

        function initSortable() {

            const $acc = $('#quizQuestionsAcc');

            /* détruire l’instance précédente jQuery-UI s’il y en a une */
            if ($acc.data('ui-sortable')) { $acc.sortable('destroy'); }

            $acc.sortable({
                handle: '.handle',
                items: '> .card',
                placeholder: 'sortable_placeholder',
                tolerance: 'pointer',

                update: function () {

                    const $cards = $(this).children('.card');

                    /* 1. reconstruire le tableau dans l’ordre visuel */
                    const reordered = [];
                    $cards.each(function () {
                        const id = +$(this).data('id');          // id réel de la question
                        reordered.push(vm.newQuiz.questions.find(q => q.id === id));
                    });
                    vm.newQuiz.questions = reordered;

                    /* 2. renumérotation : idx commence à 1 (1,2,3,…) */
                    $cards.each(function (i) {
                        const id = +$(this).data('id');
                        $(this).attr('data-idx', i + 1);         // attribut DOM (1-based)

                        const q = vm.newQuiz.questions.find(q => q.id === id);
                        if (q) { q.idx = i + 1; }                // valeur à enregistrer en BD
                    });

                    $scope.$applyAsync();
                }
            });
        }

        function reindexQuestions() {
            vm.newQuiz.questions.forEach(function (q, i) {
                q.idx = i + 1;                                        // 1-based
                $('#quizQuestionsAcc').find('[data-id="' + (q.id || i) + '"]')
                    .attr('data-idx', i + 1);
            });
            $scope.$applyAsync();
            console.log('reindexQuestions', vm.newQuiz.questions);
        }


    }]);

//Add / list Quizzes
app.controller('CourseQuizListCtrl', ['$http', '$scope', '$filter', '$element', '$window', function ($http, $scope, $filter, $el, $window) {
    const vm = this;
    vm.courseId = $el.attr('data-course-id');
    const api = '/api/instructor/quiz-manager';

    // État ------------------------------------------------------------------
    $scope.quiz = {};
    $scope.loadingQuizzes = true
    vm.quizzes = [];
    $scope.quiz_sequence_list = [];
    vm.newQuiz = angular.copy(initQuiz);
    vm.newQuestion = angular.copy(initQuestion);
    vm.editing = null;

    // Helpers ---------------------------------------------------------------
    const route = p => `${api}${p}`;

    var sortQuizzesBySequence = function (lst) {
        return $filter('orderBy')(lst, 'sequence', false);
    }

    //sort sequence chapter
    $scope.sortQuiz = function ($event) {
        $scope.quiz_sequence_list = angular.copy(vm.quizzes);
        if ($scope.quiz_sequence_list.length < 2) {
            toastr.info(JSR.no_need_to_order, "", { timeOut: 10000 });
            return;
        }

        $('#sortableQ').sortable({
            autocreate: false,
            update: function (evt) {
                var lst = $(this).sortable('serialize');
                var seq = 1;
                var listSorted = [];
                angular.forEach(lst, function (val) {
                    $scope.quiz_sequence_list[val.id].sequence = seq++;
                    listSorted.push($scope.quiz_sequence_list[val.id]);
                });
                $scope.quiz_sequence_list = angular.copy(listSorted);
                $scope.$apply();
            }
        });
    }
    // CRUD ------------------------------------------------------------------
    vm.refresh = () => {
        $http.get(route(`/get-by/course/${vm.courseId}`))
            .then(function (r) {
                if (r.data.status == 200) {
                    vm.quizzes = sortQuizzesBySequence(r.data.response);
                    setTimeout(function () {
                        initToolTip('[data-toggle="tooltip"]');
                    });
                }
                $scope.loadingQuizzes = false;
            }, function (response) {
                $scope.loadingQuizzes = false;
                console.log(response);
            });
    };

    // ---- Créer un quiz ----------------------------------------------------

    vm.createQuiz = function ($event) {
        setTimeout(() => {
            vm.newQuiz = angular.copy(initQuiz);


            var sequence = 0;
            if (vm.quizzes.length > 0) {
                angular.forEach(vm.quizzes, function (val) {
                    if (val.sequence > sequence)
                        sequence = val.sequence;
                });
            }
            sequence += 1;
            vm.newQuiz.sequence = sequence;

            $scope.$applyAsync();
        }, 100);
    }

    vm.submitQuiz = function (url_edit) {

        if (!vm.newQuiz.quiz_name) return;
        app.canSubmit(false);

        const payload = {
            quiz_name: vm.newQuiz.quiz_name,
            scope: 'course',
            scope_id: parseInt(vm.courseId, 10),
            time_limit: vm.newQuiz.time_limit || null,
            sequence: vm.newQuiz.sequence || 1,
            questions: vm.newQuiz.questions,
            is_visible: vm.newQuiz.is_visible || false
        };
        $http.post(route('/create'), payload)
            .then((r) => {
                vm.newQuiz = { quiz_name: '', time_limit: null, questions: [] };
                if (r.status == 200) {
                    var o = r.data.response;

                    var msg = "<div class='p-2'><div>{0}</div><i class='fa fa-arrow-right-long fa-2x'></i></div>".format(JSR.registration_completed)
                    toastr.success(msg, JSR.quiz, { timeOut: 10000, disableClick: true });
                    setTimeout(function () {
                        vm.editQuiz(o, url_edit);
                    }, 1000)


                }
                app.canSubmit(true);
                vm.refresh();

            }, function (response) {
                app.responseStatus(response);
            });

    };

    // ---- Editer -----------------------------------------------------------

    vm.editQuiz = function (q, url) {
        $window.location.href = "{0}/{1}".format(url, q.id);
    };

    vm.saveEdit = () => {
        const payload = {
            quiz_name: vm.editing.quiz_name,
            time_limit: vm.editing.time_limit
        };
        $http.post(route(`/${vm.editing.id}/update`), payload)
            .then(() => { vm.editing = null; vm.refresh(); })
            .catch(console.error);
    };

    //save change quiz sequence
    $scope.submitQuizSequence = function (list, course_quiz_sequence_update_url) {
        var dictSequences = {};
        angular.forEach(list, function (val) {
            dictSequences[val.id] = val.sequence;
        });
        $("#editModalQuizList").modal('hide');
        app.canSubmit(false);
        $http({
            method: 'POST',
            url: course_quiz_sequence_update_url,
            data: dictSequences,
            headers: { 'Content-Type': 'application/json; charset=utf-8' }
        }).then(function (response) {
            var response = response.data.response;
            if (response.sequence == "ok") {
                toastr.success(JSR.change_success, "", { timeOut: 10000 });
                vm.quizzes = angular.copy($scope.quiz_sequence_list);
            }
            else {
                toastr.error(response.data.response);
            }
            app.canSubmit(true);

        }, function (response) {
            app.responseStatus(response);
        });
    }

    //status quiz
    $scope.statusChangeQuiz = function ($event, obj, quiz_visibility_url) {
        $event.preventDefault();
        $scope.quiz = obj;
        var changeTo = $scope.quiz.is_visible ? JSR.offline : JSR.online;
        toastr.confirm('{0} : <b class="text-red">{1}</b> ?'.format(JSR.change_visibility, changeTo),
            function () {
                app.canSubmit(false);
                $scope.quiz.is_visible = !$scope.quiz.is_visible;

                $http({
                    method: 'POST',
                    url: quiz_visibility_url,
                    data: { "id": $scope.quiz.id, "is_visible": $scope.quiz.is_visible },
                    headers: { 'Content-Type': 'application/json; charset=utf-8' }
                }).then(function (response) {
                    var response = response.data.response;
                    app.canSubmit(true);
                    if (response.id > 0) {
                        var status = !$scope.quiz.is_visible ? JSR.offline : JSR.online;
                        toastr.success('{0} : <b>{1}</b> '.format(JSR.status, status));
                    }
                    else {
                        toastr.error(response.data.response);
                    }

                }, function (response) {
                    app.responseStatus(response);
                    $scope.quiz.is_visible = !$scope.quiz.is_visible;
                    $scope.$apply();
                });



            }, null);
    }

    // ---- Supprimer --------------------------------------------------------

    //delete chapter click
    vm.deleteQuizClick = function ($event, q, index) {
        $event.preventDefault();
        var titre = q.quiz_name;
        var msg_delete = '<div class="alert alert-danger" role="alert">{0}'.format(JSR.alert_action_irreversible)
            + '<hr/>' + JSR.msg_delete_confirm + '<small class="d-block border-0 rounded p-2  bg-black text-center p-1 text-xs mt-2">{0}</small></div>'.format(titre);
        toastr.confirm(msg_delete,
            function () {
                deleteQuiz(q);
            }, null);
    }
    //delete info
    var deleteQuiz = function (q) {
        app.canSubmit(false);
        $http({
            method: 'POST',
            url: route(`/${q.id}/delete`),
            headers: { 'Content-Type': 'application/json; charset=utf-8' }
        }).then(function (response) {
            app.canSubmit(true);
            var data = response.data;
            if (data.status == 200) {
                var index = vm.quizzes.findIndex(function (c) { return c.id === q.id });
                vm.quizzes.splice(index, 1);

                //reorder sequence
                if (vm.quizzes.length)
                    angular.forEach(vm.quizzes, function (val, idx) {
                        val.sequence = idx + 1;
                    });

                toastr.success('{0} : {1}'.format(JSR.quiz, JSR.deleted));
                $scope.$applyAsync();

            }
            else {
                toastr.error(data.response);
            }

        }, function (response) {
            app.responseStatus(response);
        });

    }


    // Init ------------------------------------------------------------------
    setTimeout(vm.refresh, 0)

}]);


