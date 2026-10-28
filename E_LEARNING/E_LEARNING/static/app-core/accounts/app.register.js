app.controller('RegisterCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', '$location', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, $location, settings) {
        $scope.captchaImageUrl = '';
        $scope.captchaApiUrl = '';
        $scope.user = {
            full_name: '',
            email: '',
            phone_primary: '',
            password: '',
            password_confirm: '',
            captcha_answer: '',
            country_id: settings.morocco_country_id,
            school_type_id: 2,
            accept: false
        };
        $window.localStorage.clear();

        $scope.init_captcha = function (url) {
            $scope.captchaApiUrl = url;
            setTimeout(function () {
                generateCaptcha(url);
            }, 2000);
        }
        $scope.reCaptchaClick = function (url) {
            $scope.captchaImageUrl = "";

            setTimeout(function () {
                generateCaptcha(url);
            }, 500);

        }
        var generateCaptcha = function (url) {

            $http({
                method: 'GET',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                url: url,
                responseType: 'blob'
            }).then(function (response) {
                var blob = new Blob([response.data], { type: 'image/png' });
                $scope.captchaImageUrl = URL.createObjectURL(blob);
                $scope.$applyAsync();
            }, function (response) {
                console.log('retry : ',response);
                setTimeout(function () {
                    $scope.reCaptchaClick($scope.captchaApiUrl);
                }, 3000);

            });
        }

        $scope.submitForm = function (url) {

            if ($scope.user.password != $scope.user.password_confirm) {
                toastr.error(JSR.passwords_not_identical);
                return false;
            }
            $scope.user.captcha_answer = app.removeSpace($scope.user.captcha_answer.toUpperCase());

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
                    $window.location.href = url_redirect;
                    app.canSubmit(true);
                }
                else {
                    toastr.error(response.data.response);
                    app.canSubmit(true);
                }

            }, function (response) {
                app.canSubmit(true);
                var status = app.responseStatus(response);
                console.log(status)



            });
        };

    }]);


