
app.controller('CalendarEventCtrl', ['$scope', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings', '$filter',
    function ($scope, $window, $http, cfpLoadingBar, $timeout, settings, $filter) {
        var calendarId = "calendar";

        $scope.nbr_modification = 0;
        var msg_alert_modification = JSR.dont_forget_save_modif;
        $scope.dateToday = new Date();
        $scope.list_tasks = [];
        $scope.list_type_events = {};
        $scope.url_list_demands_ids = "";
        $scope.url_view_list_demands_ids = "";
        $scope.current_url_view_list_demands_ids = "";
        $scope.list_demands_loaded = false;

        //return events with correction
        $scope.getListTasks = function (list_tasks) {
            angular.forEach(list_tasks, function (val, key) {

                if (val.end == undefined)
                    val.end = "";
                if (val.end) {
                    var end = new Date(Date.parse(val.end));
                    var ok = (end.getTime() >= $scope.dateToday.getTime());
                    val.editable = ok;
                    val.durationEditable = ok;
                    val.overlap = ok;
                    val.classNames = !ok ? "text-gray" : "";
                }
            });
            return list_tasks;
        }

        //create calendar
        $scope.calendar = window.createFullCalendar(calendarId);

        $scope.calendar.setOption('eventDidMount', function (info) {
            try {
                var eventCl = $(info.el);               

                //var title = window.createEventTitle(info.event.title, "");
                //eventCl.attr("title", title);
                //eventCl.attr("role", "button");
                //eventCl.attr("data-toggle", "tooltip");

            } catch (e) {
                console.log(e);
            }
        });


        //init all
        $scope.init = function (list_tasks) {

            $scope.dateToday.setHours(0, 59, 59, 0);

            // list tasks
            if (list_tasks.status == 200) {
                $scope.list_tasks = list_tasks.response;
            } else
                $scope.list_tasks = [];



            $scope.calendar.setOption('events', $scope.getListTasks($scope.list_tasks));
            $scope.calendar.setOption('eventClick', $scope.eventClick);
            $scope.calendar.setOption('select', $scope.eventSelect);
            $scope.calendar.setOption('eventDrop', $scope.eventDropResize);
            $scope.calendar.setOption('eventResize', $scope.eventDropResize);//same as Drop
            $scope.calendar.setOption('eventChange', function (changeInfo) {
                notifyChange(this, changeInfo);

            });
            $scope.calendar.setOption('datesSet', function (info) {
                setTimeout(function () {
                    window.resetCalendarToolTip(calendarId);
                    console.log('Vue: ', info.view.type);
                }, 300);
                

            });
            $scope.calendar.render();
            window.afterCalendarRender();

        }

        //notify change
        var notifyChange = function (sender, arg) {
            $scope.nbr_modification++;
            if ($scope.nbr_modification == 1)
                toastr.info(msg_alert_modification, 'NB:', { toast: true, timeOut: 7000, position: 'bottom-end' });
            $scope.$applyAsync();
        }

        //convert date
        $scope.convertDateLocal = function (datestr) {
            if (datestr) {
                if (datestr.length == 10)
                    return "{0}T{1}".format(datestr, '00:00:00');
                else
                    return datestr;
            } else
                return "";

        }

        //refresh calendar
        $scope.refreshCalendar = function (list_tasks) {
            $scope.calendar.removeAllEvents();
            $scope.list_tasks = list_tasks;
            $scope.calendar.setOption('events', $scope.getListTasks($scope.list_tasks));
            window.resetCalendarToolTip(calendarId);

        }

        //drop and resize
        $scope.eventDropResize = function (info) {
            info.jsEvent.preventDefault();
            var calEvent = info.event;
            var dEnd = new Date(Date.parse(calEvent.end));
            var ok = (dEnd.getTime() >= $scope.dateToday.getTime());
            if (ok) {
                var index = -1;
                var id = (calEvent.id);

                index = $scope.list_tasks.findIndex(function (x) {
                    return (x.id != undefined) ? (x.id == id) : false;
                });

                if (index > -1) {

                    var obj = $scope.list_tasks[index];
                    obj.allDay = calEvent.allDay;
                    obj.start = $scope.convertDateLocal(calEvent.startStr);
                    obj.end = calEvent.allDay && obj.end == null ? "" : $scope.convertDateLocal(calEvent.endStr);
                }
            } else {
                info.revert();
            }
            window.resetCalendarToolTip(calendarId);
        }

        //change text event
        $scope.eventClick = function (info) {
            info.jsEvent.preventDefault();

            var enable = (info.event.durationEditable);
            var calEvent = info.event;
            var event_title = calEvent.title;
            var event_color = calEvent.backgroundColor;
            var startStr = calEvent.startStr;
            moment.locale(JSR.current_language);
            var strDate = (new moment(startStr)).format("DD-MM-YYYY HH:mm");
            if (!enable) {
                window.showEventReadonly(event_color, "", event_title, strDate); 
                return;
            }

            var index = -1;
            var id = -1;

            Swal.fire({
                title: "<div><span class='fa fa-calendar-check text-info pr-2'></span>{0}</div><div><b class='text-xs'>{1}</b></div>".format(JSR.event, strDate),
                html: '<hr class="mt-0 mb-4" /><small>{0}</small> : <input id="color-selector" type="color" value="{1}" >'.format(JSR.color, event_color),
                input: 'textarea',
                inputValue: event_title || '',
                inputPlaceholder: "{0} ...".format(JSR.event),
                customClass: { input: "form-control-sm text-left text-capitalize text-bold " },
                inputAttributes: {
                    autocapitalize: 'off',
                    id: "add-text",
                    autocomplete: 'off',
                    maxlength: '100',
                    rows: '2',
                },
                inputValidator: function (value) {
                    if (!value || value == '' || value.length < 1)
                        return JSR.required_field
                },
                showCancelButton: true,
                showCloseButton: true,
                showConfirmButton: true,
                showDenyButton: true,

                cancelButtonText: JSR.close,
                closeButtonText: JSR.close,
                confirmButtonText: JSR.save,
                denyButtonText: JSR.delete,

                showLoaderOnConfirm: true,
                allowOutsideClick: true,
            }).then(function (result) {
                id = (calEvent.id);
                var title = result.value;

                if (result.isConfirmed || result.isDenied) {
                    index = $scope.list_tasks.findIndex(function (x) {
                        return (x.id != undefined) ? (x.id == id) : false;
                    });

                }
                if (result.isConfirmed) {
                    var bg = document.getElementById("color-selector").value;
                    calEvent.setProp('title', title);
                    calEvent.setProp('backgroundColor', bg);
                    if (index > -1) {
                        $scope.list_tasks[index].title = title;
                        $scope.list_tasks[index].backgroundColor = bg;
                        var tl = window.createEventTitle(title, "");
                        $(info.el).attr("title", tl);
                    }

                } else if (result.isDenied) {
                    calEvent.setProp('url', '');
                    calEvent.remove();
                    if (index > -1)
                        $scope.list_tasks.splice(index, 1);
                }
                window.resetCalendarToolTip(calendarId);   

            });

        }

        //add new event
        $scope.eventSelect = function (arg) {

            var dEnd = new Date(Date.parse(arg.end));
            var ok = (dEnd.getTime() >= $scope.dateToday.getTime());
            if (!ok) {
                return false;
            }

            var class_text = '';
            arg.jsEvent.stopPropagation();
            var skipElement = "fa-info-assistance";
            var target = arg.jsEvent.target.getAttribute("data-target") || arg.jsEvent.target.parentElement.getAttribute("data-target");
            if (target == skipElement) return;

            var self = $scope.calendar;
            Swal.fire({
                title: "<div class='text-uppercase'><span class='fa fa-plus-circle text-green pr-2 '></span>{0} : {1}</div>".format(JSR.add, JSR.event),
                html: '<hr class="mt-0"/><small>{0}</small> : <input id="color-selector" type="color" value="{1}" >'.format(JSR.color, getRandomColorEvents()),

                input: 'textarea',
                inputValue: class_text || '',
                inputPlaceholder: "{0} ...".format(JSR.event),
                customClass: { input: "form-control-sm text-left text-capitalize text-bold " },
                inputAttributes: {
                    autocapitalize: 'off',
                    id: "add-text",
                    autocomplete: 'off',
                    maxlength: '100',
                    rows: '2',
                },
                inputValidator: function (value) {
                    if (!value || value == '' || value.length < 1)
                        return JSR.required_field
                },

                showCancelButton: true,
                showCloseButton: true,
                showConfirmButton: true,

                cancelButtonText: JSR.cancel,
                closeButtonText: JSR.close,
                confirmButtonText: JSR.add,

                showLoaderOnConfirm: true,
                allowOutsideClick: true,
            }).then(function (result) {
                if (result.isConfirmed) {

                    var type_event_id = result.value;
                    var title = result.value;
                    if (title) {
                        var min = 0;
                        if ($scope.list_tasks && $scope.list_tasks.length > 0)
                            min = Math.min.apply(Math, $scope.list_tasks.map(function (o) { return o.id; }));
                        min = min >= 1 ? 0 : min;
                        var el = {
                            id: min - 1,
                            title: title,
                            start: $scope.convertDateLocal(arg.startStr),
                            end: arg.end == undefined ? "" : $scope.convertDateLocal(arg.endStr),
                            allDay: arg.allDay,
                            backgroundColor: document.getElementById("color-selector").value,
                            editable: true,
                            durationEditable: true,
                        }

                        self.addEvent(el);
                        $scope.list_tasks.push(el);
                        self.render();
                        notifyChange(this, arg);
                    }
                    self.unselect();
                    window.resetCalendarToolTip(calendarId);   
                }
            });
        }

        //submit form
        $scope.submitForm = function (url) {
            if ($scope.nbr_modification <= 0) { toastr.warning(' ', JSR.calendar_no_change, { timeOut: 10000, toast: true }); return false; }
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.list_tasks,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {

                if (response.status == 200) {
                    $scope.nbr_modification = 0;
                    toastr.success(JSR.calendar_events_saved, "", { timeOut: 10000 });
                    $scope.refreshCalendar(response.data.response);
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
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

        //prevent lost unsaved data        
        function AnyFunction(e) {
            toastr.info(msg_alert_modification, 'NB:');
            return 'kk';

        };
        window.addEventListener("beforeunload", function (e) {
            var msg = JSR.changes_made_maynotbe_saved;

            if ($scope.nbr_modification > 0) {
                // For modern browsers
                e.returnValue = msg;
                // For old browsers
                return msg;
            }
            return void (0);
        });

        //Annuler Modification
        $scope.AnnulerModification = function () {
            window.location.reload();

        }
    }]);