
app.controller('ReportCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', '$filter', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, $filter, settings) {
        $scope.ready = false;

        //url report
        var url_report = settings.instructor_my_students_report_url;

        $scope.loading = false;

        //init
        $scope.init = function (prof_id) {
            $scope.ready = true;
            setTimeout($scope.generateReport(prof_id), 500);
        }
        $scope.generateReport = function (prof_id) {
            var params = "/{0}/{1}".format(prof_id, encodeURIComponent(settings.content_get_image_url));
            var url_api = url_report + params;
            $window.generateReportingViewer($scope, $http, app, url_api,4);
        }
             
    }]);