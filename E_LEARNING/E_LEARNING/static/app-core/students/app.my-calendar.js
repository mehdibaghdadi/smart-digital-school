app.controller('MyCalendarCtrl', ['$scope','downloadFactory', '$window', '$filter', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, downloadFactory, $window, $filter, $http, cfpLoadingBar, $timeout, settings) {

        var calendarId = "calendar";
        var content_download_media_url = settings.content_download_media_url;
        var content_download_file_url = settings.content_download_file_url;

        //list Tasks events
        $scope.list_tasks_loaded = false;
        $scope.calendar = window.createFullCalendar(calendarId);
        $scope.calendar.setOption('eventDidMount', function (info) {
            try {
                var eventCl = $(info.el);
                var parent = $(info.el);


                if ($(info.el.children[0]).hasClass('fc-list-event-time')) {
                    parent = $(info.el.children[2]);
                }

                var count_assistance = info.event.extendedProps.count_assistance
                var desc = info.event.extendedProps.event_description || "";
                var title = window.createEventTitle(info.event.title, desc);
                eventCl.attr("title", title);
                eventCl.attr("role", "button");
                eventCl.attr("data-toggle", "tooltip");

                if (count_assistance > 0) {
                    var r = $('<div data-toggle="tooltip" data-target="fa-info-assistance" class="d-block fa-info-assistance" role="button"><i class="fa text-danger fa-info-circle" ></i>&nbsp;<sub data-target="fa-info-assistance"><b>[{0}]</b></sub></div>'
                        .format(count_assistance))
                        .attr("title", JSR.demand_assist_infos.format(count_assistance))
                        .on('click', function (event) {
                            event.preventDefault();
                            event.stopPropagation();
                            $scope.eventDetails(info)
                        });
                    parent.append(r);

                }

            } catch (e) {
                console.log(e);
            }
        });

        //INIT ALL
        //--------
        $scope.init = function (list_tasks_url, url_list_demands_ids) {
            $scope.url_list_demands_ids = url_list_demands_ids;


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

            $scope.calendar.setOption('eventClick', $scope.eventClick);
            $scope.calendar.setOption('datesSet', function (info) {
                setTimeout(function () {
                    window.resetCalendarToolTip(calendarId);
                    //console.log('Vue: ', info.view.type);
                }, 300);

            });
            
            $scope.calendar.render();
            window.afterCalendarRender();

        };
        //END init

        //CALENDAR BUILDER
        //----------------------
        $scope.list_tasks_events = [];

        //return events with correction
        $scope.getListTasks = function () {
            angular.forEach($scope.list_tasks_events, function (val, key) {
                val.editable = false;
                val.event_description = val.event_description ?? "";

                if (val.end == undefined)
                    val.end = "";
            });
            return $scope.list_tasks_events;
        }

        // create calendar
        var createCalendar = function (list_tasks_events) {
            $scope.list_tasks_events = list_tasks_events;
            $scope.calendar.setOption('events', $scope.getListTasks());   
            setTimeout(function () {
                window.resetCalendarToolTip(calendarId);
                //console.log('Vue: ', info.view.type);
            }, 300);
        }

        // see event
        $scope.eventClick = function (info) {          
            info.jsEvent.preventDefault(); 

            var calEvent = info.event;
            var event_title = calEvent.title ?? "";
            var event_color = calEvent.backgroundColor ?? "";
            var event_description = calEvent.extendedProps.event_description ?? "";
            var startStr = calEvent.startStr;
            moment.locale(JSR.current_language);
            var strDate = (new moment(startStr)).format("DD-MM-YYYY HH:mm");

            window.showEventReadonly(event_color, event_title, event_description, strDate); 


        }

        //get events assistance details
        $scope.eventDetails = function (ev) {

            $scope.list_demands_loaded = false;
            ids = ev.event.extendedProps.list_instructor_calendar_assistance_ids;

            $scope.current_url_view_list_demands_ids = "{0}/{1}".format($scope.url_view_list_demands_ids, ids);
            var url = "{0}/{1}".format($scope.url_list_demands_ids, ids);
            $("#listAssistanceRequestModal").modal('show');

            $http({
                method: 'GET',
                url: url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    $scope.demands_list = response.data.response;
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);
                $scope.list_demands_loaded = true;

            }, function (response) {
                $("#listAssistanceRequestModal").modal('hide');
                $scope.list_demands_loaded = true;
                app.responseStatus(response);
            });
        }


        // extension type
        $scope.getTypeFromExtensionURL = function (attachment_url) {
            var attachment_type = {};
            if (attachment_url && attachment_url.length >= 3) {
                var ext = attachment_url.substring(attachment_url.lastIndexOf('.') + 1).toLowerCase();
                attachment_type = settings.content_type_from_ext(ext);
            }
            return attachment_type;
        }

        // Display Media, Download or show text
        $scope.player = null;

        $scope.readUploadedContent = function ($event, attachment_url, type) {
            
            var medias = [settings.content_type.video[0], settings.content_type.audio[0]];
            var isMedia = medias.includes(type.id);
            var url_media = content_download_media_url.format(encodeURIComponent(attachment_url));
            console.log(attachment_url)

            $scope.content_type_uploaded = type;
            if (isMedia) {
                if ($scope.player) {
                    $scope.player.destroy();
                }
                $scope.player = mediaPlayerContent("#player");
                $("#mediaModal").one('show.bs.modal', function (e) {
                    $scope.player.configure({
                        autoPlay: false,
                        source: url_media,
                    });
                }).on('hidden.bs.modal', function (e) {
                    if ($scope.player) {
                        $scope.player.stop();
                        $scope.player.destroy();
                    }
                }).modal('show');
            }
            else {
                downloadFactory.startDownload(
                    attachment_url,
                    content_download_file_url,
                    { "content_url": attachment_url },
                    JSR,
                    app,null
                ).then(function () {
                    console.log("Download ended...");
                });
            }
        }

    }]);