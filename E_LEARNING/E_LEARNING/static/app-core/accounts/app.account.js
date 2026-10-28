app.controller('LoginCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', '$location', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, $location, settings) {

        $scope.message = '';
        $scope.roles = settings.roles;

        $scope.init = function (role) {
            var roles = settings.roles;
            var params = $location.search();
            if (params.reset_pass && params.reset_pass == '1') {
                toastr.success(JSR.your_change_pass_with_success, JSR.your_request_is_processed, { timeOut: 10000 });
            }
            var role_sds = $window.localStorage.getItem("role-sds") || roles.student;
            role_sds = (role == roles.any && role_sds == roles.school) ? roles.student : role_sds;
            role_sds = role_sds == roles.any ? roles.student : role_sds;

            var remember_me = $window.localStorage.getItem("remember-sds") || '0';

            var login_sds = $window.localStorage.getItem("login-sds") || '';
            var login_sds = remember_me == '0' ? '' : login_sds;

            $scope.user = {
                type: null,
                email: login_sds,
                password: '',
                remember: remember_me,
                type: ''
            };


            switch (role) {
                case roles.any:
                    $scope.user.type = role_sds;
                    break;
                case roles.school:
                case roles.admin:
                    $scope.user.type = role;
                    break;
                default: break;
            }

            if ($scope.user.type != null)
                $('#request-area').removeClass('d-none');
        }        

        $scope.redirectUtl = function (url) {
            $window.localStorage.clear();
            $window.location.href = url;
        }

        $scope.submitForm = function (url) {
            $window.localStorage.setItem("role-sds", $scope.user.type);
            $window.localStorage.setItem("remember-sds", $scope.user.remember);
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.user,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var data = response.data;
                var url_redirect = response.data.response;
                if (data.status == 200) {
                    $window.localStorage.setItem("login-sds", $scope.user.email);
                    $window.location.href = url_redirect;
                    app.canSubmit(true);
                }
                else {
                    toastr.error(response.data.response);
                    console.log(response)
                    app.canSubmit(true);
                }

            }, function (response) {
                    console.log(response)
                var status = app.responseStatus(response);

            });
        };

        $scope.labelRole = function (type,student,prof,school) {
            var label = '';
            switch (type) {

                case $scope.roles.student: label = student; break;
                case $scope.roles.instructor: label = prof; break;
                case $scope.roles.school: label = school; break;
                default:
            }
            return label.toLowerCase();
        }
    }]);

app.controller('ChangePasswordCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {
        $scope.user = { id: 0, role: '', email: '', old_password: '', password: '', password_confirm: '' };
        $scope.init = function (user) {
            //console.log(user)
            $scope.user_init = user;
        }


        var valideForm = function () {

            if ($scope.user_init.email != $scope.user.email) {
                toastr.error(JSR.check_your_login);
                return false;
            }

            if ($scope.user.password != $scope.user.password_confirm) {
                toastr.error(JSR.passwords_not_identical);
                return false;
            }

            $scope.user.id = $scope.user_init.id;
            $scope.user.role = $scope.user_init.role;

            return true;
        }

        $scope.submitForm = function (url) {
            if (!valideForm()) return;

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.user,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var user = response.data.response;
                if (user.id > 0) {
                    toastr.success(JSR.password_changed, JSR.your_request_is_processed, { timeOut: 10000 });
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

app.controller('ForgotPasswordCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.user = { email: '', phone_primary: '' };

        $scope.submitForm = function (url) {
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.user,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var user = response.data.response;
                if (user.id > 0) {
                    toastr.success(JSR.your_request_is_processed, "", { timeOut: 10000, toast: true });
                    $.redirect(user.url_redirect, user, "POST");

                }
                else {
                    toastr.error(response.data.response);
                    app.canSubmit(true);
                }

            }, function (response) {
                app.responseStatus(response);
            });
        };

    }]);

app.controller('RecoverPasswordCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.user = { id: 0, email: '', role: '', password: '', password_confirm: '', code_digit: '' };

        $scope.submitForm = function (url) {
            $scope.user.code_digit = app.removeSpace($scope.user.code_digit);
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.user,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var user = response.data.response;
                if (user.id > 0) {
                    toastr.success(JSR.your_request_is_processed, "", { timeOut: 10000 });
                    $.redirect(user.url_redirect, { reset_pass: '1' }, "GET");
                }
                else {
                    toastr.error(response.data.response);
                    app.canSubmit(true);
                }

            }, function (response) {
                app.responseStatus(response);
            });
        };

    }]);


