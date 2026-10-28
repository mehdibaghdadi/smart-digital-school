

app.controller('InstructorListCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.search = "";       
        $scope.empty_list_search = false;

        // go to list course
        $scope.InstructorClik = function (url) {
            $window.location.href = url;
        }    

        $scope.searchText = function () {
            $scope.empty_list_search = true; 
            $scope.search = $('#search-filter').val();
            $("#content-instructor").hide().fadeIn('slow');
        }
        $scope.searchClear = function () {
            $scope.search = $('#search-filter').val('');
            $("#content-instructor").hide().fadeIn('slow');
        }

        $scope.matches = function (text) {
            if ($scope.search.length < 2) {
                $scope.empty_list_search = false;
                return true;
            }

            var pattern = new RegExp($scope.search.toLowerCase(), "gi")
            var find = pattern.test(text.toLowerCase());
            if (find)
                $scope.empty_list_search = false;
            return find
        }
    }]);