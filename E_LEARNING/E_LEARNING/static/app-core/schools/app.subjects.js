
app.controller('SubjectCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        //************ SET SCHOOL SUBJECT **************

        $scope.school_id = 0;
        $scope.subjects = [];
        $scope.subjects_db = [];
        $scope.qualifications = [];
        $scope.subject_qualifications_db = [];

        $scope.init = function (school_id, subjects, subjects_db, qualifications, subject_qualifications_db) {
            $scope.school_id = school_id;

            //qualifications
            $scope.qualifications = qualifications.status == 200 ? qualifications.response : [];
            $scope.subject_qualifications_db = subject_qualifications_db.status == 200 ? subject_qualifications_db.response : [];
            angular.forEach($scope.qualifications, function (value, key) {
                value.selected = false;
            });

            //subjects
            $scope.subjects = subjects.status == 200 ? subjects.response : [];
            $scope.subjects_db = subjects_db.status == 200 ? subjects_db.response : [];


            angular.forEach($scope.subjects, function (value, key) {
                var index = -1;
                var subject_id = -1;
                var current_subject_id = value.id;
                if ($scope.subjects_db.length) {
                    index = $scope.subjects_db.findIndex(function (q) { return q.subject_id === current_subject_id });
                    if (index > -1) {
                        subject_id = $scope.subjects_db[index].subject_id;
                    }
                }
                value.qualifications = angular.copy($scope.qualifications);//apply to all

                angular.forEach(value.qualifications, function (_val, _key) {
                    _val.subject_id = current_subject_id;

                    if ($scope.subject_qualifications_db.length) {
                        var index = $scope.subject_qualifications_db.findIndex(function (q) {
                            return (q.qualification_id === _val.qualification_id && q.subject_id === subject_id);
                        });
                        _val.selected = (index > -1);
                    }
                });
            });
            setTimeout(function () {
                $("#body-q").removeClass("d-none");

            });
        }

        //Qualifications
        $scope.checkQualification = function (ql, selected) {
            angular.forEach(ql, function (value, key) {
                value.selected = selected;
            });
        }

        //*********** methodes: Subjects **************

        // delete subject from DB
        var deleteSubjectDb = function (data, url) {
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: data,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.school_id) {
                    toastr.success(JSR.finished, "", { timeOut: 10000, toast: true });
                    updateListSubject(data, true);
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
                app.canSubmit(true);
            });
        }

        // prompt delete subject
        $scope.deleteSubjectClick = function (event, id, url) {
            event.stopPropagation();
            event.preventDefault();
            var data = [];
            data.push({ id: id });
            var msg = '{0}'.format(JSR.msg_delete_confirm);
            toastr.confirm(msg, function () { deleteSubjectDb(data, url); }, null);


        };

        //update subject List
        var updateListSubject = function (newList, remove = false) {
            var acc_header = "accordion-header{0}";
            var last_id = 0;
            angular.forEach(newList, function (value, key) {
                var current_subject_id = value.id;
                var index = $scope.subjects.findIndex(function (q) { return q.id === current_subject_id });
                if (index < 0 && !remove) {
                    value.qualifications = angular.copy($scope.qualifications);//apply to all
                    angular.forEach(value.qualifications, function (_val, _key) {
                        _val.subject_id = current_subject_id;
                    });
                    $scope.subjects.push(value);
                    last_id = value.id;
                }
                else {
                    if (remove)
                        $scope.subjects.splice(index, 1); // delete
                    else {
                        $scope.subjects[index].label = value.label; // update
                        last_id = value.id;
                    }
                }
            });

            $scope.$applyAsync();
            setTimeout(function () {
                accordion_subjects.accordion("refresh");
                initToolTip('[data-toggle="tooltip"]');
                if (last_id)
                    window.SmootScrollView(acc_header.format(last_id));
            });
        }

        //update subject DB
        var updateSubjectDb = function (data, url) {

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: data,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response[0].school_id > 0) {
                    toastr.success(JSR.registration_completed, "", { timeOut: 10000 });
                    updateListSubject(response); // update liste
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
                app.canSubmit(true);
            });
        }

        // prompt Add or edit :  new subject 
        $scope.updateSubjectClick = function (e, subject_id, subject_text, url_save_subject, text_ph, text_subject) {
            e.stopPropagation();
            e.preventDefault();
            var id = subject_id || 0;
            Swal.fire({
                title: "<div><small class='fa fa-edit text-danger pr-2'></small>{0}</div>".format(text_subject),
                input: 'text',
                inputValue: subject_text || '',
                inputPlaceholder: "{0} ...".format(text_ph),
                customClass: { input: "form-control-sm text-center text-capitalize text-bold " },
                inputAttributes: {
                    autocapitalize: 'off',
                    id: "add-text",
                    autocomplete: 'off'
                },
                inputValidator: function (value) {
                    if (!value || value == '' || value.length < 1)
                        return JSR.required_field
                },
                showCancelButton: true,
                showCloseButton: true,
                showConfirmButton: true,

                cancelButtonText: JSR.close,
                closeButtonText: JSR.close,
                confirmButtonText: id ? JSR.save : JSR.add,

                showLoaderOnConfirm: true,
                allowOutsideClick: true,
            }).then(function (result) {
                if (result.isConfirmed) {
                    var text = result.value.trim();
                    index = $scope.subjects.findIndex(function (q) { return q.label?.toLowerCase() == text.toLowerCase() });
                    if (index > -1) {
                        toastr.error("{0} : {1}".format(text, JSR.cancel), JSR.already_exist);
                        return;
                    }
                    var data = [];
                    data.push({ id: id, label: text });
                    updateSubjectDb(data, url_save_subject);
                }
            });

        }

        //************ Submit : Save All modifications **********
        $scope.submitForm = function (url) {
            var subjects_qualifications = [];
            angular.forEach($scope.subjects, function (value, key) {
                angular.forEach(value.qualifications, function (_val, _key) {
                    subjects_qualifications.push(angular.copy(_val));
                });
            });
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: subjects_qualifications,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.school_id) {
                    toastr.success(JSR.registration_completed, "", { timeOut: 10000 });
                    $scope.$applyAsync();
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        };


        //************ FIRST INIT SCHOOL SUBJECT **************

        $scope.showOthersLevels = false;
        $scope.subjectsLevels = [];
        $scope.initTypeSubject = function (q, education, init) {
            $scope.subjectsLevels[q.id] = {
                id: q.id,
                label: q.label,
                level: q.level,
                education: education,
                selected: init
            };
        }
        $scope.seeOtherslevels = function () {
            $scope.showOthersLevels = !$scope.showOthersLevels;

            setTimeout(function () {

                if (!$scope.showOthersLevels)
                    window.SmootScrollView('div-preselected');
                else
                    window.SmootScrollView('div-others');
            });

        };
        var getSubjectsLevels = function () {
            var t = [];
            angular.forEach($scope.subjectsLevels, function (val) {
                if (val?.selected)
                    t.push(val)

            });
            list = t.filter(function (x, i, a) {
                var idx = a.findIndex(function (q) { return q.label == x.label })

                return idx == i;
            });
            return list;

        };
        $scope.saveSubjectsLevels = function (url) {
            var subjects_data = getSubjectsLevels();
            if (subjects_data?.length <= 0) {
                toastr.error(JSR.alert_no_subject_class_selected, JSR.obligatory_content, { timeOut: 10000 });
                return;
            }
            var msg = '{0}.<br><br><b>{1}</b>'.format(JSR.alert_subject_selected_willbe_added, JSR.continue_confirm);
            toastr.confirm(msg,
                function () {

                    app.canSubmit(false);
                    $http({
                        method: 'POST',
                        url: url,
                        data: subjects_data,
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        var response = response.data.response;
                        if (response.school_id) {
                            toastr.success(JSR.registration_completed, "", { timeOut: 10000 });
                        }
                        else {
                            toastr.error(response.data.response);
                        }
                        app.canSubmit(true);
                        window.location.reload();

                    }, function (response) {
                        app.responseStatus(response);
                    });

                }, null);
        }
                $scope.reloadPage = function () {
            window.location.reload();
        }
    }]);