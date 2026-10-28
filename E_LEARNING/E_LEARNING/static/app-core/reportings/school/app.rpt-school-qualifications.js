
app.controller('ReportCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', '$filter', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, $filter, settings) {
        $scope.ready = false;

        //url report
        var url_report = settings.school_qualifications_report_url;

        $scope.loading = false;

        //init
        $scope.init = function (school_id) {
            $scope.ready = true;
            setTimeout($scope.generateReport(school_id),500)
        }
        $scope.generateReport = function (school_id) {
            var params = "/{0}".format(school_id);
            var url_api = url_report + params;
            $window.generateReportingViewer($scope, $http, app, url_api,0);
        }
    }]);