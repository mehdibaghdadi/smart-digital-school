app.controller('CourseEditCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings', '$filter',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings, $filter) {
        $scope.editCourse = {
            id: 0, course_title: "", is_visible: 1, language_id: 0,
            school_subject_id: -1, course_brief: "", course_fee: 0,
            date_start_course: null, date_end_course: null
        };

        $scope.dateToday = new Date();
        $scope.dateTodayLess = new Date($scope.dateToday.getFullYear(), $scope.dateToday.getMonth(), $scope.dateToday.getDate(), $scope.dateToday.getHours());


        $scope.chapter = {};
        $scope.newChapter = { id: 0, chapter_title: "", chapter_description: "", sequence: 0, is_visible: 1 };
        $scope.subject_list = [];
        $scope.chapter_list = [];
        $scope.chapter_sequence_list = [];
        $scope.language_list = [];
        $scope.course_update_url = "";
        $scope.course_edit_url = "";
        $scope.course_chapter_edit_url = "";
        $scope.course_chapter_update_url = "";
        $scope.course_chapter_delete_url = "";
        $scope.course_chapter_sequence_update_url = "";
        $scope.chapter_visibility_url = "";
        $scope.showAllSubject = false;
        $scope.showEditCourse = false;
        var course_brief_id = "#course_brief_id";
        window.createSummerNoteLight(course_brief_id);


        var sortChaptersBySequence = function (lst) {
            return $filter('orderBy')(lst, 'sequence', false);
        }
        //NEW course
        $scope.init_new = function (subject, language, course_update_url, course_edit_url, current_language) {

            $scope.editCourse.isNew = true;
            $scope.editCourse.date_start_course = new Date($filter('date')($scope.dateTodayLess, "yyyy-MM-dd HH:mm"));

            $scope.showAllSubject = true;
            $scope.showEditCourse = true;
            $scope.course_update_url = course_update_url;
            $scope.course_edit_url = course_edit_url;

            if (language.status == 200) {
                $scope.language_list = language.response;
                var index = $scope.language_list.findIndex(function (l) { return l.language_code === current_language });
                if (index > -1) {
                    $scope.editCourse.selectedLanguage = $scope.language_list[index];
                }
            }

            if (subject.status == 200) {
                $scope.subject_list = subject.response;
                buildFilterHeader($scope.subject_list);
            }

            angular.forEach($scope.subject_list, function (val) {
                val.selected = (val.school_subject_id == $scope.editCourse.school_subject_id);
            });
        }

        //Edition course
        $scope.init_edit = function (course, subject, language, chapter, course_update_url,
            course_chapter_edit_url, course_chapter_update_url, course_chapter_sequence_update_url,
            chapter_visibility_url, course_chapter_delete_url) {
            $scope.editCourse.isNew = false;
            $scope.showEditCourse = false;
            $scope.course_update_url = course_update_url;
            $scope.course_chapter_edit_url = course_chapter_edit_url;
            $scope.course_chapter_update_url = course_chapter_update_url;
            $scope.course_chapter_delete_url = course_chapter_delete_url;
            $scope.course_chapter_sequence_update_url = course_chapter_sequence_update_url;
            $scope.chapter_visibility_url = chapter_visibility_url;
            var school_subject_id = 0;

            if (course.status == 200) {
                $scope.editCourse = course.response;
                school_subject_id = $scope.editCourse.school_subject_id;
                window.setSummerNoteCode(course_brief_id, $scope.editCourse.course_brief);
                $scope.editCourse.date_start_course = new Date(moment($scope.editCourse.date_start_course).format('YYYY-MM-DD HH:mm'));

                $scope.dateTodayLess = angular.copy($scope.editCourse.date_start_course);
                if ($scope.editCourse.date_end_course != null)
                    $scope.editCourse.date_end_course = new Date(moment($scope.editCourse.date_end_course).format('YYYY-MM-DD HH:mm'));

            }
            if (chapter.status == 200) {
                $scope.chapter_list = sortChaptersBySequence(chapter.response);
            }

            if (language.status == 200) {
                $scope.language_list = language.response;
                var index = $scope.language_list.findIndex(function (l) { return l.id === $scope.editCourse.language_id });
                if (index > -1) {
                    $scope.editCourse.selectedLanguage = $scope.language_list[index];
                }
            }

            if (subject.status == 200) {
                $scope.subject_list = subject.response;
                buildFilterHeader($scope.subject_list);
            }

            angular.forEach($scope.subject_list, function (val) {
                val.selected = (val.school_subject_id == school_subject_id);
            });
        }

        var buildFilterHeader = function (list) {
            $scope.selected_label_subject = "";
            $scope.selected_level = "";
            $scope.selected_label_qualification = "";

            $scope.list_label_subject = list.reduce(function (sum, o) {
                if (sum.indexOf(o.label_subject) < 0) sum.push(o.label_subject);
                return sum;
            }, []);

            $scope.list_level = list.reduce(function (sum, o) {
                if (sum.indexOf(o.level) < 0) sum.push(o.level);
                return sum;
            }, []);

            $scope.list_label_qualification = list.reduce(function (sum, o) {
                if (sum.indexOf(o.label_qualification) < 0) sum.push(o.label_qualification);
                return sum;
            }, []);
        }

        // Select subject
        $scope.selectSubject = function (obj) {
            angular.forEach($scope.subject_list, function (val) {
                val.selected = (val.school_subject_id == obj.school_subject_id);
                if (val.selected)
                    $scope.editCourse.school_subject_id = obj.school_subject_id;
            });
        }

        //create chapter
        $scope.createChapter = function ($event) {
            var sequence = 0;
            if ($scope.chapter_list.length > 0) {
                angular.forEach($scope.chapter_list, function (val) {
                    if (val.sequence > sequence)
                        sequence = val.sequence;
                });
            }
            sequence += 1;
            $scope.newChapter.sequence = sequence;
        }

        //sort sequence chapter
        $scope.sortChapter = function ($event) {
            $scope.chapter_sequence_list = angular.copy($scope.chapter_list);
            if ($scope.chapter_sequence_list.length < 2) {
                toastr.info(JSR.no_need_to_order, "", { timeOut: 10000 });
                return;
            }

            $('#sortable').sortable({
                autocreate: false,
                update: function (evt) {
                    var lst = $(this).sortable('serialize');
                    var seq = 1;
                    var listSorted = [];
                    angular.forEach(lst, function (val) {
                        $scope.chapter_sequence_list[val.id].sequence = seq++;
                        listSorted.push($scope.chapter_sequence_list[val.id]);
                    });
                    $scope.chapter_sequence_list = angular.copy(listSorted);
                    $scope.$apply();
                }
            });
        }

        //before submit course
        var beforeSubmitCourse = function (obj, course) {


            if (obj.date_start_course != null) {
                var startDate = new Date(obj.date_start_course);
                course.date_start_course = moment(startDate).format('YYYY-MM-DDTHH:mm:ss');

                if (obj.date_end_course != null) {
                    var endDate = new Date(obj.date_end_course);
                    course.date_end_course = moment(endDate).format('YYYY-MM-DDTHH:mm:ss');
                    if (endDate < startDate)
                        course.date_end_course = null;

                }
            }

            course.language_id = obj.selectedLanguage.id;
            var html = window.getSummerNoteCode(course_brief_id);
            course.course_brief = html;
            $scope.$applyAsync(function () {
                $scope.editCourse.course_brief = html;
                $scope.editCourse.date_update = new Date();
            });


            return course;
        }
        //save change course or create new
        $scope.submitForm = function (obj) {
            var editCourse = angular.copy($scope.editCourse);

            editCourse = beforeSubmitCourse(obj, editCourse);

            angular.forEach($scope.subject_list, function (val) {
                if (val.selected)
                    editCourse.school_subject_id = val.school_subject_id;
            });

            if (editCourse.school_subject_id <= 0) {
                toastr.error(JSR.choose_subject_level_school);
                window.SmootScrollView("table_subjects_school");
                return false;
            }



            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.course_update_url,
                data: editCourse,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.showEditCourse = obj.id ? false : true;
                var response = response.data.response;
                if (response.id > 0) {
                    toastr.success(JSR.registration_completed, JSR.course, { timeOut: 10000, toast: editCourse.isNew });

                    if (editCourse.isNew)
                        setTimeout(function () {
                            $window.location.href = "{0}/{1}".format($scope.course_edit_url, response.id);
                        }, 1000);
                    else
                        app.canSubmit(true);

                }
                else {
                    toastr.error(response.data.response);
                    app.canSubmit(true);
                }

            }, function (response) {
                $scope.showEditCourse = false;
                app.responseStatus(response);
            });
        };

        //status chapter
        $scope.statusChangeChapter = function ($event, obj) {
            $event.preventDefault();
            $scope.chapter = obj;
            var changeTo = $scope.chapter.is_visible ? JSR.offline : JSR.online;
            toastr.confirm('{0} : <b class="text-red">{1}</b> ?'.format(JSR.change_visibility, changeTo),
                function () {
                    app.canSubmit(false);
                    $scope.chapter.is_visible = !$scope.chapter.is_visible;

                    $http({
                        method: 'POST',
                        url: $scope.chapter_visibility_url,
                        data: { "id": $scope.chapter.id, "is_visible": $scope.chapter.is_visible },
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        var response = response.data.response;
                        app.canSubmit(true);
                        if (response.id > 0) {
                            var status = !$scope.chapter.is_visible ? JSR.offline : JSR.online;
                            toastr.success('{0} : <b>{1}</b> '.format(JSR.status, status));
                        }
                        else {
                            toastr.error(response.data.response);
                        }

                    }, function (response) {
                        app.responseStatus(response);
                        $scope.chapter.is_visible = !$scope.chapter.is_visible;
                        $scope.$apply();
                    });



                }, null);
        }

        //save change chapter sequence
        $scope.submitChapitreSequence = function (list) {
            var dictSequences = {};
            angular.forEach(list, function (val) {
                dictSequences[val.id] = val.sequence;
            });
            $("#editModalChapterList").modal('hide');
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.course_chapter_sequence_update_url,
                data: dictSequences,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.sequence == "ok") {
                    toastr.success(JSR.change_success, "", { timeOut: 10000 });
                    $scope.chapter_list = angular.copy($scope.chapter_sequence_list);
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        }

        // save chapter info
        $scope.submitChapitre = function (obj) {
            $scope.newChapter = obj;
            $("#editModalChapter").modal('hide');
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.course_chapter_update_url,
                data: $scope.newChapter,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.id > 0) {
                    var msg = "<div class='p-2'><div>{0}</div><i class='fa fa-arrow-right-long fa-2x'></i></div>".format(JSR.registration_completed)
                    toastr.success(msg, JSR.chapter, { timeOut: 10000, disableClick: true });
                    setTimeout(function () {
                        $window.location.href = "{0}/{1}".format($scope.course_chapter_edit_url, response.id);
                    }, 1000)
                }
                else {
                    toastr.error(response.data.response);
                    app.canSubmit(true);
                }

            }, function (response) {
                app.responseStatus(response);
            });
        }

        //edit chapter
        $scope.editChapter = function ($event, obj) {
            $window.location.href = "{0}/{1}".format($scope.course_chapter_edit_url, obj.id);
        }

        //delete chapter click
        $scope.deleteChapterClick = function ($event, obj, index) {
            $event.preventDefault();
            var titre = obj.chapter_title;
            var msg_delete = '<div class="alert alert-danger" role="alert">{0}'.format(JSR.alert_action_irreversible)
                + '<hr/>' + JSR.msg_delete_confirm + '<small class="d-block border-0 rounded p-2  bg-black text-center p-1 text-xs mt-2">{0}</small></div>'.format(titre);
            toastr.confirm(msg_delete,
                function () {
                    deleteChapter(obj);
                }, null);
        }
        //delete info
        var deleteChapter = function (obj) {
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.course_chapter_delete_url,
                data: { "id": obj.id },
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                app.canSubmit(true);
                var data = response.data;
                if (data.status == 200) {
                    var index = $scope.chapter_list.findIndex(function (c) { return c.id === obj.id });
                    $scope.chapter_list.splice(index, 1);

                    //reorder sequence
                    if ($scope.chapter_list.length)
                        angular.forEach($scope.chapter_list, function (val, idx) {
                            val.sequence = idx + 1;
                        });

                    toastr.success('{0} : {1}'.format(JSR.chapter, JSR.deleted));
                    $scope.$applyAsync();
                }
                else {
                    toastr.error(data.response);
                }

            }, function (response) {
                app.responseStatus(response);
            });

        }
    }]);

