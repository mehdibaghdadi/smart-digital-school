
app.controller('DemandAssistanceListCtrl', ['$scope','downloadFactory', '$window', '$filter', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, downloadFactory, $window, $filter,$http, cfpLoadingBar, $timeout, settings) {
        $scope.dateToday = new Date();
        $scope.demands_list = [];
        $scope.progressBar = 0;
        $scope.progressInfo = "";
        var content_download_media_url = settings.content_download_media_url;
        var content_download_file_url = settings.content_download_file_url;

        //helpers
        function isSameDay(d1, d2) {

            return d1.getFullYear() === d2.getFullYear() &&
                d1.getMonth() === d2.getMonth() &&
                d1.getDate() === d2.getDate();
        }
        var buildPlannedTitle = function (l) {
            var end = angular.copy(l.pl_end);
            end.setMinutes(end.getMinutes() - 1);
            var sameDay = isSameDay(l.pl_start, end);
            var allDay = l.pl_allday;
            var strD = $filter('date')(l.pl_start, 'dd-MM-yyyy');
            var strH = $filter('date')(l.pl_start, 'HH:mm');
            var endD = $filter('date')(l.pl_end, 'dd-MM-yyyy');
            var endH = $filter('date')(l.pl_end, 'HH:mm');
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
                l.pl_enableEvent = true;
                if (l.pl_start) {
                    l.pl_start = new Date(Date.parse(l.pl_start));
                    l.pl_end = new Date(Date.parse(l.pl_end));
                    l.pl_enableEvent = (l.pl_end.getTime() >= $scope.dateToday.getTime());
                    l.pl_plannedTitle = buildPlannedTitle(l);
                }
            });

            //list ids can be modified
           // $scope.list_enanbled = list_demand.filter(x => !x.enableEvent).map(a => a.id.toString());

            return list_demand;
        }
              


        //init
        $scope.init = function (demands_list) {            
            if (demands_list.status == 200)
                $scope.demands_list = parselistDemand(demands_list.response);

            console.log($scope.demands_list);
        }
               

        //need Assistance
        $scope.needAssistanceClick = function ($event, obj) {
            $scope.demand_ass = angular.copy(obj);
            $scope.demand_ass.accepted = ($scope.demand_ass.accepted == undefined || $scope.demand_ass.accepted == null)
                ? 1 : $scope.demand_ass.accepted;

            $scope.demand_ass.instructor_calendar_id = $scope.demand_ass.instructor_calendar_id | 0;
            $scope.demand_ass.demandAssistanceText = (obj.response_demand) ? obj.response_demand : ""
            $scope.demand_ass.demandAssistanceLink = (obj.response_demand_link) ? obj.response_demand_link : ""


            $("#assistanceRequestModal").modal('show');
        }

        // refresh after submit
        var refreshAfterSubmit = function (data_assistance) {
            var index = $scope.demands_list.findIndex(function (l) { return l.id === data_assistance.demand_id });
            if (index > -1) {
                $scope.demands_list[index].accepted = data_assistance.accepted;
                $scope.demands_list[index].response_demand = data_assistance.response_demand;
                $scope.demands_list[index].response_demand_link = data_assistance.response_demand_link;
                $scope.demands_list[index].instructor_calendar_id = data_assistance.instructor_calendar_id | 0;
            }
            toastr.success(JSR.message_sended2, "", { timeOut: 15000 });
        }

        //need Assistance 
        $scope.sendResponseDemandAssistanceSubmit = function ($event) {
            var url = $scope.instructor_assistance_url;
            var o = $scope.demand_ass;

            var data_assistance = {
                "demand_id": o.id, "response_demand": o.demandAssistanceText,"response_demand_link": o.demandAssistanceLink,
                "accepted": o.accepted, "instructor_calendar_id": o.instructor_calendar_id
            };

            if (data_assistance.response_demand.length < 5) {
                toastr.error(JSR.response_atleast_five_char, "", { toast: true });
                return;
            }
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: data_assistance,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    refreshAfterSubmit(data_assistance);
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
        $scope.readUploadedContent = function ($event, attachment_url, type, obj) {
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
                    app,null
                ).then(function () {
                    console.log("Download ended...")
                });

              


            }
        }
    }]);