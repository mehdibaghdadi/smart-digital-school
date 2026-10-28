
app.controller('QualificationCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        //************ SET SCHOOL QUALIFICATION **************

        $scope.qualifications = [];
        $scope.qualifications_db = [];
        $scope.listClassroomsOccupied = [];
        var textBoxContainer = "#TextBoxContainer";
        $scope.classInit = false;

        //init data
        $scope.init = function (qualifications, qualifications_db, listClassroomsOccupied) {

            $scope.qualifications = qualifications.status == 200 ? qualifications.response : [];
            $scope.qualifications_db = qualifications_db.status == 200 ? qualifications_db.response : [];
            $scope.listClassroomsOccupied = listClassroomsOccupied.status == 200 ? listClassroomsOccupied.response : [];
            //loop
            angular.forEach($scope.qualifications, function (value, key) {
                value.selected = false;
                var index = -1;
                if ($scope.qualifications_db.length)
                    index = $scope.qualifications_db.findIndex(function (q) { return q.qualification_id === value.id });

                value.selected = (index > -1);

                if (!value.selected) {
                    value.nbr_class = 0;
                    value.classrooms_names = [];
                    value.school_qualification_id = 0;
                } else {
                    var o = $scope.qualifications_db[index];
                    value.school_qualification_id = o.id;
                    value.nbr_class = o.nbr_class;
                    try {

                        value.classrooms_names = (value.nbr_class > 0 && o.classrooms_names) ? o.classrooms_names.split(',') : [];
                    } catch (e) {
                        console.log(e)
                    }
                }

            });
            $("#body-q").removeClass("d-none");
        }

        //build classes
        $scope.buildClasses = function (objet) {
            setTimeout(function () {
                if (objet.nbr_class > 0) {
                    var target = "{0}{1}".format(textBoxContainer, objet.id);
                    objet.classrooms_names.forEach(function (item) {
                        var occupied = $scope.listClassroomsOccupied.findIndex(
                            function (x) {
                                return x.classroom == item && x.school_qualification_id == objet.school_qualification_id;
                            }) > -1 ? 1 : 0;

                        var txt = createDynamicTextBox(target, item, objet.id, isNew = 0, occupied);

                    });
                }
                return true;
            }, 200);
        }

        //get values class names
        var getValuesDynamicTextBox = function () {
            var arr = [];

            $("input[name=DynamicTextBox]").each(function () {
                var id = $(this).data("qualification");
                var name = this.value || null;
                if (name)
                    arr.push({ "id": id, "name": name.replace(",", "-") })
            });
            //reset names
            angular.forEach($scope.qualifications, function (value, key) {
                value.classrooms_names = [];
            });
            //push names
            angular.forEach(arr, function (value, key) {
                var id = value.id;
                var idx = $scope.qualifications.findIndex(function (q) { return id == q.id });
                var obj = $scope.qualifications[idx];
                obj.classrooms_names.push(value.name)
            });

            return arr;
        }

        //create textbox
        var createDynamicTextBox = function (target, value, qualification_id, isNew, occupied) {
            var div = $("<div class='col-4 col-md-3 col-lg-2 p-2 text-left' />");

            var htmlTxt = '<input {0} class="animate-opacity d-inline form-control form-control-sm elevation-1 text-bold text-uppercase text-center" placeholder="{1}..." required  autocomplete="off" style="width:85%" name="DynamicTextBox" type="text"  data-qualification="{2}" value = "{3}" />'
                .format((occupied ? 'readonly' : ''), JSR.class_name, qualification_id, value);

            var actionBtn = !!occupied
                ? '<sup title="{0}" data-toggle="tooltip" class="m-0 p-0 pb-4 text-white text-bold btn btn-xs"><i class="fa fa-lock text-warning"></i></sup>'.format(JSR.deletion_classes_prof_canceled)
                : '<button type="button" data-toggle="tooltip"  title="' + JSR.delete_classname_confirm + '" class="m-0 p-0 pb-4 text-red btn btn-xs remove-class" data-qualification="{0}" data-target="{1}" data-isnew="{2}"><sup class="pr-1 pl-1 rounded bg-red text-bold">x</sup></button>'
                    .format(qualification_id, target, isNew);

            var html = htmlTxt + actionBtn;

            div.html(html);
            $(target).append(div);
            setTimeout(function () {
                initToolTip('[data-toggle="tooltip"]');
            });
            return $(target).length;
        }

        //remove-class textbox in table
        $("form").on("click", ".remove-class", function (e) {
            e.preventDefault();
            var self = this;
            var delClass = function (id, elem) {
                var idx = $scope.qualifications.findIndex(function (q) { return id == q.id });
                $scope.qualifications[idx].nbr_class--;
                $scope.$applyAsync();
                $(elem).closest("div").remove();
            };

            var id = $(this).data("qualification");
            var isNew = $(this).data("isnew");

            if (parseInt(isNew) == 1)
                delClass(id, this);
            else {
                var msg_delete = '<div class="alert alert-danger" role="alert">{0}'.format(JSR.alert_action_irreversible)
                    + '<hr/>' + JSR.class_already_saved + '<br/>' + JSR.msg_delete_confirm + '</div>';
                toastr.confirm(msg_delete,
                    function () {
                        delClass(id, self);
                    }, null);
            }


        });

        //add textbox click
        $scope.addClassNameClick = function (objet) {
            $scope.classInit = true;
            var target = "{0}{1}".format(textBoxContainer, objet.id);
            createDynamicTextBox(target, "", objet.id, isNew = 1, occupied = 0);
            var nbr = 0;
            $(target + " " + "input[name=DynamicTextBox]").each(function () {
                nbr++;
            });
            objet.nbr_class = nbr;

        };

        //*********** methodes: qualification **************
        // delete level from DB
        var deleteQualificationDb = function (data, url) {
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
                    updateListQualification(data, true);
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

        //update subject DB
        var updateQualificationtDb = function (data, url) {

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: data,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response[0]?.school_id > 0) {
                    toastr.success(JSR.registration_completed, "", { timeOut: 10000 });
                    updateListQualification(response); // update liste
                }
                else {
                    toastr.error(response.data?.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
                app.canSubmit(true);
            });
        }

        //update Qualification List
        var updateListQualification = function (newList, remove = false) {

            angular.forEach(newList, function (value, key) {
                var current_qualification_id = value.id;
                var index = $scope.qualifications.findIndex(function (q) { return q.id === current_qualification_id });

                var add = (index < 0 && !remove);
                if (add) {

                    value.id = current_qualification_id;
                    value.selected = false;
                    value.nbr_class = 0;
                    value.classrooms_names = [];
                    value.school_qualification_id = 0;
                    $scope.qualifications.push(value);
                }
                else {
                    if (!remove) { // update
                        $scope.qualifications[index].label = value.label;
                        $scope.qualifications[index].level = value.level;
                        $scope.qualifications[index].education = value.education;
                    }
                    else // delete
                        $scope.qualifications.splice(index, 1);
                }

            });
            $scope.$applyAsync();

            setTimeout(function () {
                initToolTip('[data-toggle="tooltip"]');
            })
        }

        // prompt Add or edit : new subject 
        $scope.updateQualificationClick = function (e, qualification_id, class_text, education, level, url_edit_class_label, text_ph, text_title) {
            e.stopPropagation();
            e.preventDefault();
            var id = qualification_id || 0;
            Swal.fire({
                title: "<div><small class='fa fa-edit text-danger pr-2'></small>{0}</div>".format(text_title),
                input: 'text',
                inputValue: class_text || '',
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
                    index = $scope.qualifications.findIndex(function (q) {
                        return q.label?.toLowerCase() == text.toLowerCase()
                            && q.education?.toLowerCase() == education?.toLowerCase()
                            && q.level?.toLowerCase() == level?.toLowerCase();
                    });
                    if (index > -1) {
                        toastr.error("{0} : {1}".format(text, JSR.cancel), JSR.already_exist);
                        return;
                    }
                    var data = [];
                    data.push({ id: id, label: text, level: level, education: education });
                    updateQualificationtDb(data, url_edit_class_label);
                }
            });

        }

        //edit  level
        $scope.editLevelQualificationClick = function (e, education, level, url_edit_level_label, text_ph, text_title) {

            e.stopPropagation();
            e.preventDefault();

            var level_text = level || '';
            var isNew = level == null;

            Swal.fire({
                title: "<div><small class='fa fa-edit text-danger pr-2'></small>{0}</div>".format(text_title),
                html: '<hr class="mt-1 mb-4" /><small>{0}</small> '.format(education),

                input: 'text',
                inputValue: level_text || '',
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
                confirmButtonText: !isNew ? JSR.save : JSR.add,

                showLoaderOnConfirm: true,
                allowOutsideClick: true,
            }).then(function (result) {
                if (result.isConfirmed) {
                    var text = result.value.trim();
                    index = $scope.qualifications.findIndex(function (q) {
                        return q.level?.toLowerCase() == text.toLowerCase() && q.education?.toLowerCase() == education.toLowerCase()
                    }
                    );

                    if (index > -1) {
                        toastr.error("{0} : {1}".format(text, JSR.cancel), JSR.already_exist);
                        return;
                    }
                    var data = [];
                    if (!isNew)
                        data.push({ id: -1, new_level: text, level: level, education: education });
                    else
                        data.push({ id: -1, label: "{0}_1".format(JSR.classs), level: text, education: education });

                    updateQualificationtDb(data, url_edit_level_label);
                }
            });

        };

        // prompt delete level
        $scope.deleteLevelClick = function (event, id, url) {
            event.stopPropagation();
            event.preventDefault();
            var data = [];
            data.push({ id: id });
            var msg = '{0}'.format(JSR.msg_delete_confirm);
            toastr.confirm(msg, function () { deleteQualificationDb(data, url); }, null);


        };

        //edit  education
        $scope.editEducationQualificationClick = function (e, education, url_edit_education_label, text_ph, text_title) {

            e.stopPropagation();
            e.preventDefault();

            var education_text = education || '';
            var isNew = education == null;

            Swal.fire({
                title: "<div><small class='fa fa-edit text-danger pr-2'></small>{0}</div>".format(text_title),
                html: '<hr class="mt-1 mb-4" /><small>{0}</small> '.format(education),

                input: 'text',
                inputValue: education_text || '',
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
                confirmButtonText: !isNew ? JSR.save : JSR.add,

                showLoaderOnConfirm: true,
                allowOutsideClick: true,
            }).then(function (result) {
                if (result.isConfirmed) {
                    var text = result.value.trim();
                    index = $scope.qualifications.findIndex(function (q) { return q.education?.toLowerCase() == text.toLowerCase() });
                    if (index > -1) {
                        toastr.error("{0} : {1}".format(text, JSR.cancel), JSR.already_exist);
                        return;
                    }
                    var data = [];
                    if (!isNew)
                        data.push({ id: -1, new_education: text, education: education });
                    else
                        data.push({ id: -1, label: "{0}_1".format(JSR.classs), level: "{0}_1".format(JSR.level), education: text });

                    updateQualificationtDb(data, url_edit_education_label);
                }
            });

        };

        // prompt delete level
        $scope.deleteEducationClick = function (event, education, url) {
            event.stopPropagation();
            event.preventDefault();
            var filter = $scope.qualifications.filter(function (q) { return q.education?.toLowerCase() == education.toLowerCase() });
            var data = filter.length > 0 ? filter.map(function (a) { return { id: a.id }; }) : [];

            var msg = '<div class="alert alert-danger" role="alert">{0}'.format(JSR.alert_action_irreversible)
                + '<hr/><div class="text-yellow mt-2">{0}</div>{1}</div>'.format(education, JSR.msg_delete_confirm);

            toastr.confirm(msg, function () { deleteQualificationDb(data, url); }, null);


        };

        //add Class level
        $scope.addClassQualificationClick = function (e, education, level, url_edit_class_label, text_ph, text_title) {

            var qualification_id = 0, class_text = '';

            e.stopPropagation();
            e.preventDefault();

            var id = qualification_id || 0;
            Swal.fire({
                title: "<div><small class='fa fa-edit text-danger pr-2'></small>{0}</div>".format(text_title),
                html: '<hr class="mt-1 mb-4" /><small>{0}</small> : <small>{1}</small>'.format(education, level),

                input: 'text',
                inputValue: class_text || '',
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
                    index = $scope.qualifications.findIndex(function (q) {
                        return q.label?.toLowerCase() == text.toLowerCase()
                            && q.education?.toLowerCase() == education?.toLowerCase()
                            && q.level?.toLowerCase() == level?.toLowerCase();
                    });
                    if (index > -1) {
                        toastr.error("{0} : {1}".format(text, JSR.cancel), JSR.already_exist);
                        return;
                    }
                    var data = [];
                    data.push({ id: id, label: text, level: level, education: education });
                    updateQualificationtDb(data, url_edit_class_label);
                }
            });

        };

        //************ Submit : Save All modifications **********

        //validation
        var validationForm = function () {
            //if qualification selected nbr_class==0 must not exist
            var index = $scope.qualifications.findIndex(function (q) { return q.selected && q.nbr_class == 0 });
            return (index > -1) ? false : true;

        }

        //save data classes
        $scope.submitForm = function (url) {

            if (!validationForm()) {
                toastr.error(JSR.alert_level_at_least_one_classname, "", { timeOut: 10000 });
                return;
            }
            getValuesDynamicTextBox();

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.qualifications,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response?.school_id > 0) {
                    $('.remove-class').attr('data-isnew', 0);
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


        //************ FIRST INIT SCHOOL QUALIFICATION **************
        $scope.showOthersLevels = false;
        $scope.qualificationsLevels = [];
        $scope.initTypeQualification = function (q, education, active) {
            $scope.qualificationsLevels[q.id] = {
                id: q.id,
                label: q.label,
                level: q.level,
                education: education,
                selected: active
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
        var getQualificationslevels = function () {
            var t = [];
            angular.forEach($scope.qualificationsLevels, function (val) {
                if (val?.selected)
                    t.push(val)

            });
            return t;

        };
        $scope.saveQualificationslevels = function (url) {
            var levels_data = getQualificationslevels();
            if (levels_data?.length <= 0) {
                toastr.error(JSR.alert_no_level_class_selected, JSR.obligatory_content, { timeOut: 10000 });
                return;
            }

            var msg = '{0}.<br><br><b>{1}</b>'.format(JSR.alert_level_selected_willbe_added, JSR.continue_confirm);
            toastr.confirm(msg,
                function () {

                    app.canSubmit(false);
                    $http({
                        method: 'POST',
                        url: url,
                        data: levels_data,
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        var response = response.data.response;
                        if (response?.school_id > 0) {
                            toastr.success(JSR.registration_completed, "", { timeOut: 10000 });
                        }
                        else {
                            toastr.error(response.data.response);
                        }
                        app.canSubmit(true);
                        $scope.reloadPage();

                    }, function (response) {
                        app.responseStatus(response);
                    });

                }, null);
        }
        $scope.reloadPage = function () {
            window.location.reload();
        }

    }]);