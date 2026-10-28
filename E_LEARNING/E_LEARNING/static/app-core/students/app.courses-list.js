$(function () {
    // Initialize url_menu_app  
    const url_app = window.location;
    $('div.short-links-courses a').filter(function () {
        return url_app.href.indexOf(this.href) !== -1;
    }).removeClass('text-light').addClass('active-link');

});

// Course List Controller

app.controller('CourseListCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings) {
        $scope.subjectColor = app.subjectColor.latest;
        $scope.search = "";
        $scope.empty_list_search = false;
        $scope.forceHide = { isTrigger: false, stat: true };

        $("#search-filter").focus(function () {
            $(this).val("");
        });

        $scope.devAll = function (hide) {
            $scope.forceHide.isTrigger = true;
            $scope.forceHide.stat = hide;
            $('.bg-course-item').trigger('click');
            $scope.forceHide.isTrigger = false;
            if (hide)
                window.SmootScrollViewTopLayout();
        }
        $scope.courseItemClick = function (subject) {
            var f = $scope.forceHide;
            if (f.isTrigger) {
                subject.hide = f.stat;
                return;
            }
            subject.hide = !subject.hide;
        }

        // add to favorite
        $scope.addToFavoriteClick = function (url, linkId, cours) {
            var link = $(linkId);
            var isFav = link.attr("data-fav") == "1";
            if (isFav) return;

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    toastr.success(JSR.course_fav_added, "", { timeOut: 10000 });
                    cours.isFav = 1;
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        }

        // delete from favorite
        $scope.deleteFromFavoriteClick = function (url, course_id, cours, isFav) {
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    toastr.success(JSR.course_fav_deleted, "", { timeOut: 10000 });
                    cours.isFav = 0;
                    if (isFav)
                        $(course_id).addClass("d-none");
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        }

        // go to course
        $scope.courseClik = function (url, num_of_chapters) {
            num_of_chapters = num_of_chapters || 0;
            if (num_of_chapters)
                $window.location.href = url;
            else
                toastr.error(JSR.empty_data, "", { timeOut: 10000 });
        }

        //clear search
        $scope.searchClear = function () {
            $('#search-filter').val('');
            $scope.search = '';
            $scope.empty_list_search = false;
            angular.forEach($scope.list_courses_grouped, function (course) {
                course.show = true;
                if (!$scope.header_subject[course.subject].hide)
                    $scope.header_subject[course.subject].hide = 1;
            });
            $("#content-course").hide().fadeIn('slow');
            window.SmootScrollViewTopLayout();
        }
        // search course
        $scope.searchText = function () {
            $scope.empty_list_search = true;
            $scope.search = $('#search-filter').val();

            if ($scope.search.length <= 2) {
                $scope.empty_list_search = false;
                return true;
            }
            angular.forEach($scope.header_subject, function (header_subject) {
                if (header_subject.hide == 0)
                    header_subject.hide = 1;

            });
            angular.forEach($scope.list_courses_grouped, function (course) {
                course.show = matches($scope.search, course.data);

                if (course.show && $scope.header_subject[course.subject].hide)
                    $scope.header_subject[course.subject].hide = 0;
            });

            $("#content-course").hide().fadeIn('slow');
        }

        matches = function (search, text) {

            var pattern = new RegExp(search.toLowerCase(), "gi")
            var find = pattern.test(text.toLowerCase());

            if (find) {
                $scope.empty_list_search = false;
            }
            return find;
        }

        $scope.sortDate = function (dir) {
            $("#content-course .small-box-course").sort(function (a, b) {
                var a = parseInt($(a).attr('data-index'));
                var b = parseInt($(b).attr('data-index'));
                var order = (dir == "desc") ? a - b : b - a;
                return order;
            }).hide().appendTo($("#content-course")).hide().fadeIn('slow');

        }


    }]);