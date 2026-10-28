// FACTORY
app.factory('downloadFactory', ['$http', '$q', function ($http, $q) {
    return {
        startDownload: function (content_url, content_download_file_url, data, JSR, app, rename_file = null) {
            return Swal.fire({
                title: `<div class="text-sm text-uppercase text-danger">
                            <i class="mr-2 text-info fa fa-download"></i>${JSR.download}
                        </div>`,
                html: '<hr/><div class="text-sm" id="content-download-info"></div>',
                showCancelButton: true,
                cancelButtonText: JSR.cancel,
                allowOutsideClick: false,
                allowEscapeKey: false,
                didOpen: () => {
                    Swal.showLoading();

                    $http({
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8'
                        },
                        url: content_download_file_url,
                        data: data,
                        responseType: 'blob',
                        eventHandlers: {
                            progress: function (e) {
                                if (e.lengthComputable) {
                                    var pb = Math.round((e.loaded / e.total) * 100);
                                    var loaded = app.formatBytes(e.loaded);
                                    var total = app.formatBytes(e.total);
                                    var msg = `${JSR.file_size}: <b>${total}</b> 
                                               <br/><br/>Loading ... <b class='text-info'>${pb}%</b>`;
                                    $("#content-download-info").html(msg);
                                }
                            },
                        },
                    }).then(function (response) {
                        Swal.close();

                        // Création du blob
                        var blob = new Blob([response.data], {
                            type: response.headers('Content-Type') || 'application/octet-stream'
                        });

                        // 🔹 Détermine le nom du fichier
                        var fileName = rename_file || content_url.split('/').pop() || 'smart_ds.bin';

                        if (blob) {
                            var fileURL = URL.createObjectURL(blob);

                            if (window.BlobReceiver && window.BlobReceiver.postBlob) {
                                // if Android WebView expose native interface 
                                window.downloadBlob(fileURL, fileName);
                            } else {
                                // classic navigator download
                                var link = document.createElement('a');
                                link.href = fileURL;
                                link.download = fileName;
                                link.click();
                                URL.revokeObjectURL(fileURL);
                                
                                toastr.success(
                                    "",
                                    `${JSR.download}: ${JSR.finished} <i class='ml-2 text-info fa fa-download'></i>`,
                                    { timeOut: 8000, toast: true, position: 'bottom-start' }
                                );
                            }
                        }

                    }, function (response) {
                        Swal.close();
                        console.error(response);
                        app.responseStatus(response);
                    });
                }
            }).then((result) => {
                if (result.dismiss === Swal.DismissReason.cancel) {
                    window.location.reload();
                }
            });
        }
    };
}]);


app.factory('NotificationHub', ['$window', function ($window) {
    function createHub(url) {
        return $window.signalRService.init(url);
    }
    return {
        create: createHub
    };
}]);


// INTERNAL SERVICE API

app.service('InternalService', ['$http', 'settings', function ($http, settings) {
    this.ResetUserData = function (email_target, email_sender) {
        const data = {
            email_target: email_target,
            email_sender: email_sender
        };
        return $http.post(settings.reset_user_data_url, data);
    };

}]);

//****************************** Notification Services

app.service('NotificationService', ['$http', 'settings', function ($http, settings) {
    this.UserDataChange = function (email_target, email_sender) {
        return $http.post(settings.notification_user_data_change_url.format(email_target, email_sender));
    };

}]);

//****************************** Assistance Services
app.service('AssistanceService', ['$http', 'settings', function ($http, settings) {
    this.UnreadCount = function (userId,role) {
        return $http.get(settings.assistance_unread_count_url + `/${userId}/${role}`);
    };

}]);

//****************************** Message Services

app.service('MessageService', ['$http', 'settings', function ($http, settings) {
    this.SendMessage = function (messageId, userId, email, fullname, role, destinations) {

        return $http.post(settings.messagebox_sendmsg_url, {
            'MessageId': messageId,
            'UserId': userId,
            'Email': email,
            'Fullname': fullname,
            'Role': role,
            'Destinations': angular.toJson(destinations)
        });
    };
    this.ReadMessage = function (messageId, userId, email, userSenderId, userSenderEmail) {

        return $http.post(settings.messagebox_readmsg_url, {
            'MessageId': messageId,
            'UserId': userId,
            'Email': email,
            'UserSenderId': userSenderId,
            'UserSenderEmail': userSenderEmail
        });
    };
    this.DeleteMessage = function (messageId, userId, email, userSenderId, userSenderEmail) {

        return $http.post(settings.messagebox_deletemsg_url, {
            'MessageId': messageId,
            'UserId': userId,
            'Email': email,
            'UserSenderId': userSenderId,
            'UserSenderEmail': userSenderEmail
        });
    };
    this.UnreadCount = function (email) {
        return $http.get(settings.messagebox_unreadmsg_count_url + `/${email}`);
    };

}]);
