app.initStudents = function (settings) {
    return {
        id: 0,
        email: '', password: '', last_name: '', first_name: '', phone_primary: '',
        phone_secondary: '', country_city_id: 0, country_id: settings.morocco_country_id,
        date_birth: null,        address: '',
        level: '', qualification: '', classroom: '', school_qualification_id: "",
        active_account: 1
    };
}

app.controller('StudentCtrl', ['$scope', 'NotificationService', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, NotificationService, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.student_list = [];
        $scope.user = app.initStudents(settings);
        $scope.dateBirthMax = moment().subtract(2, 'years').format('YYYY-MM-DD');
        $scope.init = function (max_students, student_list) {
            $scope.max_students = max_students;

            if (student_list.status == 200)
                $scope.student_list = student_list.response;
        }

        var refreshData = function (student_list) {
            var school_qualification_id = $scope.user.school_qualification_id;
            var classroom = $scope.user.classroom;
            var qualification = $scope.user.qualification;
            var level = $scope.user.level;

            var country_id = $scope.user.country_id;
            $scope.user = app.initStudents(settings);
            $scope.user.country_id = country_id;

            //Back Variables
            $scope.user.school_qualification_id = school_qualification_id;
            $scope.user.classroom = classroom;
            $scope.user.qualification = qualification;
            $scope.user.level = level;

            $scope.student_list = student_list;

            //exceed            
            if ($scope.student_list.length >= $scope.max_students ) {
                $('.footer-fix').addClass('d-none');
                $window.location.reload();

            }

            setTimeout(function () {
                $('.ddl-selector').trigger('change');
                window.SmootScrollViewTopLayout();

            }, 1000);
        }

        $scope.generatePassword = function () {
            $scope.user.password = window.passwordGenerator();
        }

        $scope.submitForm = function ($event, url, url_redirect) {
            var submitter = $event.originalEvent.submitter.id;
            var save_and_continue = submitter == "btn-save-continue";
            if ($scope.user.date_birth != null) 
                $scope.user.date_birth = moment($scope.user.date_birth).format('YYYY-MM-DD');

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.user,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.school_id > 0) {
                    
                    NotificationService.UserDataChange($scope.user.email, JSR.current_user_email).then(function (response) {
                        console.log('Profil : UserDataChange sent successfully : ', $scope.user.email);
                    }, function (error) {
                        console.error('Profil : Error hub UserDataChange', error);
                    });



                    if (save_and_continue) {
                        app.canSubmit(true);
                        toastr.success("<hr class='m-1'/>" + JSR.student_saved.format($scope.user.email), JSR.validated, { timeOut: 10000, toast: true, position: 'bottom-end' });
                        refreshData(response.student_list);
                    } else {
                        $window.location.href = url_redirect;
                    }

                }
                else {
                    toastr.error(response.data.response);
                    app.canSubmit(true);
                }

            }, function (response) {
                app.responseStatus(response);
                app.canSubmit(true);

            });
        };

    }]);


