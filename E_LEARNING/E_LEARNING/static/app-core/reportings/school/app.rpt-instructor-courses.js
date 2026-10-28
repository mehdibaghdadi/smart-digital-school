app.controller('ReportCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', '$filter', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, $filter, settings) {
        $scope.ready = false;

        //url report
        var url_report = settings.instructor_courses_report_url;
        //params
        var today = new Date();
        $scope.dateMax = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 23, 59, 59);
        $scope.dateStr = angular.copy($scope.dateMax);
        $scope.dateStr.setMonth($scope.dateStr.getMonth() - 3);
        $scope.dateEnd = angular.copy($scope.dateMax);

        $scope.loading = false;

        //init

        $scope.init = function () {
            $scope.ready = true;
        }
       
        $scope.generateReport = function (shool_id) {
            var ds = moment($scope.dateStr).format('YYYY-MM-DD');
            var de = moment($scope.dateEnd).format('YYYY-MM-DDTHH:mm:ss');

            var prof_id = -1
            var params = "/{0}/{1}/{2}/{3}/"
                .format(
                    shool_id,
                    prof_id,
                    ds,
                    de
                );
            var url_api = url_report + params;
            $window.generateReportingViewer($scope, $http, app, url_api,3);
        }
    }]);