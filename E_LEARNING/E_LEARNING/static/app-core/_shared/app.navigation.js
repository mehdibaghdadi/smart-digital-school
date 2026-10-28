//****************************** Navigation controller

app.controller('NavigationMenuCtrl',
    ['$scope', '$rootScope', 'MessageService', 'AssistanceService', 'NotificationHub', 'InternalService', 'settings',
        function ($scope, $rootScope, MessageService, AssistanceService, NotificationHub, InternalService, settings) {
            $scope.user_id;
            $scope.user_email;
            $scope.nbr_msg = '0';
            $scope.nbr_assistance = '0';
            var firstConnect = true;
            $scope.init = function (user_id, user_email) {

                $scope.user_id = user_id;
                $scope.user_email = user_email;
                var url = settings.notification_hub_url;

                $scope.hubCn = NotificationHub.create(url); // notification

                $scope.hubCn.then(cn => {
                    cn.on("OnConnected", (connectionId) => {
                        $scope.$apply(() => {
                            if (firstConnect) {
                                MessageBoxUnreadCount($scope.user_email);
                                AssistanceUnreadCount($scope.user_id, JSR.current_role);
                            }
                            firstConnect = false;
                        });
                    });
                    cn.on("ReceiveSentMessageBox", function (messageId, userId, email, fullname, role, destinations) {
                        $scope.onReceiveSentMessage(messageId, userId, email, fullname, role, destinations);
                    });
                    cn.on("UserDataChange", function (email_target, email_sender) {
                        $scope.onUserDataChange(email_target, email_sender);
                    });

                }).catch(err => {
                    console.error("SignalR Connection Error: ", err);
                    MessageBoxUnreadCount(user_email);
                });

            }

            var isMe = function (email_sender) {
                return (email_sender == JSR.current_user_email);

            }

            //************ notification users */
            $scope.onUserDataChange = function (email_target, email_sender) {
                try {

                    if (isMe(email_sender)) return;// i'm the sender: do nothink

                    InternalService.ResetUserData(email_target, email_sender)
                        .then(function (response) {
                            console.log(response.data.response)
                        }, function (error) {
                            console.error('Error onUserDataChange', error);
                        });
                } catch (e) {
                    console.log(e);

                }
            };

            //************ Assistance instructor ********/

            var AssistanceUnreadCount = function (userId,role) {

                if (role != settings.roles.school) {
                    AssistanceService.UnreadCount(userId,role)
                        .then(function (response) {
                            $scope.nbr_assistance = response.data;
                            $scope.$applyAsync();
                        }, function (error) {
                            console.error('Error AssistanceDbService', error);
                        });
                }
            }

            $rootScope.$on("AssistanceDbServiceUnreadCount", function () {
                AssistanceUnreadCount($scope.user_id);
            });

            //************ notification messagebox users */
            var MessageBoxUnreadCount = function (user_email) {

                MessageService.UnreadCount(user_email)
                    .then(function (response) {
                        $scope.nbr_msg = response.data;
                        $scope.$applyAsync();
                    }, function (error) {
                        console.error('Error MessageBoxDbService', error);
                    });
            }

            // when i read my message or when sender delete his message : used by 'app.messages-box.js'
            $rootScope.$on("MessageBoxDbServiceUnreadCount", function () {
                MessageBoxUnreadCount($scope.user_email);
            });

            $scope.onReceiveSentMessage = function (messageId, userId, email, fullname, role, destinations) {
                try {
                    var emails_destination = angular.fromJson(destinations);

                    if (isMe(email)) return;// i'm the sender: do nothink

                    if (emails_destination.findIndex(x => x == JSR.current_user_email) > -1) {
                        MessageBoxUnreadCount(JSR.current_user_email);
                        $scope.$applyAsync();

                    }
                } catch (e) {
                    console.log(e);

                }

            };


        }]);