app.controller('StudentListCtrl', ['$scope', 'NotificationService', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, NotificationService, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.student_update_password_url = "";
        $scope.student_active_user_url = "";
        $scope.student_update_profile_url = "";
        $scope.student_delete_url = "";
        $scope.dateBirthMax = moment().subtract(2, 'years').format('YYYY-MM-DD');

        $scope.student_list = [];
        $scope.user = app.initStudents(settings);
        $scope.editUser = app.initStudents(settings);

        //init
        $scope.init = function (student_list, student_update_password_url, student_active_user_url, student_update_profile_url, student_delete_url) {
            if (student_list.status == 200)
                $scope.student_list = student_list.response;
            angular.forEach($scope.student_list, function (value, key) {
                value.active_account = value.active_account == 1;
                value.removed = false;
               
            });

            $scope.student_update_password_url = student_update_password_url;
            $scope.student_active_user_url = student_active_user_url;
            $scope.student_update_profile_url = student_update_profile_url;
            $scope.student_delete_url = student_delete_url;
        }

        //refresh
        var refreshData = function (student) {

            var index = $scope.student_list.findIndex(function (user) { return user.id === student.id });

            if (index > -1) {
                var selected = $('#ns_select option:selected');
                student.qualification = selected.attr("data-label");
                student.level = selected.attr("data-level");
                console.log($('#ns_select'));
                app.updateProperties(student, $scope.student_list[index]);
               
            }
            $scope.$applyAsync();
        }

        //Group by
        $scope.groupBy = function (columnId) {
            dataTableAssistance.rowGroup().dataSrc(columnId);
            dataTableAssistance.order([[columnId, 'desc'], [1, 'desc']]);
            dataTableAssistance.draw();
        }

        //delete
        $scope.deleteUser = function ($event, obj, $index) {
            $event.preventDefault();
            var rowId = "#tr{0}".format($index.toString());
            $scope.user = obj;
            toastr.confirm('<div class="alert alert-danger" role="alert">{0}'.format(JSR.alert_action_irreversible)
                + '<hr/>' + JSR.msg_delete_confirm + '<small class="d-block border bg-dark text-left p-1 text-xs mt-2">{0}</small></div>'.format(obj.email),
                function () {

                    app.canSubmit(false);
                    $http({
                        method: 'POST',
                        url: $scope.student_delete_url,
                        data: { "id": obj.id, "email": obj.email },
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {

                        app.canSubmit(true);
                        if (response.status == 200) {
                            callNotificationService(obj.email);
                            var t = $('#table-student').DataTable().rows(rowId).remove().draw(false);
                            $scope.user.id = 0;
                            $scope.user.removed = true;
                            $scope.$applyAsync();
                            toastr.success('<b>{0}</b> : {1}.'.format($scope.user.email, JSR.deleted));
                        }
                        else {
                            toastr.error(response.data.response);
                        }
                    }, function (response) {
                        app.responseStatus(response);
                    });

                }, null);
        }

        //password
        $scope.tooglePassword = function (id_pass, id_eye) {
            var type = $(id_pass).attr('type') == 'password' ? "text" : 'password';
            $(id_pass).attr('type', type);
            $(id_eye).toggleClass("fa-eye-slash").toggleClass("fa-eye");
        }

        $scope.changePassword = function ($event, obj) {
            $event.preventDefault();
            $scope.user = obj;
            var updatePass = function (password) { $scope.user.password = password; $scope.$apply(); }
            window.changePasswordForm(obj, $scope.student_update_password_url, updatePass);
        }

        //status
        $scope.statusChange = function ($event, obj) {
            $event.preventDefault();
            $scope.user = obj;
            var changeTo = $scope.user.active_account ? JSR.disabled : JSR.enabled;
            toastr.confirm(JSR.confirm_change_statut.format(changeTo),
                function () {
                    app.canSubmit(false);
                    $scope.user.active_account = !$scope.user.active_account;

                    $http({
                        method: 'POST',
                        url: $scope.student_active_user_url,
                        data: { "id": $scope.user.id, "email": $scope.user.email, "active_account": $scope.user.active_account },
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        var response = response.data.response;
                        app.canSubmit(true);
                        if (response.id > 0) {
                    callNotificationService($scope.user.email);
                            refreshData($scope.user.email);
                            var status = !$scope.user.active_account ? JSR.disabled : JSR.enabled;
                            toastr.success('{0} : <b>{1}</b> '.format(JSR.status, status));
                        }
                        else {
                            toastr.error(response.data.response);
                        }

                    }, function (response) {
                        app.responseStatus(response);
                        $scope.user.active_account = !$scope.user.active_account;
                        $scope.$apply();
                    });



                }, null);
        }

        //infos
        $scope.edition = function ($event, obj) {
            $("#editModal").on('shown.bs.modal', function (e) {   
                $scope.editUser = angular.copy(obj);

                if ($scope.editUser.date_birth != null)
                    $scope.editUser.date_birth = new Date($scope.editUser.date_birth);

                $scope.$applyAsync();
                setTimeout(function () { $('.ddl-selector').trigger('change'); }, 200);
            }).on('hidden.bs.modal', function (e) {
                $scope.editUser = app.initStudents(settings);
            }).modal('show');
        }

        //submit info
        $scope.submitInfos = function (obj, form) {
            var userData = angular.copy(obj);

            delete userData.image;

            if (userData.date_birth != null)
                userData.date_birth = moment(userData.date_birth).format('YYYY-MM-DD');

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.student_update_profile_url,
                data: userData,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                app.canSubmit(true);
                if (response.id > 0) {                    
                    callNotificationService(userData.email);
                    refreshData(obj);
                    $scope.$applyAsync();
                    $("#editModal").modal('hide');
                    toastr.success(' {0} <hr/><small>{1}</small> '.format(JSR.update_success, userData.email));
                }
                else {
                    toastr.error(response.data.response);
                }
            }, function (response) {
                app.responseStatus(response);
            });
        }

        var callNotificationService = function (targert_email) {
            NotificationService.UserDataChange(targert_email, JSR.current_user_email).then(function (response) {
                console.log('Profil : UserDataChange sent successfully : ', targert_email);
            }, function (error) {
                console.error('Profil : Error hub UserDataChange', error);
            });


        }
    }]);