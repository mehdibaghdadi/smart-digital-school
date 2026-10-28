
app.controller('ReportCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', '$filter', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, $filter, settings) {
        $scope.ready = false;

        //url report
        var url_report = settings.school_my_students_report_url;

        $scope.loading = false;

        //init
        $scope.init = function (school_id) {
            $scope.ready = true;

            setTimeout($scope.generateReport(school_id), 500);
        }
        $scope.generateReport = function (school_id) {
            var params = "/{0}/{1}".format(school_id, encodeURIComponent(settings.content_get_image_url));
            var url_api = url_report + params;
            $window.generateReportingViewer($scope, $http, app, url_api,6);
        }
        
    }]);