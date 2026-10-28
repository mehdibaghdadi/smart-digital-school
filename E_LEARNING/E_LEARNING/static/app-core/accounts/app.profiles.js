app.controller('ProfileCtrl', ['$scope', '$window', 'NotificationService', '$http', 'cfpLoadingBar', '$timeout', '$filter', 'settings',
    function ($scope, $window, NotificationService, $http, cfpLoadingBar, $timeout, $filter, settings) {
        $scope.message = '';
        $scope.user = {}
        $scope.roles = settings.roles;
        var profilDropzone = function () { };

        $scope.init = function (user, url_post) {
            $scope.user = user.response;
            $scope.user.registration_date = $scope.user.registration_date.replace("T", " ");
            $scope.user.registration_date = ($filter('localeDate')($scope.user.registration_date));
            profilDropzone = createProfilDropzone(url_post);
            if (profilDropzone) {
                var picture = angular.copy($scope.user.image);
                profilDropzone.initImageUrl = picture;
                profilDropzone.initPreview(picture);
            }
        }
        var setPictureProfile = function (picture) {
            var role_sds = $window.localStorage.getItem("role-sds") || $scope.roles.student;
            try {
                $("#user-image-nav1").attr("src", picture);
                $("#user-image-nav2").attr("src", picture);

                if (role_sds == $scope.roles.school) {

                    $("#user-image-menu-school").attr("src", picture);

                    NotificationService.UserDataChange('ALL', $scope.user.email).then(function (response) {
                        console.log('Profil : UserDataChange sent successfully');
                    }, function (error) {
                        console.error('Profil : Error hub UserDataChange', error);
                    });
                }

            } catch (e) { console.log(e); }
        }

        $scope.submitForm = function (url) {
            var file = profilDropzone.getPreview();
            $scope.user.image = (file) ? file : $scope.user.image;
            profilDropzone.initImageUrl = $scope.user.image;

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.user,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var user = response.data.response;
                if (user.id > 0) {
                    toastr.success(JSR.infos_modified, JSR.your_profile_updated, { timeOut: 10000 });
                    setPictureProfile($scope.user.image);
                    app.canSubmit(true);
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