app.controller('CourseListCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.course = {};
        $scope.current_course = {};
        $scope.course_visibility_url = "";
        $scope.course_edit_url = "";
        $scope.course_create_url = "";
        $scope.course_delete_url = "";
        $scope.course_chapter_list_url = "";
        $scope.course_chapter_edit_url = "";
        $scope.course_list = [];
        $scope.chapter_list = [];
        $scope.quiz_list = [];


        //refresh
        var refreshData = function (instructor) {
            var index = $scope.course_list.findIndex(function (user) { return user.id === instructor.id });
            if (index > -1) {
                app.updateProperties(instructor, $scope.course_list[index]);
            }
        }

        //-------init
        $scope.init = function (course_list, course_edit_url, course_create_url, course_visibility_url, course_delete_url,
            course_chapter_list_url, course_chapter_edit_url, course_quiz_list_url, course_quiz_edit_url) {
            if (course_list.status == 200)
                $scope.course_list = course_list.response;

            $scope.course_visibility_url = course_visibility_url;
            $scope.course_edit_url = course_edit_url;
            $scope.course_create_url = course_create_url;
            $scope.course_delete_url = course_delete_url;
            $scope.course_chapter_list_url = course_chapter_list_url;
            $scope.course_chapter_edit_url = course_chapter_edit_url;
            $scope.course_quiz_list_url = course_quiz_list_url;
            $scope.course_quiz_edit_url = course_quiz_edit_url;
        }

        //status
        $scope.statusChange = function ($event, obj) {
            $event.preventDefault();
            $scope.course = obj;
            var changeTo = $scope.course.is_visible ? JSR.offline : JSR.online;
            toastr.confirm('{0} : <b class="text-red">{1}</b> ?'.format(JSR.change_visibility, changeTo),
                function () {
                    app.canSubmit(false);
                    $scope.course.is_visible = !$scope.course.is_visible;

                    $http({
                        method: 'POST',
                        url: $scope.course_visibility_url,
                        data: { "id": $scope.course.id, "is_visible": $scope.course.is_visible },
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        var response = response.data.response;
                        app.canSubmit(true);
                        if (response.id > 0) {
                            var status = !$scope.course.is_visible ? JSR.offline : JSR.online;
                            toastr.success('{0} : <b>{1}</b> '.format(JSR.status, status));
                        }
                        else {
                            toastr.error(response.data.response);
                        }

                    }, function (response) {
                        app.responseStatus(response);
                        $scope.course.is_visible = !$scope.course.is_visible;
                        $scope.$apply();
                    });



                }, null);
        }

        //infos
        $scope.create = function () {
            $window.location.href = $scope.course_create_url
        }

        // go to course
        $scope.edition = function ($event, obj) {
            $window.location.href = "{0}/{1}".format($scope.course_edit_url, obj.id);
        }

        //---------list chapters---------
        $scope.showChapters = function ($event, obj) {
            $scope.current_course = obj;
            if (obj.num_of_chapters == 0) {
                toastr.info("", JSR.empty_data);
                return;
            }

            showModalChapters([]);
            var url_chapters = $scope.course_chapter_list_url.replace("course_id", obj.id.toString());

            $http({
                method: 'GET',
                url: url_chapters,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var data = response.data;
                if (data.status == 200) {
                    $scope.chapter_list = angular.copy(data.response);
                }
                else {
                    toastr.error(data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });

        }

        var showModalChapters = function (list) {
            $("#editModalChapterList").one('show.bs.modal', function (e) {
                $scope.chapter_list = angular.copy(list);
            }).on('hidden.bs.modal', function (e) {
                $scope.chapter_list = [];
                $scope.$apply();
            }).modal('show');

        }

        //go to chapter
        $scope.editChapterClick = function ($event, obj) {
            var href = "{0}/{1}".format($scope.course_chapter_edit_url, obj.id);
            $window.open(href, '_blank');

        }

        //---------list quizzes---------
        $scope.showQuizzes = function ($event, obj) {
            $scope.current_course = obj;
            if (obj.num_of_quizzes == 0) {
                toastr.info("", JSR.empty_data);
                return;
            }

            showModalQuizzes([]);
            var url_quizzes = $scope.course_quiz_list_url.replace("-100", obj.id.toString());

            $http({
                method: 'GET',
                url: url_quizzes,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var data = response.data;
                if (data.status == 200) {
                    $scope.quiz_list = angular.copy(data.response);
                }
                else {
                    toastr.error(data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });

        }

        var showModalQuizzes = function (list) {
            $("#editModalQuizList").one('show.bs.modal', function (e) {
                $scope.quiz_list = angular.copy(list);
            }).on('hidden.bs.modal', function (e) {
                $scope.quiz_list = [];
                $scope.$apply();
            }).modal('show');

        }

        //go to quiz
        $scope.editQuizClick = function ($event, obj) {
            var href = "{0}/{1}".format($scope.course_quiz_edit_url, obj.id);
            $window.open(href, '_blank');
        }

        //----------delete course click-----------------
        $scope.deleteClick = function ($event, obj, index) {
            $event.preventDefault();
            var titre = obj.course_title;
            var msg_delete = '<div class="alert alert-danger" role="alert">{0}'.format(JSR.alert_action_irreversible)
                + '<hr/>' + JSR.msg_delete_confirm + '<small class="d-block border-0 rounded p-2  bg-black text-center p-1 text-xs mt-2">{0}</small></div>'.format(titre);
            toastr.confirm(msg_delete,
                function () {
                    deleteCourse(obj);
                }, null);
        }

        //delete info
        var deleteCourse = function (obj) {
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.course_delete_url,
                data: { "id": obj.id },
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var data = response.data;
                if (data.status == 200) {
                    var index = $scope.course_list.findIndex(function (c) { return c.id == obj.id });
                    $scope.course_list.splice(index, 1);
                    toastr.success('{0} : {1}'.format(JSR.content2, JSR.deleted));
                }
                else {
                    toastr.error(data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });

        }

    }]);

app.controller('EnrollmentCourseListCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.course_edit_url = "";
        $scope.course_list = [];

        //init
        $scope.init = function (course_list, course_edit_url) {
            if (course_list.status == 200)
                $scope.course_list = course_list.response;

            $scope.course_edit_url = course_edit_url;

        }

        // go to course
        $scope.edition = function ($event, obj) {
            var url = "{0}/{1}".format($scope.course_edit_url, obj.id);
            $window.location.href = url;
        }


    }]);