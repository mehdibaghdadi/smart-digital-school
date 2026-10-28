app.controller('DashboardCtrl', ['$scope', '$window', '$filter', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, $window, $filter, $http, cfpLoadingBar, $timeout, settings) {
        //courses
        var dot_empty = ".. .. ...."
        $scope.course_loaded = false;
        $scope.course_total = 0;
        $scope.course_online_count = 0;
        $scope.course_online_max_date_creation = dot_empty;
        $scope.course_online_max_date_update = dot_empty;


        //enrollment
        $scope.enrollment_loaded = false;
        $scope.enrollment_total = 0;
        $scope.enrollment_courses_total = 0;
        $scope.min_enrollment_date = dot_empty;
        $scope.max_enrollment_date = dot_empty;

        //messagebox
        $scope.messagebox_loaded = false;
        $scope.messagebox_total = 0;
        $scope.max_messagebox_date = dot_empty;

        //calendar assistance
        $scope.calendar_assistance_loaded = false;
        $scope.calendar_assistance_total = 0;
        $scope.min_date_demand = dot_empty;
        $scope.max_date_demand = dot_empty;


        //courses chart contents
        $scope.content_type_dict = settings.content_type_dict();
        $scope.course_chapter_contents_loaded = false;
        $scope.total_course_content = 0;
        var date_end_chart = new Date();
        var date_end = $filter('date')(date_end_chart, 'yyyy-MM-dd');
        var date_start = new Date();
        var date_start = $filter('date')(date_start.setFullYear(date_start.getFullYear() - 1), 'yyyy-MM-dd');
        $scope.title_content_progress_top = JSR.total_type_available;
        $scope.title_content_progress_bottom = JSR.periode_from_to.format(date_start, date_end);

        //courses datas chart contents init bars
        $scope.list_content_type = {};
        angular.forEach($scope.content_type_dict, function (val, key) {
            $scope.list_content_type[val.id] = {
                id: val.id,
                count: 0,
                params: val
            };
        });

        //list Tasks events
        $scope.list_tasks_loaded = false;
        $scope.calendar = window.createFullCalendar('calendar');
        window.createEnrollmentCharts('#enrollmentChart', 0, 0);

        //INIT ALL
        //--------
        $scope.init = function (courses_report_url, enrollments_report_url, messagebox_report_url, calendar_assistance_report_url, course_chapter_contents_report_url, list_tasks_url) {

            //------ courses report
            //---------------------

            $http({
                method: 'GET',
                url: courses_report_url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.course_loaded = true;
                var data = response.data;
                if (data.status == 200) {
                    angular.forEach(data.response, function (val, key) {
                        $scope.course_total += val.count;

                        if (val.is_visible) {
                            $scope.course_online_count = val.count;
                            $scope.course_online_max_date_creation = val.max_date_creation;
                            $scope.course_online_max_date_update = val.max_date_update;

                        }
                    });
                }
                window.setNumberBadge(1000);
            }, function (response) {
                $scope.course_loaded = true;
                if (response.status != 400)
                    app.responseStatus(response);
            });

            //------ enrollments report
            //--------------------------
            $scope.enrollmentChart = null;
            $http({
                method: 'GET',
                url: enrollments_report_url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.enrollment_loaded = true;

                var data = response.data;
                if (data.status == 200) {
                    val = data.response
                    $scope.enrollment_total = val.count;
                    $scope.enrollment_courses_total = val.count_courses;
                    $scope.min_enrollment_date = val.min_enrollment_date;
                    $scope.max_enrollment_date = val.max_enrollment_date;
                    $scope.enrollmentChart = window.createEnrollmentCharts('#enrollmentChart', $scope.enrollment_courses_total, $scope.enrollment_total)
                    $scope.enrollmentChart.update();
                }
                window.setNumberBadge(1000);

            }, function (response) {
                $scope.enrollment_loaded = true;
                if (response.status != 400)
                    app.responseStatus(response);
            });

            //------ MessageBox report
            //--------------------------

            $http({
                method: 'GET',
                url: messagebox_report_url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.messagebox_loaded = true;
                var data = response.data;
                if (data.status == 200) {
                    val = data.response
                    $scope.messagebox_total = val.count;
                    if (val.max_messagebox_date)
                        $scope.max_messagebox_date = val.max_messagebox_date;
                }
                window.setNumberBadge(1000);

            }, function (response) {
                $scope.enrollment_loaded = true;
                if (response.status != 400)
                    app.responseStatus(response);
            });




            //------ calendar assistance report
            //---------------------------------

            $http({
                method: 'GET',
                url: calendar_assistance_report_url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.calendar_assistance_loaded = true;

                var data = response.data;
                if (data.status == 200) {
                    val = data.response
                    $scope.calendar_assistance_total = val.count;
                    $scope.min_date_demand = val.min_date_demand;
                    $scope.max_date_demand = val.max_date_demand;
                }

                window.setNumberBadge(1000);
            }, function (response) {
                $scope.calendar_assistance_loaded = true;
                if (response.status != 400)
                    app.responseStatus(response);
            });


            //------ contents of courses report
            //---------------------------------
            course_chapter_contents_report_url = "{0}/{1}/{2}".format(course_chapter_contents_report_url, date_start, date_end);
            var list_content = [];
            $http({
                method: 'GET',
                url: course_chapter_contents_report_url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.course_chapter_contents_loaded = true;

                var data = response.data;
                if (data.status == 200) {
                    list_content = data.response;
                }
                createChartContent(list_content);

            }, function (response) {
                $scope.course_chapter_contents_loaded = true;
                createChartContent(list_content);
                if (response.status != 400)
                    app.responseStatus(response);

            });

            //------ list Tasks Events
            //---------------------------------
            var list_tasks_events = [];
            createCalendar(list_tasks_events);
            $http({
                method: 'GET',
                url: list_tasks_url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.list_tasks_loaded = true;

                var data = response.data;
                if (data.status == 200) {
                    list_tasks_events = data.response;
                }
                createCalendar(list_tasks_events);


            }, function (response) {
                $scope.list_tasks_loaded = true;
                if (response.status != 400)
                    app.responseStatus(response);

            });




        };//END FUNC


        //CHART CONTENT BUILDER
        //----------------------
        $scope.chart_content = null;
        var createChartContent = function (list_content) {
            var list_month_chart = [];

            var now = new angular.copy(date_end_chart);
            for (i = 0; i <= 12; i++) {
                var dt = ($filter('date')(now, 'MM-yyyy'));
                list_month_chart[dt] = 0;
                now.setMonth(now.getMonth() - 1);
            }

            var total_count = 0;

            var val = list_content.reduce(function (accumulator, element) {
                var month = "{0}-{1}".format(element.month_date_update.toString().padStart(2, "0"), element.year_date_update);
                var count = parseFloat(element.count);
                var content_type_id = element.content_type_id;
                //total global
                if (!list_month_chart[month]) {
                    list_month_chart[month] = count;
                } else {
                    list_month_chart[month] += count;
                }
                total_count += count;

                //total par content type
                if ($scope.list_content_type[content_type_id]) {
                    $scope.list_content_type[content_type_id].count += count;
                    $scope.list_content_type[content_type_id].percent= 0;
                    
                }
                return list_month_chart;
            }, {});
            $scope.total_course_content = total_count;
           
            angular.forEach($scope.list_content_type, function (val, key) {
                val.percent =  Math.round((  (val.count )* 100) / total_count);
            });

            var data_x = Object.keys(list_month_chart).reverse()
            var data_y = Object.values(list_month_chart).reverse()
            var media_text = "{0}s, {1}s, {2}s, {3}s".format(settings.content_type.video[1], settings.content_type.audio[1], settings.content_type.document[1], settings.content_type.text[1])
            var title_cht = [media_text, JSR.total_content_periode_since.format(total_count.toString(), date_start)]
            text_y = JSR.nbr_by_period;
            text_x = "[ " + JSR.last_months_report + " ]";
            tooltip_x = JSR.month + ": ";
            tooltip_y = " ";
            tooltip_x_suffix = "";
            tooltip_y_suffix = " upload";

            //create graph lines
            var id = "#chart_contents_type_courses";
            $scope.chart_content = window.createChartContentInstructor(id, data_x, data_y,
                title_cht, text_y, text_x, tooltip_x, tooltip_y, tooltip_x_suffix, tooltip_y_suffix);
            $scope.chart_content.update();
        };

        //CALENDAR BUILDER
        //----------------------
        $scope.list_tasks_events = [];
        //return events with correction
        $scope.getListTasks = function () {
            angular.forEach($scope.list_tasks_events, function (val, key) {
                if (val.end == undefined)
                    val.end = "";
            });
            return $scope.list_tasks_events;
        }

        var createCalendar = function (list_tasks_events) {
            $scope.list_tasks_events = list_tasks_events;
            $scope.calendar.setOption('events', $scope.getListTasks());
            $scope.calendar.setOption('eventDidMount', function (ev) {
                try {
                    var eventCl = $(ev.el);
                    var parent = $(ev.el.children[2]);
                    var count_assistance = ev.event.extendedProps.count_assistance
                    eventCl.attr("data-toggle", "tooltip").attr("title", ev.event.title);
                    if (count_assistance > 0) {
                        var r = $('<span data-target="fa-info-assistance" class="float-right fa-info-assistance" role="button"><i class="fa text-danger fa-info-circle" ></i>&nbsp;<sub data-target="fa-info-assistance"><b>[{0}]</b></sub></div>'
                            .format(count_assistance))
                            .attr("data-toggle", "tooltip")
                            .attr("title", JSR.demand_assist_infos2.format(count_assistance))
                            .on('click', function (event) {
                                event.preventDefault();
                                event.stopPropagation();

                            });
                        parent.append(r);
                    }
                } catch (e) {
                    console.log(e);
                }
            }
            );


        }

    }]);