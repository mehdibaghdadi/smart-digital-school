app.initInstructor = function (settings) {
    return {
        id: 0,
        email: '', password: '', last_name: '', first_name: '', introduction_brief: '', date_birth: null,    
        phone_primary: '', phone_secondary: '', country_city_id: 0, country_id: settings.morocco_country_id,
        address: '', registration_date: '', active_account: 1
    };
}

app.controller('InstructorCtrl', ['$rootScope', '$scope', 'NotificationService', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($rootScope, $scope, NotificationService, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.instructor_list = [];
        $scope.user = app.initInstructor(settings);
        $scope.dateBirthMax = moment().subtract(2, 'years').format('YYYY-MM-DD');
        $scope.mode_edit = false;


        $scope.init = function (max_teachers, instructor_list, instructor, mode_edit) {

            $scope.max_teachers = max_teachers;

            $scope.instructor_list = (instructor_list.status == 200) ? instructor_list.response : [];

            $scope.mode_edit = (mode_edit == 1);

            if ($scope.mode_edit && instructor.status == 200) {
                $scope.user = instructor.response;

                if ($scope.user.date_birth != null)
                    $scope.user.date_birth = new Date($scope.user.date_birth);

                $('#current_title_header_id').html(": " + $scope.user.email).addClass('ml-1 text-warning');
            }

        }
        var refreshData = function (instructor_list) {
            if (!$scope.mode_edit) {
                var country_id = $scope.user.country_id;
                $scope.user = app.initInstructor(settings);
                $scope.user.country_id = country_id;
            }

            $scope.instructor_list = instructor_list;

            //exceed            
            if ($scope.instructor_list.length >= $scope.max_teachers && !$scope.mode_edit) {
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
            if ($scope.user.date_birth != null)
                $scope.user.date_birth = moment($scope.user.date_birth).format('YYYY-MM-DD');

            var save_and_continue = submitter == "btn-save-continue";

            var instructorSubjectData = $rootScope.GetInstructorSubjectData();
            if (instructorSubjectData == null)
                return;
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: [$scope.user, instructorSubjectData],
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.instructor_id > 0) {
                    NotificationService.UserDataChange($scope.user.email, JSR.current_user_email).then(function (response) {
                        console.log('Profil : UserDataChange sent successfully : ', $scope.user.email);
                    }, function (error) {
                        console.error('Profil : Error hub UserDataChange', error);
                    });

                    if (save_and_continue) {
                        app.canSubmit(true);
                        toastr.success("<hr class='m-1'/>" + JSR.prof_saved.format($scope.user.email), JSR.validated,
                            { timeOut: 10000, toast: true, position: 'bottom-end' });
                        refreshData(response.instructor_list);
                    } else {
                        $window.location.href = url_redirect;
                    }
                }
                else {
                    toastr.error(response.data.response);
                    app.canSubmit(true);
                }

            }, function (response) {
                app.canSubmit(true);
                app.responseStatus(response);
            });
        };

    }]);


app.controller('InstructorListCtrl', ['$scope', 'NotificationService', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, NotificationService, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.instructor_update_password_url = "";
        $scope.instructor_active_user_url = "";
        $scope.instructor_update_profile_url = "";
        $scope.instructor_delete_url = "";
        $scope.dateBirthMax = moment().subtract(2, 'years').format('YYYY-MM-DD');

        $scope.instructor_list = [];
        $scope.user = app.initInstructor(settings);
        $scope.editUser = app.initInstructor(settings);

        //refresh
        var refreshData = function (instructor) {
            var index = $scope.instructor_list.findIndex(function (user) { return user.id === instructor.id });
            if (index > -1) {
                app.updateProperties(instructor, $scope.instructor_list[index]);
            }
        }

        //init
        $scope.init = function (instructor_list, instructor_update_password_url, instructor_active_user_url, instructor_update_profile_url, instructor_delete_url) {
            if (instructor_list.status == 200)
                $scope.instructor_list = instructor_list.response;

            angular.forEach($scope.instructor_list, function (value, key) {
                value.active_account = value.active_account == 1;
            });

            $scope.instructor_update_password_url = instructor_update_password_url;
            $scope.instructor_active_user_url = instructor_active_user_url;
            $scope.instructor_update_profile_url = instructor_update_profile_url;
            $scope.instructor_delete_url = instructor_delete_url;
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
                        url: $scope.instructor_delete_url,
                        data: { "id": obj.id, "email": obj.email },
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {

                        app.canSubmit(true);
                        if (response.status == 200) {
                            callNotificationService(obj.email);
                            var t = $('#table-instructor').DataTable().rows(rowId).remove().draw(false);
                            $scope.user.id = 0;
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
            window.changePasswordForm(obj, $scope.instructor_update_password_url, updatePass);
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
                        url: $scope.instructor_active_user_url,
                        data: { "id": $scope.user.id, "email": $scope.user.email, "active_account": $scope.user.active_account },
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        var response = response.data.response;
                        app.canSubmit(true);
                        if (response.id > 0) {
                            callNotificationService($scope.user.email);
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
            //console.log("user", obj)
            $("#editModal").on('shown.bs.modal', function (e) {
                $scope.editUser = angular.copy(obj);
                if ($scope.editUser.date_birth != null)
                    $scope.editUser.date_birth = new Date($scope.editUser.date_birth);
                $scope.$applyAsync();
                setTimeout(function () { $('.ddl-selector').trigger('change'); }, 200);
            }).on('hidden.bs.modal', function (e) {
                $scope.editUser = app.initInstructor(settings);
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
                url: $scope.instructor_update_profile_url,
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
                console.log('Profil : UserDataChange sent successfully : ', $scope.user.email);
            }, function (error) {
                console.error('Profil : Error hub UserDataChange', error);
            });


        }

    }]);