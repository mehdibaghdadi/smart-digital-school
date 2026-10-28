
app.controller('LookAndFeelCtrl', ['$scope', '$http', '$window','settings',
    function ($scope, $http, $window,settings) {

        $scope.theme_loading = [];
        $scope.loading = false;
        $scope.url_set_theme = '';
        $scope.init = function (url_set_theme) {
            $scope.url_set_theme = url_set_theme;
        }
        $scope.submitForm = function (obj, id) {
            if ($scope.loading) return;

            $scope.theme_loading[id] = 1;
            $scope.loading = true;
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.url_set_theme,
                data: obj,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                
                var resp = response.data.response;
                
                app.canSubmit(true);
                $window.location.reload();
                $scope.theme_loading[id] = 0;
                $scope.loading = false;

            }, function (response) {
                $scope.loading = false;
                $scope.theme_loading[id] = 0;
                app.responseStatus(response);

            });
        };
    }]);