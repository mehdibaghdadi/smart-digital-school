app.controller('SubjectCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {
        $scope.subjectClik = function (url, color, total_course) {

            if (total_course == 0) {
                toastr.info("Pas de cours pour le moment", "", { timeOut: 10000 });
                return false;
            }

            app.subjectColor.current = color;
            $window.location.href = url;
        }
    }]);