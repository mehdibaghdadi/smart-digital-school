
app.controller('SubjectCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.subjects = [];
        

        $scope.init = function (subjects, subjects_db) {
            //subjects
            var init_subject = subjects.status == 200 ? subjects.response : [];
            var init_subjects_db = subjects_db.status == 200 ? subjects_db.response : [];

            $scope.subjects = init_subject.reduce(function (a, d) {
                var obj = { "subject_id": d["subject_id"], "label": d["label_subject"] };
                if (!a.some(function (x) { return x.subject_id === obj.subject_id; })) { a.push(obj); }
                return a;
            }, []);

            //qualifications
            angular.forEach($scope.subjects, function (value, key) {
                var qualifications = init_subject.filter(function (x) { return x.subject_id == value.subject_id; });
                value.qualifications = qualifications;
                angular.forEach(value.qualifications, function (_val, _key) {
                    _val.selected = false;
                    _val.classrooms_teaching = [];
                    if (init_subjects_db.length) {
                        _val.selected = init_subjects_db.some(function (x) {
                            if (x.school_subject_id === _val.id) {
                                _val.classrooms_teaching = x.classrooms_teaching.split(',');
                                return true;
                            }
                            return false;
                        });
                    }
                });
            });

            $("#body-q").removeClass("d-none");
        }

        //Check Qualification
        $scope.checkQualification = function (ql, selected) {
            angular.forEach(ql, function (value, key) {
                value.selected = selected;
            });
        }

        //build data values
        var getDataValues = function () {
            var subjects_qualifications = [];
            angular.forEach($scope.subjects, function (value, key) {
                angular.forEach(value.qualifications, function (_val, _key) {
                    var item = angular.copy(_val);
                    delete item.abel_qualification;
                    delete item.label_subject;
                    delete item.level;
                    delete item.nbr_class_selected;
                    delete item.qualification_id;
                    delete item.subject_id;
                    delete item.classrooms_names;
                    delete item.classrooms_names_selected;
                    delete item.classrooms_teaching;
                    delete item.code;
                    delete item.education;
                    delete item.label_qualification;
                    subjects_qualifications.push(item);
                });
            });

            var arr = [];
            $("input[name=checkboxClasses]").each(function () {
                var id = this.getAttribute("data-subject");
                var name = this.getAttribute("data-value");
                var checked = this.checked;
                if (checked)
                    arr.push({ "id": id, "name": name })
            });
            //reset names
            angular.forEach(subjects_qualifications, function (value, key) {
                value.classrooms_teaching = [];
            });
            //push names
            angular.forEach(arr, function (value, key) {
                var id = value.id;
                var idx = subjects_qualifications.findIndex(function (q) { return id == q.id });
                var obj = subjects_qualifications[idx];
                obj.classrooms_teaching.push(value.name)
            });

            return subjects_qualifications;
        }

        //validation
        var validationForm = function (subjects_qualifications) {
            var index = subjects_qualifications.findIndex(function (q) { return q.selected });
            if (index == -1)
                return false;

            index = subjects_qualifications.findIndex(function (q) { return q.selected && q.classrooms_teaching.length == 0 });
            return (index > -1) ? false : true;

        }

        // SUBMIT
        $scope.submitForm = function (url) {
            var subjects_qualifications = getDataValues();
            if (!validationForm(subjects_qualifications)) {
                toastr.error(JSR.alert_level_at_least_one_class, "", { timeOut: 10000 });
                return;
            }
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: subjects_qualifications,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.instructor_id > 0) {
                    toastr.success(JSR.registration_completed, "", { timeOut: 10000 });
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        };

    }]);