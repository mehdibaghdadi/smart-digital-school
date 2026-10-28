


app.controller('CalendarEventCtrl', ['$scope','downloadFactory', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings', '$filter',
    function ($scope, downloadFactory,$window, $http, cfpLoadingBar, $timeout, settings, $filter) {

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
        var content_download_media_url = settings.content_download_media_url;
        var content_download_file_url = settings.content_download_file_url;


        //return events with correction
        $scope.getListTasks = function (list_tasks) {
            angular.forEach(list_tasks, function (val, key) {

                val.end = val.end ?? "";
                val.event_description = val.event_description ?? "";
                
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
                var parent = $(info.el);


                if ($(info.el.children[0]).hasClass('fc-list-event-time')) {
                    parent = $(info.el.children[2]);
                }

                var count_assistance = info.event.extendedProps.count_assistance
                var desc = info.event.extendedProps.event_description || "";
                //var title = window.createEventTitle(info.event.title, desc);                
                //eventCl.attr("title", title);
                //eventCl.attr("role", "button");
                //eventCl.attr("data-toggle", "tooltip");

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


        //init all
        $scope.init = function (list_tasks, list_type_events, url_list_demands_ids, url_view_list_demands_ids) {

            $scope.dateToday.setHours(0, 59, 59, 0);
            $scope.url_list_demands_ids = url_list_demands_ids;
            $scope.url_view_list_demands_ids = url_view_list_demands_ids;

            //type events
            if (list_type_events.status == 200) {
                angular.forEach(list_type_events.response, function (val, key) {
                    $scope.list_type_events["{0}".format(val.id)] = val.event_calendar;
                });
            }
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
                   // console.log('Vue: ', info.view.type);
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
            console.log(calEvent)
            var event_title = calEvent.title;
            var event_color = calEvent.backgroundColor;

            var event_calendar_id = calEvent.extendedProps.event_calendar_id;
            var count_assistance = calEvent.extendedProps.count_assistance;
            var event_description = calEvent.extendedProps.event_description ?? "";

            var startStr = calEvent.startStr;
            moment.locale(JSR.current_language);
            var strDate = (new moment(startStr)).format("DD-MM-YYYY HH:mm");

            if (!enable) {
                window.showEventReadonly(event_color, event_title, event_description, strDate);
                return; 
            }
           
            var canDelete = count_assistance <= 0;
            var assistance_text = (count_assistance > 0)
                ? "<i class='fa fa-info mr-2 text-danger'></i> <small>" + JSR.demand_assist_event_nb.format(count_assistance) + "</small>"
                : "";

            var selectOptionsHtml = Object.entries($scope.list_type_events).map(function ([key, label]) {
                return '<option value="' + key + '"' + (key == event_calendar_id ? ' selected' : '') + '>' + label + '</option>';
            }).join('');

            Swal.fire({
                title: "<div><span class='fa fa-calendar-check text-info pr-2'></span>{0}</div><div><b class='text-xs'>{1}</b></div>".format(JSR.event, strDate),

                html: `
            <!-- Sélecteur d’événement -->
            <hr class="mt-0"/>
            <small class="text-xs">${JSR.choose_event_list}</small> :
            <select id="select-event-type"  
                    class="form-control text-center text-uppercase text-bold">
              ${selectOptionsHtml}
            </select>

            <!-- Zone de texte (optionnelle) -->
            <hr/>
            <textarea id="description_event"  rows="10" maxlength="1000"
                      placeholder="${JSR.description}..."
                      class="d-block form-control">${event_description}</textarea>

            <!-- Sélecteur de couleur -->
            <div class="mt-2 text-right">
            <small>${JSR.color}</small> :
            <input id="color-selector" 
                   type="color" 
                   value="${event_color}" /></div>
                `,
                footer: "{0}".format(assistance_text),
                focusConfirm: false,
                preConfirm: () => {
                    var typeValue = document.getElementById('select-event-type').value;
                    if (!typeValue || typeValue.trim().length < 1) {
                        Swal.showValidationMessage(JSR.required_field);
                        return false;
                    }
                    var descValue = document.getElementById('description_event')?.value;
                    var colorValue = document.getElementById("color-selector").value;
                    return {
                        typeEventId: typeValue,
                        color: colorValue,
                        descriptionEvent: descValue
                    };
                },
                showCancelButton: true,
                showCloseButton: true,
                showConfirmButton: true,
                showDenyButton: canDelete,
                cancelButtonText: JSR.close,
                closeButtonText: JSR.close,
                confirmButtonText: JSR.save,
                denyButtonText: JSR.delete,
                showLoaderOnConfirm: true,                 
                allowOutsideClick: true,
            }).then(function (result) {
                var id = calEvent.id;
                if (result.isConfirmed || result.isDenied) {
                    var index = $scope.list_tasks.findIndex(function (x) {
                        return (x.id != undefined) ? (x.id == id) : false;
                    });
                    if (result.isConfirmed) {
                        var type_event_id = result.value.typeEventId;
                        var title = $scope.list_type_events[type_event_id];
                        var descriptionEvent = result.value.descriptionEvent;
                        var bg = result.value.color;
                        calEvent.setProp('title', title);
                        calEvent.setProp('backgroundColor', bg);
                        calEvent.setExtendedProp('event_calendar_id', type_event_id);
                        calEvent.setExtendedProp('event_description', descriptionEvent);
                        if (index > -1) {
                            $scope.list_tasks[index].event_calendar_id = type_event_id;
                            $scope.list_tasks[index].title = title;
                            $scope.list_tasks[index].event_description = descriptionEvent;
                            $scope.list_tasks[index].backgroundColor = bg;
                            var tl=window.createEventTitle(title, descriptionEvent);
                            $(info.el).attr("title", tl);
                        }
                    } else if (result.isDenied) {
                        calEvent.setProp('url', '');
                        calEvent.remove();
                        if (index > -1) {
                            $scope.list_tasks.splice(index, 1);
                        }
                    }
                    window.resetCalendarToolTip(calendarId);
                }
            });
        };

        //add new event
        $scope.eventSelect = function (arg) {

            // On vérifie que la date sélectionnée n'est pas antérieure à "aujourd'hui"
            var dEnd = new Date(Date.parse(arg.end));
            var ok = (dEnd.getTime() >= $scope.dateToday.getTime());
            if (!ok) {
                return false;
            }

            // On empêche la propagation pour éviter d'autres handlers
            arg.jsEvent.stopPropagation();

            // Petite logique pour ignorer certaines actions
            var skipElement = "fa-info-assistance";
            var target = arg.jsEvent.target.getAttribute("data-target")
                || arg.jsEvent.target.parentElement.getAttribute("data-target");
            if (target == skipElement) return;

            var self = $scope.calendar;

            // Construction dynamique du <select> à partir de $scope.list_type_events
            // Object.entries(...) permet de parcourir un objet { cle: valeur } et de
            // générer la liste <option value="cle">valeur</option>.
            let selectOptionsHtml = Object.entries($scope.list_type_events)
                .map(function ([key, label]) {
                    return `<option value="${key}">${label}</option>`;
                }).join('');

            Swal.fire({
                title: "<div class='text-uppercase'><span class='fa fa-calendar-plus text-green pr-2 '></span>{0} : {1}</div>"
                    .format(JSR.add, JSR.event),

                // On place tout dans le html pour contrôler l'ordre
                html: `
            <!-- Sélecteur d’événement -->
            <hr class="mt-0"/>
            <small class="text-xs">${JSR.choose_event_list}</small> :
            <select id="select-event-type"  
                    class="form-control text-center text-uppercase text-bold">
              ${selectOptionsHtml}
            </select>

            <!-- Zone de texte (optionnelle) -->
            <hr/>
            <textarea id="description_event"  rows="10" maxlength="1000"
                      placeholder="${JSR.description}..."
                      class="d-block form-control"></textarea>

            <!-- Sélecteur de couleur -->
            <div class="mt-2 text-right">
            <small>${JSR.color}</small> :
            <input id="color-selector" 
                   type="color" 
                   value="${getRandomColorEvents()}" /></div>
                `,

                // On attend la validation pour récupérer les valeurs
                focusConfirm: false,
                preConfirm: () => {
                    const selectValue = document.getElementById('select-event-type')?.value;
                    const colorValue = document.getElementById('color-selector')?.value;
                    const descValue = document.getElementById('description_event')?.value;

                    // Validation : est-ce qu’un type d’événement a été sélectionné ?
                    if (!selectValue || selectValue.trim().length === 0) {
                        // Affiche un message d’erreur sous le bouton de confirmation
                        Swal.showValidationMessage(JSR.required_field);
                        return false;
                    }

                    return {
                        typeEvent: selectValue,
                        color: colorValue,
                        description: descValue
                    };
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

                // Si l’utilisateur a confirmé
                if (result.isConfirmed) {
                    // Récupération des valeurs saisies
                    var type_event_id = result.value.typeEvent;
                    var chosenColor = result.value.color;
                    var desc = result.value.description;

                    // Récupère le label associé dans la liste
                    var title = $scope.list_type_events[type_event_id];

                    if (title) {
                        // Calcule un nouvel ID négatif pour votre événement
                        var min = 0;
                        if ($scope.list_tasks && $scope.list_tasks.length > 0) {
                            min = Math.min.apply(Math, $scope.list_tasks.map(function (o) { return o.id; }));
                        }
                        min = (min >= 1) ? 0 : min;

                        var el = {
                            id: min - 1,
                            title: title,
                            event_description: desc,
                            event_calendar_id: type_event_id,
                            start: $scope.convertDateLocal(arg.startStr),
                            end: (arg.end == undefined) ? "" : $scope.convertDateLocal(arg.endStr),
                            allDay: arg.allDay,
                            backgroundColor: chosenColor,
                            editable: true,
                            durationEditable: true,
                        }
                        self.addEvent(el);
                        $scope.list_tasks.push(el);
                        self.render();

                        // Informer éventuellement le back-end ou autre
                        notifyChange(this, arg);
                    }

                    // Désélectionne sur le calendrier
                    self.unselect();
                    window.resetCalendarToolTip(calendarId);
                }
            });
        };

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

        //prevent lost unsaved data        
        
        window.addEventListener("beforeunload", function (e) {
           
            var msg = JSR.changes_made_maynotbe_saved;

            if ($scope.nbr_modification > 0) {
                toastr.info(msg_alert_modification, 'NB:', { toast: true, timeOut: 7000, position: 'bottom-end' });
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
                    
                    console.log("Download ended...")
                });


            }
        }

    }]);