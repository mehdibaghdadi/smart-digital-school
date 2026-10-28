app.initFileInfo = function () {
    return { file: null, size: 0, type: "", ext: "" };
}
app.buildContentPath = function (school_id, instructor_id) {
    return "{0}/{1}/demande-assistance".format(school_id, instructor_id);
}
app.controller('DemandAssistanceListCtrl', ['$scope', 'downloadFactory', '$filter', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, downloadFactory, $filter, $window, $http, cfpLoadingBar, $timeout, settings) {
        $scope.demands_list = [];
        $scope.listTasksFromToday = [];
        $scope.listTasksFromTodayResponse = [];
        $scope.list_type_events = [];
        $scope.instructor_assistance_url = "";
        $scope.instructor_assistance_group_url = "";
        $scope.dateToday = new Date();
        $scope.dateTodayLess = new Date($scope.dateToday.getFullYear(), $scope.dateToday.getMonth(), $scope.dateToday.getDate());
        $scope.dataGroupIds = [];
        $scope.list_enanbled = [];
        $scope.isNewPlanning = false;
        $scope.school_id = 0;
        $scope.instructor_id = 0;

        // file upload
        $scope.content_file_info = app.initFileInfo();
        $scope.content_type = {};
        $scope.msg_content_authorized = "";
        var msg_content_authorized = JSR.msg_content_authorized;
        var msg_max_file = JSR.msg_max_file.format(app.formatBytes(settings.max_size_upload))

        $scope.progressBar = 0;
        $scope.progressInfo = "";
        $scope.isGroup = false;
        var content_upload_file_url = settings.content_upload_file_url;
        var content_download_media_url = settings.content_download_media_url;
        var content_download_file_url = settings.content_download_file_url;
        var content_delete_file_url = settings.content_delete_file_url;
        var summernote_editor_id = "#snEditorContent";
        var summernote_editor_group_id = "#snEditorContentGroup";
        //compresse table
        $scope.compressTable = ($window.localStorage.getItem("_compressTable") || '1') == '1' ? true : false;

        $scope.compressTableClick = function () {
            $scope.compressTable = !$scope.compressTable;
            $window.localStorage.setItem("_compressTable", $scope.compressTable ? '1' : '0');
        }

        //helpers
        function isSameDay(d1, d2) {

            return d1.getFullYear() === d2.getFullYear() &&
                d1.getMonth() === d2.getMonth() &&
                d1.getDate() === d2.getDate();
        }

        //Format title select events
        var buildPlannedTitle = function (pl) {
            var end = angular.copy(pl.end);
            end.setMinutes(end.getMinutes() - 1);
            var sameDay = isSameDay(pl.start, end);
            var allDay = pl.allDay;

            var strD = $filter('date')(pl.start, 'dd-MM-yyyy');
            var strH = $filter('date')(pl.start, 'HH:mm');
            var endD = $filter('date')(pl.end, 'dd-MM-yyyy');
            var endH = $filter('date')(pl.end, 'HH:mm');
            endD = sameDay ? '' : endD;

            var title = "";
            if (allDay && sameDay)
                title = JSR.all_day;
            else if (allDay && !sameDay)
                title = "{0} {1}".format(endD, endH);
            else
                title = "{0} → {1} {2}".format(strH, endD, endH);


            return title;
        }

        // parse list demande
        var parselistDemand = function (list_demand) {
            angular.forEach(list_demand, function (l) {
                l.selected = false;
                l.enableEvent = true;
                l.pl = l.accepted ? $scope.getPlanning(l.instructor_calendar_id) : null;
                if (l.pl) {

                    l.pl.start = new Date(Date.parse(l.pl.start));
                    l.pl.end = new Date(Date.parse(l.pl.end));
                    l.pl.event_description = l.pl.event_description ?? "";
                    l.enableEvent = (l.pl.end.getTime() >= $scope.dateToday.getTime());
                    l.pl.plannedTitle = buildPlannedTitle(l.pl);
                }

            });

            //list ids can be modified
            $scope.list_enanbled = list_demand.filter(x => !x.enableEvent).map(a => a.id.toString());

            return list_demand;
        }

        // parse list tasks
        var parselistTasksFromToday = function (listTasksFromToday) {
            angular.forEach(listTasksFromToday, function (pl) {
                pl.start = new Date(Date.parse(pl.start));
                pl.end = new Date(Date.parse(pl.end));
                pl.enableDate = (pl.end.getTime() >= $scope.dateToday.getTime());
                pl.plannedTitle = buildPlannedTitle(pl);
            });
            return listTasksFromToday;
        }

        //********* INIT DATA  *******************
        $scope.init = function (demands_list, listTasksFromToday, list_type_events, url_save_response, url_save_group_response, school_id, instructor_id) {


            $scope.school_id = school_id;
            $scope.instructor_id = instructor_id;


            $scope.instructor_assistance_url = url_save_response;
            $scope.instructor_assistance_group_url = url_save_group_response;


            if (list_type_events.status == 200)
                $scope.list_type_events = list_type_events.response;

            if (listTasksFromToday.status == 200) {
                $scope.listTasksFromToday = parselistTasksFromToday(listTasksFromToday.response);
            }
            if (demands_list.status == 200)
                $scope.demands_list = parselistDemand(demands_list.response);

            // for list content : css and text
            $scope.content_type.allowed_ext = getAllowedExtension();
            $scope.msg_content_authorized = msg_content_authorized.format(JSR.file, $scope.content_type.allowed_ext);
            $scope.msg_content_authorized += "<br/><br/>" + msg_max_file;

            console.log($scope.demands_list);
        }

        // extension allowed
        var getAllowedExtension = function () {
            var dict_ext = settings.content_type_dict();
            return (
                dict_ext[1].allowed_ext + ","
                + dict_ext[2].allowed_ext + ","
                + dict_ext[3].allowed_ext);
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

        // show planning column
        $scope.getPlanning = function (instructor_calendar_id) {
            var p = null;
            if (instructor_calendar_id > 0) {
                var index = $scope.listTasksFromToday.findIndex(function (l) { return l.id === instructor_calendar_id });
                if (index > -1) {
                    p = $scope.listTasksFromToday[index];
                }
            }
            return p;
        }

        //Group by
        $scope.groupBy = function (columnId) {
            dataTableAssistance.rowGroup().dataSrc(columnId);
            dataTableAssistance.order([[columnId, 'desc'], [1, 'desc']]);
            dataTableAssistance.draw(true);
        }

        //check group
        $scope.checkAllGroup = function (checked) {
            var a = ".dtrg-group  a.dropdown-item-{0}-all".format(checked ? 'select' : 'unselect');
            try {
                $(a).trigger('click', ['trigger']);
            } catch (e) {
                console.log(e);
            }
        }

        $scope.checkboxGroupClick = function (ids, checked, arg) {
            //console.log(arg)
            var list_enanbled = $scope.list_enanbled;

            var tIds = ids.split(',');

            if (list_enanbled.length)
                tIds = tIds.filter(d => !list_enanbled.includes(d));


            if (checked)
                $scope.dataGroupIds = $scope.dataGroupIds.concat(tIds);
            else
                $scope.dataGroupIds = ($scope.dataGroupIds.filter(d => !tIds.includes(d)));

            angular.forEach($scope.demands_list, function (l) {
                if (l.enableEvent)
                    l.selected = $scope.dataGroupIds.findIndex(function (id) { return l.id == id }) > -1;
            });
            $scope.$applyAsync();

            var idsExists = (tIds.length > 0)
            if (!idsExists && checked && arg != 'trigger') {
                console.log(arg)
                toastr.error(JSR.check_atleast_one_demand, "", { timeOut: 15000 });
            }

            return idsExists;

        }

        //need Assistance single
        var needAssistanceUser = function ($event, obj) {
            resetContentFile();
            $scope.demand_ass = angular.copy(obj);

            $scope.demand_ass.accepted = 1;

            $scope.demand_ass.instructor_calendar_id = $scope.demand_ass.accepted ? ($scope.demand_ass.instructor_calendar_id | 0) : 0;
            $scope.demand_ass.response_demand = (obj.response_demand) ? obj.response_demand : "";
            $scope.demand_ass.response_demand_link = (obj.response_demand_link) ? obj.response_demand_link : "";
            $scope.demand_ass.attachment_url = (obj.attachment_url) ? obj.attachment_url : "";
            $scope.demand_ass.attachment_type = (obj.attachment_type) ? obj.attachment_type : {};


            $("#assistanceRequestModal").one('show.bs.modal', function (e) {
                window.createSummerNoteLight(summernote_editor_id);
                window.setSummerNoteCode(summernote_editor_id, $scope.demand_ass.response_demand);

            }).modal('show');
        }

        $scope.needAssistanceUserClick = function ($event, obj, isNew) {
            angular.forEach($scope.demands_list, function (l) {
                l.selected = false;
            });

            if (isNew)
                $scope.needAssistanceGroupClick($event, true, true, obj.id);
            else
                needAssistanceUser($event, obj);
        }

        //need Assistance Group
        $scope.needAssistanceGroupClick = function ($event, isNew, oneUser = false, userId = 0) {
            resetContentFile();
            $scope.isNewPlanning = isNew;
            $scope.oneUser = oneUser;
            $scope.fullnameStudent = "";
            $scope.dataGroupIds = [];
            if (oneUser)
                $scope.dataGroupIds = $scope.demands_list.filter(x => x.id == userId).map(a => a.id.toString());
            else
                $scope.dataGroupIds = $scope.demands_list.filter(x => x.selected).map(a => a.id.toString());

            if ($scope.dataGroupIds.length == 0) {
                toastr.error(JSR.check_atleast_one_demand, "", { timeOut: 20000 });
                return false;
            }

            try {
                if (oneUser) {
                    angular.forEach($scope.demands_list, function (l) {
                        l.selected = false;
                        if (l.id == userId)
                            $scope.fullnameStudent = "{0} {1}".format(l.student_last_name, l.student_first_name);
                    });
                }
            } catch (e) {
            }

            var response_demand = '';
            var response_demand_link = '';
            var item_exists = false;
            $scope.dataGroupIds.forEach(function (id) {
                if (item_exists) return;
                var idx = $scope.demands_list.findIndex(function (l) { return l.id == id });
                if (idx > -1) {
                    var item = $scope.demands_list[idx];
                    response_demand = (item.response_demand) ? item.response_demand : "";
                    response_demand_link = (item.response_demand_link) ? item.response_demand_link : "";
                    item_exists = true;
                }
            });



            $scope.demand_ass = {
                isNew: isNew,
                groupIds: $scope.dataGroupIds,
                accepted: 1,
                instructor_calendar_id: 0,
                response_demand: response_demand,
                response_demand_link: response_demand_link,
                event_calendar_title: "-",
                event_calendar_id: "",
                date: $scope.dateTodayLess,
                start: "10:00",
                end: "12:00",
                dateStr: "",
                dateEnd: "",
                attachment_url: "",
                attachment_type: {},
                update: function () {
                    this.dateStr = "{0}T{1}:00".format($filter('date')(this.date, "yyyy-MM-dd"), this.start);
                    this.dateEnd = "{0}T{1}:00".format($filter('date')(this.date, "yyyy-MM-dd"), this.end);
                    if (!this.isNew) {
                        this.event_calendar_id = 0;
                    }
                    var id_event = typeof (this.event_calendar_id) == "string" ? parseInt(this.event_calendar_id) : this.event_calendar_id;
                    if (this.isNew && id_event) {
                        var idx = $scope.list_type_events.findIndex(function (l) { return l.id == id_event });

                        if (idx > -1)
                            this.event_calendar_title = $scope.list_type_events[idx].event_calendar;
                    }
                }
            };
            $scope.demand_ass.update();

            $("#assistanceRequestGroupModal").one('show.bs.modal', function (e) {
                window.createSummerNoteLight(summernote_editor_group_id);
                window.setSummerNoteCode(summernote_editor_group_id, $scope.demand_ass.response_demand);

                if ($scope.isNewPlanning)
                    createTimeRangePicker();
            }).modal('show');
        };

        // reject demand user
        $scope.rejectAssistanceUserClick = function ($event, obj) {
            $event.preventDefault();
            var description_demand = obj.description_demand;

            $scope.demand_ass = angular.copy(obj);

            $scope.demand_ass.accepted = 0;

            $scope.demand_ass.instructor_calendar_id = 0;
            $scope.demand_ass.response_demand = '{0}:{1}'.format(JSR.demand_student, JSR.cancel);
            $scope.demand_ass.response_demand_link = "";
            $scope.demand_ass.attachment_url = "";
            $scope.demand_ass.attachment_type = {};

            var msg_delete = '<div>{0} {1} ?</div>'
                .format(JSR.cancel, JSR.demand_student);
            toastr.confirm(msg_delete,
                function () {
                    sendResponseStudentDemandAssistanceSubmit("");
                }, null);
        }

        // calendar change selected
        $scope.onSelectChange = function () {
            $scope.demand_ass.update();
        }

        // create Time Range Picker slider
        var createTimeRangePicker = function () {
            setTimeout(function () {
                $slider = $('#slider-range');
                $slider.slider({
                    range: true,
                    min: 0,
                    max: 1430,
                    step: 30,
                    values: [600, 720],
                    slide: function (e, ui) {
                        var hours1 = Math.floor(ui.values[0] / 60);
                        var minutes1 = ui.values[0] - (hours1 * 60);

                        if (hours1.toString().length == 1) hours1 = '0' + hours1;
                        if (minutes1.toString().length == 1) minutes1 = '0' + minutes1;
                        if (minutes1 == 0) minutes1 = '00';

                        var start = hours1 + ':' + minutes1;
                        $('#slider-time-1').val(start);
                        $scope.demand_ass.start = start;

                        var hours2 = Math.floor(ui.values[1] / 60);
                        var minutes2 = ui.values[1] - (hours2 * 60);

                        if (hours2.toString().length == 1) hours2 = '0' + hours2;
                        if (minutes2.toString().length == 1) minutes2 = '0' + minutes2;
                        if (minutes2 == 0) minutes2 = '00';

                        var end = hours2 + ':' + minutes2;
                        $('#slider-time-2').val(end);
                        $scope.demand_ass.end = end;
                    },
                    stop: function (event, ui) {
                        $scope.$apply();
                        $scope.demand_ass.update();
                    }
                });
            }, 500);
        }

        //********* SUBMIT DATA  *******************
        //*******************************************

        // Student refresh after submit
        var refreshAfterSubmit = function (data_assistance) {
            //console.log(data_assistance)

            var index = $scope.demands_list.findIndex(function (l) { return l.id === data_assistance.id });
            if (index > -1) {
                $scope.demands_list[index].accepted = data_assistance.accepted;
                $scope.demands_list[index].response_demand = data_assistance.response_demand;
                $scope.demands_list[index].response_demand_link = data_assistance.response_demand_link;
                $scope.demands_list[index].instructor_calendar_id = data_assistance.instructor_calendar_id | 0;
                $scope.demands_list[index].attachment_url = data_assistance.attachment_url;
            }
            toastr.success(JSR.message_sended2, "", { timeOut: 15000 });
            $scope.demands_list = parselistDemand($scope.demands_list);
            console.log(data_assistance);
            updateNavigationHeader();

        }

        // Student need Assistance
        var sendResponseStudentDemandAssistanceSubmit = function (attachment_url) {
            var url = $scope.instructor_assistance_url;
            var o = $scope.demand_ass;

            var data_assistance = {
                "demand_id": o.id,
                "response_demand": o.response_demand,
                "response_demand_link": o.response_demand_link,
                "accepted": o.accepted,
                "instructor_calendar_id": o.instructor_calendar_id,
                "attachment_url": o.attachment_url
            };

            app.canSubmit(false);

            $http({
                method: 'POST',
                url: url,
                data: data_assistance,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    refreshAfterSubmit(response.data.response);
                }
                else {
                    window.location.reload();
                }
                app.canSubmit(true);

            }, function (response) {
                if (response.status == 400)
                    refreshAfterSubmit(data_assistance);
                else
                    app.responseStatus(response);
            });

            $("#assistanceRequestModal").modal('hide');

        }

        // Group if calendar event exists
        var validateCalendar = function () {
            var result = { ok: true, message: "" };

            var dstart = new Date(Date.parse($scope.demand_ass.dateStr));
            var dend = new Date(Date.parse($scope.demand_ass.dateEnd));

            var lstart = null;
            var lend = null;
            var exists = false;
            if (dstart < new Date()) {
                result.message = JSR.date_less_than_today;
                result.ok = false;
                return result;
            }

            angular.forEach($scope.listTasksFromToday, function (l) {
                if (!exists) {
                    lstart = new Date(Date.parse(l.start));
                    lend = new Date(Date.parse(l.end));
                    if (dstart >= lstart && dstart <= lend) {
                        exists = true;
                    }
                    else if (dend >= lstart && dend <= lend) {
                        exists = true;
                    }
                    else if (dstart < lstart && dend > lend) {
                        exists = true;
                    }
                }
            });
            if (exists) {
                var d1 = $filter('date')(lstart, "dd/MM/yyyy - HH:mm");
                var d2 = $filter('date')(lend, "dd/MM/yyyy - HH:mm");
                result.message =
                    JSR.schedule_conflict_already_exist
                    + "<hr/>"
                    + JSR.periode_from_to.format(d1, d2);
                result.ok = false;
            }
            return result;
        }

        // Group refresh  after submit
        var refreshGroupAfterSubmit = function (response, data_assistance) {
            var isNew = response.isNew;
            var list_demand = response.list_demand;
            var new_calendar = response.new_calendar;

            if (isNew) {
                $scope.listTasksFromToday.push(new_calendar);
                $scope.listTasksFromToday = parselistTasksFromToday($scope.listTasksFromToday);
                //$scope.listTasksFromTodayResponse = parselistTasksFromTodayResponse($scope.listTasksFromToday);
            }

            angular.forEach(list_demand, function (val) {
                var index = $scope.demands_list.findIndex(function (l) { return l.id == val.id });
                if (index > -1) {
                    $scope.demands_list[index].accepted = val.accepted;
                    $scope.demands_list[index].response_demand = val.response_demand;
                    $scope.demands_list[index].response_demand_link = val.response_demand_link;
                    $scope.demands_list[index].instructor_calendar_id = val.instructor_calendar_id | 0;
                    $scope.demands_list[index].attachment_url = val.attachment_url;
                }
            });

            $scope.demands_list = parselistDemand($scope.demands_list);


            toastr.success(JSR.message_sended2, "", { timeOut: 15000 });
            updateNavigationHeader();

        }

        // Group need Assistance  
        var sendResponseGroupDemandAssistanceSubmit = function (attachment_url) {
            var url = $scope.instructor_assistance_group_url;
            var data_assistance = angular.copy($scope.demand_ass);
            data_assistance.groupIds = data_assistance.groupIds.join(',');//build ids groups

            app.canSubmit(false);

            $http({
                method: 'POST',
                url: url,
                data: data_assistance,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {

                if (response.status == 200) {
                    refreshGroupAfterSubmit(response.data.response, data_assistance);
                }
                else {
                    window.location.reload();
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });

            $("#assistanceRequestGroupModal").modal('hide');




        }

        // Submit Assistance for ALL
        $scope.sendResponseDemandAssistanceSubmit = function ($event, isGroup) {
            $scope.isGroup = isGroup;

            var html = window.getSummerNoteCode(isGroup ? summernote_editor_group_id : summernote_editor_id);
            $scope.demand_ass.response_demand = angular.copy(html);
            html = html.replaceAll("&nbsp;", "");
            if (html.length < 5) {
                toastr.error(JSR.response_atleast_five_char, "", { toast: true });
                return;
            }

            if ($scope.isGroup) {
                $scope.demand_ass.update();
                var data_assistance = angular.copy($scope.demand_ass);
                data_assistance.groupIds = data_assistance.groupIds.join(',');//build ids groups

                if (data_assistance.isNew) {
                    var result = validateCalendar();
                    if (!result.ok) {
                        toastr.error(result.message, "", { timeOut: 20000 });
                        return false;
                    }
                }
            }

            submitResponse();
        }


        //***** FILE ATTACHEMENT & SEND DATA  *******
        //*******************************************

        //Cancel upload
        $scope.reloadPage = function () { location.reload(); }

        // reset all for file
        var resetContentFile = function () {
            $scope.content_file_info = app.initFileInfo();
            $scope.progressBar = 0;
            $('#filesUpload').val('');
        }

        //media or files
        $scope.fileNameChanged = function (upload) {
            $scope.content_file_info = app.initFileInfo();
            try {
                if (upload.files && upload.files.length > 0) {
                    var file = upload.files[0];
                    var ext = file.name.substring(file.name.lastIndexOf('.') + 1).toLowerCase();
                    var allowed_ext = $scope.content_type.allowed_ext;
                    var allowed = true;
                    if (!allowed_ext.includes(ext)) {
                        $('#filesUpload').val('');
                        toastr.error(JSR.msg_type_not_authorized.format(ext));
                        allowed = false;
                    };

                    if (file.size > settings.max_size_upload) {
                        $('#filesUpload').val('');
                        toastr.error(msg_max_file);
                        allowed = false;

                    }
                    if (!allowed) {
                        $scope.$apply();
                        return;
                    }

                    $scope.content_file_info.file = file;
                    $scope.content_file_info.ext = ext;
                    $scope.content_file_info.type = file.type;
                    $scope.content_file_info.size = app.formatBytes(file.size);
                }
                $scope.$apply();
            } catch (e) {
                console.log(e);
                toastr.error(JSR.error_occurred_loading);
            }
        }

        // step 1 : submit file if new or just data info
        var submitResponse = function () {
            var file = $scope.content_file_info.file;
            var url = "";

            if (file) {
                var path_content = app.buildContentPath($scope.school_id, $scope.instructor_id);
                var filename = encodeURIComponent(file.name),
                    path_content = encodeURIComponent(path_content)
                url = content_upload_file_url.format(path_content, filename) //new
                //send file then info content
                uploadFileContent(url, file);
            } else {
                //save infos only
                saveInfoContent(url);
            }

        };

        //step 2
        var uploadFileContent = function (url_upload, file) {
            app.canSubmit(false);
            $scope.progressInfo = "En cours d'envoie ...";
            var star_percent = 0.001;
            $scope.progressBar = star_percent;
            $http({
                method: 'POST',
                headers: { 'Content-Type': 'application/octet-stream' },
                timeout: settings.timeout_file_post,
                url: url_upload,
                data: file,
                uploadEventHandlers: {
                    start: function (e) { console.log("ok") },
                    progress: function (e) {
                        if (e.lengthComputable) {
                            var pb = Math.round((e.loaded / e.total) * 100);
                            var loaded = app.formatBytes(e.loaded)
                            if (pb < star_percent) return;
                            $scope.progressBar = pb;
                            if (pb <= 99)
                                $scope.progressInfo = "{0}% - {1}: ".format(pb, loaded) + ((pb < 95) ? JSR.sent : JSR.almost_finished);
                            if (pb == 100)
                                $scope.progressInfo = "{0}% - {1} ...".format(pb, JSR.backup);
                            //enable control
                            app.enableControl(true, "#btnCancelUpload");
                        }
                    }
                }
            }).then(function (response) {
                var data = response.data;
                if (response.status == 200) {
                    //step 2                               
                    $scope.progressInfo = "100% - {0} ...".format(JSR.final_phase);
                    //console.log(response);
                    saveInfoContent(data.file);
                }
                else {
                    toastr.error(response);
                }
                app.canSubmit(true);
            }, function (response) {
                $scope.progressBar = star_percent;
                $scope.progressInfo = JSR.error_connection;
                app.responseStatus(response);
            });
        }

        //step 3 or 1
        var saveInfoContent = function (attachment_url) {

            $scope.demand_ass.attachment_url = attachment_url;
            if (attachment_url) {
                $scope.demand_ass.attachment_type = $scope.getTypeFromExtensionURL(attachment_url);
            }

            if (!$scope.isGroup) {
                sendResponseStudentDemandAssistanceSubmit(attachment_url);
            }
            else {
                $scope.demand_ass.update();
                sendResponseGroupDemandAssistanceSubmit(attachment_url);
            }
        }


        // Delete AttachementFile
        $scope.deleteAttachmentFile = function ($event, obj, url_update_file_attachement_assistance) {
            var old_attachment_url = obj.attachment_url;
            app.canSubmit(false);

            $http({
                method: 'POST',
                url: content_delete_file_url,
                data: { "content_url": obj.attachment_url },
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {

                if (response.status == 200) {
                    updateAttachmentFile(obj, url_update_file_attachement_assistance, old_attachment_url)
                }
                else {
                    window.location.reload();
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        }

        // Update AttachementFile
        var updateAttachmentFile = function (obj, url_update_file_attachement_assistance, old_attachment_url) {

            $http({
                method: 'POST',
                url: url_update_file_attachement_assistance,
                data: { "demand_id": obj.id, "attachment_url": null },
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {

                if (response.status == 200) {
                    angular.forEach($scope.demands_list, function (val) {
                        var index = $scope.demands_list.findIndex(function (l) { return l.id == val.id });
                        if (index > -1 && val.attachment_url == old_attachment_url) {
                            $scope.demands_list[index].attachment_url = null;
                        }
                    });
                    toastr.success("", JSR.deleted);
                }
                else {
                    window.location.reload();
                }
                app.canSubmit(true);

            }, function (response) {
                console.log(response)
                app.responseStatus(response);
            });
        }

        // Display Media, Download or show text
        $scope.player = null;

        $scope.readUploadedContent = function ($event, attachment_url, type) {
            $scope.uploaded_content = { content_brief: JSR.attachment };
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
                    app, null
                ).then(function () {
                    console.log("Download ended...")
                });



            }
        }

        // update top header messaging notification //
        var updateNavigationHeader = function () {
            $scope.$emit("AssistanceDbServiceUnreadCount");

        }
    }]);