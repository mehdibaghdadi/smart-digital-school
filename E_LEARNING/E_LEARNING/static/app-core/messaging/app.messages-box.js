var getSelectedMenu = function (id) {
    return $(id).id;
}

//****************************** Message box controller
app.controller('MessagesBoxController',
    ['$scope', '$rootScope', 'NotificationHub', 'MessageService', '$window', '$filter', '$http', 'cfpLoadingBar', '$timeout', 'settings',
        function ($scope, $rootScope, NotificationHub, MessageService, $window, $filter, $http, cfpLoadingBar, $timeout, settings) {

            $rootScope.initCtrl = false;
            $scope.hubCn = null;

            var cache_id = "x_acui_cache";
            $scope.alertMsg = settings.empty_list;
            $scope.dataTableOptions = window.dataTableConfiguration();
            $scope.formMessageId = '#panel-form-message';
            $scope.tableMessageId = '#panel-table-messages';
            $scope.compose_textare_id = "#compose-textarea";

            $scope.user_id = 0;
            $scope.user_role = "";
            $scope.user_email = "";

            $scope.MessageBoxGetUrl = '';
            $scope.MessageBoxMarkReadUrl = '';
            $scope.MessageBoxDeleteUrl = '';
            $scope.MessageBoxDeleteToTrashUrl = '';
            $scope.MessageBoxSaveUpdateUrl = '';
            $scope.ContactListUrl = '';
            $scope.list_contacts_loaded = false;

            $rootScope.status = 0;
            $rootScope.status_contact = 1;
            $rootScope.stepSend = 0;
            var currentDate = new moment();
            $scope.listMails = [];
            $scope.emailInput = {};

            // Init All
            $scope.init = function (data, listUsers, user_id, user_email, user_role,
                message_get_url, message_get_inbox_user_messageid_url, message_mark_read_url, message_delete_url,
                message_delete_totrash_url, message_save_url, contact_list_url) {

                $scope.user_id = user_id;
                $scope.user_email = user_email;
                $scope.user_role = user_role;


                $rootScope.listeMessageBoxData = [];
                $scope.MessageBoxGetUrl = message_get_url;
                $scope.MessageBoxGetInBoxUrl = message_get_inbox_user_messageid_url;
                $scope.MessageBoxMarkReadUrl = message_mark_read_url;
                $scope.MessageBoxDeleteUrl = message_delete_url;
                $scope.MessageBoxDeleteToTrashUrl = message_delete_totrash_url;
                $scope.MessageBoxSaveUpdateUrl = message_save_url;
                $scope.ContactListUrl = contact_list_url;

                $rootScope.selected_list_group = 'lg-msg_all';

                $scope.emailInput = $("#data_emails").multiMailInput({});
                $scope.emailInput.deleteMailCallBack($scope.deleteMailCallBack);
                window.createFullSummerNote($scope.compose_textare_id);

                // create hub
                initHub(settings.notification_hub_url);

                var json = data;
                var list_msg = json['response'];

                var status = json['status'];
                if (status == '200') {

                    $rootScope.listeMessageBoxData = castListObjects(list_msg);
                    updateHtmlMessagesList();
                } else {
                    $scope.alertMsg = settings.empty_list;

                }


                //DOM
                setTimeout(function () {
                    // acivate first menu
                    $('#{0}'.format('lg-msg_all')).trigger("click");
                }, 200);
            }

            //Init HUB 
            var initHub = function (url) {
                $scope.hubCn = NotificationHub.create(url); // notification

                $scope.hubCn.then(cn => {
                    cn.on("ReceiveSentMessageBox", function (messageId, userId, email, fullname, role, destinations) {
                        $scope.onReceiveSentMessage(messageId, userId, email, fullname, role, destinations);
                    });
                    cn.on("ReceiveReadMessageBox", function (messageId, userId, email, userSenderId, userSenderEmail) {
                        $scope.onReceiveReadMessage(messageId, userId, email, userSenderId, userSenderEmail);
                    });
                    cn.on("ReceiveDeletedMessageBox", function (messageId, userId, email, userSenderId, userSenderEmail) {
                        $scope.onReceiveDeletedMessage(messageId, userId, email, userSenderId, userSenderEmail);
                    })
                }).catch(err => {
                    console.error("SignalR Connection Error: ", err);
                });
            }

            //************** HELPERS ***************/

            // is me
            var isMe = function (userId, email) {
                return (userId == $scope.user_id && email == $scope.user_email);

            }

            //Show collapse menu

            $scope.showMenu = function () {
                var val = $window.localStorage.getItem("_hideMenu") || '1';
                return val == '1' ? 1 : 0;
            };

            // date converter
            $scope.toLocaleFullDateString = function (date) {
                var d = new Date($filter('date')(date, 'yyyy-MM-dd HH:mm'));

                return new Date(d).toLocaleDateString(JSR.current_language,
                    {
                        weekday: "short", year: "numeric", month: "short", day: "numeric", hour: '2-digit',
                        minute: '2-digit'
                    }
                )
            }
            var toLocaleDateString = function (date, format = 0) {
                moment.locale(JSR.current_language);
                var dbDate = new moment(date);

                if (currentDate.isSame(dbDate, 'day'))
                    return format == 0 ? dbDate.format('HH:mm') : JSR.today;
                else if (currentDate.isSame(dbDate, 'year'))
                    return dbDate.format("DD MMM");
                else
                    return dbDate.format("DD-MM-YYYY");

            }

            //Cast obj msg //
            var castListObjects = function (list) {
                angular.forEach(list, function (e) {
                    try {
                        e = castObject(e);

                    } catch (e) {
                        console.log(e)
                    }
                });

                return list;
            }
            var castObject = function (e) {
                e.my_message = e.my_message;
                e.to_me = !e.my_message;

                e.isnew = e.id <= 0;
                e.date_update_card = toLocaleDateString(e.date_update);
                e.date_update_group = toLocaleDateString(e.date_update, 1);
                e.can_delete = (e.my_message && !e.is_read);
                e.can_response = (!e.isnew && !e.my_message) || (!e.isnew && e.to_trash);
                e.can_mark_read = (!e.isnew && !e.my_message && !e.is_read);
                e.is_read = e.is_read || 0;
                e.is_composing = false;
                e.updateSubject = false;
                e.details = "";
                return e;
            }
            $scope.deleteMailCallBack = function (listMails) {
                $scope.listMails = listMails;
                $scope.$applyAsync();
            }

            //update Html
            var updateHtmlMessagesList = function () {
                $rootScope.msg_all = $rootScope.listeMessageBoxData.filter(x => !x.to_trash).length;

                $rootScope.msg_not_read_me = $rootScope.listeMessageBoxData.filter(x => !x.is_read && !x.to_trash && !x.my_message).length;
                $rootScope.msg_not_read_user = $rootScope.listeMessageBoxData.filter(x => !x.is_read && !x.to_trash && x.my_message).length;

                $rootScope.msg_receipt = $rootScope.listeMessageBoxData.filter(x => !x.my_message && !x.to_trash).length;
                $rootScope.msg_sended = $rootScope.listeMessageBoxData.filter(x => x.my_message && !x.to_trash).length;

                $rootScope.msg_trash = $rootScope.listeMessageBoxData.filter(x => x.to_trash && x.my_message).length;

                $rootScope.listeMessageBox = $rootScope.listeMessageBoxData.filter(filterItemsMenu);
                updateHtmlHeader();

            }
            var updateHtmlHeader = function () {
                $rootScope.selected_list_group_text = $('#{0}'.format($rootScope.selected_list_group))[0].innerHTML.replace('ng-hide', '');

            }

            //filter items
            var filterItemsMenu = function (item) {
                var selected = true;
                switch ($rootScope.selected_list_group) {
                    case 'lg-msg_all': selected = !item.to_trash; break;
                    case 'lg-msg_receipt': selected = !item.my_message && !item.to_trash; break;
                    case 'lg-msg_sended': selected = item.my_message && !item.to_trash; break;
                    case 'lg-msg_trash': selected = item.my_message && item.to_trash; break;
                    case 'lg-msg_not_read_me': selected = !item.is_read && !item.my_message && !item.to_trash; break;
                    case 'lg-msg_not_read_user': selected = !item.is_read && item.my_message && !item.to_trash; break;
                    default: selected = !item.to_trash; break;
                }
                return selected;
            }
            $scope.selectListGroup = function (sender) {
                $scope.closeClick();
                $rootScope.selected_list_group = (sender.currentTarget.id);
                updateHtmlMessagesList();
            }


            // list users auto complete
            var cacheDataContacts = {};

            //format response
            var responseFormat = function (data) {
                var list = $.map(data, function (el, i) {
                    var role = '';
                    switch (el.role) {
                        case 'student': role = '<i class="fa fa-user-graduate text-info mr-1 "></i>'; break;
                        case 'instructor': role = '<i class="fa fa-ew-instructor text-danger mr-1 "></i>'; break;
                        case 'school': role = '<i class="fa fa-school text-success mr-1 "></i>'; break;
                        default:
                    }

                    var name = "<b class=' text-uppercase'>{0}{1} {2}</b>".format(role, el.first_name, el.last_name);
                    var infos_details = '';
                    if (el.classroom)
                        infos_details = '<small class="d-block text-uppercase ml-3"><b class="text-gray">{0}</b> : {1} ({2}, {3})</small></div>'.format(JSR.classs, el.classroom, el.qualification, el.level);

                    var label = '<div ><span class="text-uppercase">{0}</span><small class="d-block"><i class="mr-2 fa fa-at text-yellow"></i>{1}</small>{2}</div>'.format(name, el.email, infos_details)

                    var cc = {
                        value: el.email,
                        email: el.email,
                        full_name: name,
                        label: label,
                        selected: 0
                    }
                    return cc;
                });
                return list;
            };

            // data source
            var dataSourceContacts = function (request, response) {
                if (cache_id in cacheDataContacts) {
                    response($.ui.autocomplete.filter(cacheDataContacts[cache_id], request.term));
                    return;
                }
                $.ajax({
                    url: $scope.ContactListUrl,
                    type: "GET",
                    cache: true,
                    success: function (data) {
                        cacheDataContacts[cache_id] = responseFormat(data.response);
                        response($.ui.autocomplete.filter(cacheDataContacts[cache_id], request.term));
                    },
                    error: function (request, status, error) {
                        toastr.warning("{0}".format(JSR.empty_data), JSR.contacts, { toast: true });
                        console.log(request.responseText);
                        $rootScope.status_contact = 1;
                        $scope.$applyAsync();
                    }
                });
            }

            //init contacts
            var initAutocomplete = function (data) {
                $rootScope.status_contact = 1;
                $("#data_emails").autocomplete({
                    html: true,
                    source: dataSourceContacts,
                    minLength: 0,
                    select: function (event, ui) {
                        event.preventDefault();
                        $scope.emailInput.addMail(ui.item.email, ui.item.full_name);
                        $scope.listMails = $scope.emailInput.getMails();
                        $scope.$applyAsync();
                    },
                    search: function () {
                        $rootScope.status_contact = 0;
                        $scope.$applyAsync();
                    },
                    response: function () {
                        $rootScope.status_contact = 1;
                        $scope.$applyAsync();
                    }
                }).click(function () {
                    $(this).autocomplete("search", "");
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li class='ui-autocomplete-row'></li>")
                        .data("item.autocomplete", item)
                        .append(item.label)
                        .appendTo(ul);
                };
            }


            // display form message            
            var showFormComposingMessage = function (show) {
                $rootScope.showFormComposingMessage = show;
                var css_hide = "d-none";
                var css_show = "";
                setTimeout(() => {
                    closeAllToolTips();
                }, 0);

                $scope.$applyAsync();


                if (show) {
                    history.replaceState({ modalFormOpen: false, formMustClose: true }, "", location.pathname);
                    history.pushState({ modalFormOpen: true, formMustClose: true }, "", location.pathname);
                    notifyMaui('modalOpened');
                    
                    $($scope.formMessageId).removeClass(css_hide).addClass(css_show);
                    $($scope.tableMessageId).addClass(css_hide).removeClass(css_show);

                } else {
                    $($scope.formMessageId).addClass(css_hide).removeClass(css_show);
                    $($scope.tableMessageId).removeClass(css_hide).addClass(css_show);
                    history.replaceState({ modalFormOpen: false, formMustClose: false }, "", location.pathname);
                    updateHtmlHeader();

                }


            }


            // Si un modal est ouvert, on le ferme et on empêche le retour        
            window.addEventListener('popstate', function (event) {
                setTimeout(() => {

                    if (history.state && !history.state.modalFormOpen && history.state.formMustClose)
                        showFormComposingMessage(false);
                    else if (history.state && history.state.modalOpen == false) {
                        notifyMaui('modalOpened');
                        history.replaceState({ modalFormOpen: true, formMustClose: false }, "", location.pathname);
                    }

                }, 200);
            }, { once: false });

            // set info details

            $scope.setDetails = function (sender) {
                var data = angular.fromJson(sender.users_recipient_info);
                angular.forEach(data, function (val) {
                    $scope.emailInput.addMail(val.user_recipient_email, val.users_recipient_full_name);

                });
                $scope.listMails = $scope.emailInput.getMails();
                $scope.emailInput.disableRemove();
            }

            // select contact in list
            var selectContactsInList = function (data) {
                if ($scope.listMails.length <= 0) return data;
                try {
                    angular.forEach(data, function (val) {
                        val.selected = $scope.listMails.findIndex(x => x == val.email) >= 0 ? 1 : 0;
                    });
                } catch (e) {
                    console.log(e)
                }
                return data;
            };

            //*****************  FORM Action *********************/
            var gotoMessageBoxTop = function () {
                var navToolBar = "#main-div-messages";
                if (isMobile())
                    setTimeout(function () {
                        if ($(navToolBar).length) {
                            $(navToolBar)[0].scrollIntoView({
                                behavior: "smooth",
                                block: "start"
                            });
                        }
                    }, 500);
            }

            // menu click
            //close
            $scope.closeClick = function () {
                if (history.state && history.state.modalOpen == false)
                    history.replaceState({ modalFormOpen: true, formMustClose: false }, "", location.pathname);

                removeModalHistory();
                showFormComposingMessage(false);
            }

            $scope.showMenuClick = function () {
                $window.localStorage.setItem("_hideMenu", $scope.showMenu() == '0' ? 1 : 0);
            };

            //Show all contacts
            $scope.showListContactsClick = function () {
                $("#listContactsMbxModal").one('show.bs.modal', function (e) {

                    if (cache_id in cacheDataContacts) {
                        $scope.list_contacts_loaded = true;
                        $scope.contacts_mbx_list = selectContactsInList(cacheDataContacts[cache_id]);

                        $scope.$applyAsync();
                        return;
                    }

                    if (!$scope.list_contacts_loaded) {
                        $.ajax({
                            url: $scope.ContactListUrl,
                            type: "GET",
                            cache: true,
                            success: function (data) {
                                cacheDataContacts[cache_id] = responseFormat(data.response);
                                $scope.contacts_mbx_list = selectContactsInList(cacheDataContacts[cache_id]);
                                $scope.list_contacts_loaded = true;
                                $scope.$applyAsync();
                            },
                            error: function (request, status, error) {
                                console.log(request.responseText);
                                $scope.contacts_mbx_list = [];
                                $scope.list_contacts_loaded = false;
                                $scope.$applyAsync();
                                setTimeout(function () {
                                    $("#listContactsMbxModal").modal('hide');
                                    toastr.warning("{0}".format(JSR.empty_data), JSR.contacts, { toast: true });
                                }, 1000)
                            }
                        });
                    }

                }).modal('show');

            }

            //compose Message
            $scope.inserContactsClick = function () {
                angular.forEach($scope.contacts_mbx_list, function (val, key) {
                    if (val.selected)
                        $scope.emailInput.addMail(val.email, val.full_name);
                });
                $scope.listMails = $scope.emailInput.getMails();
                $("#listContactsMbxModal").modal('hide');
            }

            //select Message
            $scope.selectAllMailsClick = function (contacts_mbx_list_filtred, selected) {
                angular.forEach(contacts_mbx_list_filtred, function (val, key) {
                    val.selected = selected
                });
            }

            //Erase list mails
            $scope.eraseAllMailsClick = function () {
                $scope.emailInput.deleteAllMails();
                $scope.listMails = [];
            }

            //compose Message (New)
            $scope.composeClick = function () {
                $rootScope.stepSend = 0;
                $rootScope.status = 1;
                $rootScope.objEdition = {};
                var sender = {};
                sender.id = 0;
                sender.subject = "";
                sender.user_sender_full_name = 'Moi';
                sender.user_sender_id = $scope.user_id;
                sender.user_sender_role = $scope.user_role;
                sender.user_sender_email = $scope.user_email;

                $scope.emailInput.deleteAllMails();
                $scope.listMails = [];

                sender.my_message = true;
                sender.isnew = true;
                sender.date_update = new Date();
                sender.date_update_card = toLocaleDateString(sender.date_update);
                sender.date_update_group = toLocaleDateString(sender.date_update, 1);
                sender.updateSubject = true;
                sender.details = '';
                $rootScope.objEdition = angular.copy(sender);
                $rootScope.objEdition.is_composing = true;

                window.setSummerNoteCode($scope.compose_textare_id, "");
                gotoMessageBoxTop();
                showFormComposingMessage(true);
                window.enableSummerNote($scope.compose_textare_id, true);
                initAutocomplete($rootScope.listUsers);
                displayToolBar(true);

            }

            //Edit Message
            $scope.editionClick = function ($event, obj) {
                $event.stopPropagation();
                window.SmootScrollViewTopLayout();
                $scope.emailInput.deleteAllMails();
                $scope.listMails = [];
                $rootScope.objEdition = obj;
                window.setSummerNoteCode($scope.compose_textare_id, "");
                window.enableSummerNote($scope.compose_textare_id, false);
                gotoMessageBoxTop();
                showFormComposingMessage(true);
                $rootScope.stepSend = 0;
                $rootScope.status = 0;
                var url = "{0}/{1}/{2}".format($scope.MessageBoxGetUrl, obj.id, $scope.user_email)
                setTimeout(function () {
                    if ($("#data_emails").hasClass('ui-autocomplete-input')) {
                        $("#data_emails").autocomplete('option', 'source', '');
                    }
                }, 500 //ms
                );

                $http({
                    method: 'GET',
                    url: url,

                }).then(function (response) {
                    if (response.data.status == 200) {
                        $rootScope.status = 1;
                        $rootScope.status = response.data.status;
                        $rootScope.objEdition = castObject(response.data.response);
                        $scope.setDetails($rootScope.objEdition);
                        window.setSummerNoteCode($scope.compose_textare_id, '<div class="old-message">{0}</div>'.format($rootScope.objEdition.body));
                        displayToolBar(false);
                        // Mark as Read
                        if ($rootScope.objEdition.can_mark_read)
                            $scope.MarkMessageRead($rootScope.objEdition);
                    }

                }, function (response) {
                    app.responseStatus(response);
                });
            }

            //Response Message
            $scope.responseClick = function (obj) {
                // var to_trash = obj.to_trash;
                var sender = angular.copy(obj);
                var info_body = ("<br><br/>----<div contenteditable='false' class='bg-light'><hr class='m-1'/>" + JSR.message + " : <b>{0}({1})</b> - " + JSR.date + " : <b>{2}</b> <hr class='m-1'/></div>").format(obj.user_sender_full_name, obj.user_sender_email, $scope.toLocaleFullDateString(obj.date_update));
                var updateSubject = false;
                sender.date_update_card = toLocaleDateString(new Date());
                sender.date_update_group = toLocaleDateString(new Date(), 1);

                var user_recipt_email = null;
                if (!sender.to_trash && !sender.my_message) {
                    sender.id = 0;
                    updateSubject = false;
                    $scope.emailInput.addMail(sender.user_sender_email, sender.user_sender_full_name);
                    user_recipt_email = sender.user_sender_email;
                } else if (sender.my_message) {
                    sender.id = !sender.is_read || sender.to_trash ? sender.id : 0; // update current message
                    updateSubject = sender.id > 0;
                }

                $scope.emailInput.enableRemove();
                sender.subject = "{0}".format(sender.subject);

                // user sender
                sender.user_sender_full_name = 'Moi';
                sender.user_sender_id = $scope.user_id;
                sender.user_sender_role = $scope.user_role;
                $scope.emailInput.deleteMail($scope.user_email);
                sender.user_sender_email = $scope.user_email;
                //disable recipt
                if (user_recipt_email)
                    $scope.emailInput.enableMail(user_recipt_email, false);

                sender.to_trash = false;

                //convert
                sender = castObject(sender);

                //force params
                sender.is_composing = true;
                sender.updateSubject = updateSubject;
                sender.isnew = true;

                if (!updateSubject)
                    sender.subject = "TR: {0}".format(sender.subject);

                // set body, mails obj
                window.enableSummerNote($scope.compose_textare_id, true);
                var body = !updateSubject ? "{0} <div class='pl-2 border-left old-message' contenteditable='false'>{1}</div>".format(info_body, sender.body) : sender.body;

                window.setSummerNoteCode($scope.compose_textare_id, body);
                window.setSummerNoteFocus($scope.compose_textare_id, false);
                sender.body = ""
                $rootScope.objEdition = sender;
                $scope.listMails = $scope.emailInput.getMails();
                initAutocomplete();
                displayToolBar(true);

            }

            //init edition
            $scope.initEdition = function (compose_textare_id, is_admin) {
                $scope.is_admin = is_admin;

                $scope.compose_textare_id = compose_textare_id;
                window.createFullSummerNote(compose_textare_id);
            }


            var displayToolBar = function (display) {
                $('.note-editor .note-toolbar').toggleClass('d-none', display == false);
            }

            //*****************  DB *********************/

            // Send (Add or Update)

            $scope.SendMessageBox = function (obj) {

                if ($scope.listMails.length <= 0) {
                    toastr.error(JSR.please_choose_atleast_one_recipient, JSR.recipients);
                    return false;
                }

                $rootScope.objEdition.is_composing = false;

                var body = window.getSummerNoteCode($scope.compose_textare_id);
                var itemsToSend = angular.copy(obj);
                itemsToSend.body = body;
                if (window.isSummerNoteEmpty($scope.compose_textare_id)) {
                    toastr.error(JSR.please_complete_message, JSR.empty_message);
                    return false;
                }
                $rootScope.stepSend = 1;
                $rootScope.status = 0;

                //return;
                $http({
                    method: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    url: $scope.MessageBoxSaveUpdateUrl,
                    data: {
                        'sender': itemsToSend ,
                        'contacts': $scope.listMails
                    }

                }).then(function (response) {                   
                    var data = response.data;
                    if (data == null || data == undefined || data.status != "200") {                        
                        toastr.error(JSR.error, JSR.message + " : " + JSR.canceled)
                        return;
                    }

                    rslt = data.response;
                    itemsToSend = castObject(rslt);

                    var index = $rootScope.listeMessageBoxData.findIndex(x => x.id == itemsToSend.id);


                    if (index < 0) {
                        $rootScope.listeMessageBoxData.unshift(itemsToSend);
                    } else {
                        $rootScope.listeMessageBoxData[index] = itemsToSend;

                    }

                    $scope.$applyAsync();
                    // finally
                    updateHtmlMessagesList();

                    $rootScope.status = 1;
                    $rootScope.stepSend = 2;

                    toastr.success(JSR.message_sended, "", { timeOut: 5000 });
                    $scope.closeClick();
                    MessageService.SendMessage(
                        itemsToSend.id,
                        itemsToSend.user_sender_id,
                        itemsToSend.user_sender_email,
                        itemsToSend.user_sender_full_name,
                        itemsToSend.user_sender_role,
                        $scope.listMails
                    ).then(function (response) {
                        console.log('Message hub sent successfully');
                    }, function (error) {
                        console.error('Error hub sending message', error);
                    });
                }, function (response) {
                    $rootScope.stepSend = 0;
                    $rootScope.status = 1;
                    console.log(response);
                    app.responseStatus(response);
                });
            }

            //Delete to trash //
            $scope.Delete = function (msg_delete) {
                msg_delete.is_deleting = true;
                var url_delete = '';

                if (msg_delete.to_trash) {
                    url_delete = "{0}/{1}".format($scope.MessageBoxDeleteUrl, msg_delete.id);
                    toastr.error(JSR.message_deleted, "", { toast: true });
                }
                else {
                    msg_delete.to_trash = 1;
                    url_delete = "{0}/{1}".format($scope.MessageBoxDeleteToTrashUrl, msg_delete.id);
                    toastr.warning(JSR.message_to_trash, "", { toast: true });

                }

                $rootScope.stepSend = 1;
                $http({
                    method: 'POST',
                    url: url_delete

                }).then(function (response) {
                    var data = response.data;
                    $rootScope.status = data.status;
                    if (data == null || data == undefined || data.status != "200") {
                        toastr.error(JSR.error, JSR.error_delete)
                        return;
                    }
                    var msg_db = data.response;
                    if (!msg_db.to_trash)
                        $rootScope.listeMessageBoxData = $rootScope.listeMessageBoxData.filter(item => item.id !== msg_db.id);

                    updateHtmlMessagesList();

                    msg_delete.is_deleting = false;

                    MessageService.DeleteMessage(
                        msg_delete.id,
                        $scope.user_id,
                        $scope.user_email,
                        msg_delete.user_sender_id,
                        msg_delete.user_sender_email
                    ).then(function (response) {
                        console.log('Message hub delete successfully');
                    }, function (error) {
                        console.error('Error hub deleting message', error);
                    });

                }, function (response) {
                    app.responseStatus(response);
                });
            }

            // mark message Read //
            $scope.MarkMessageRead = function (msg_readed) {
                //console.log(msg_readed);
                if (msg_readed.message_box_recipient_id == 0) return true;

                var url_mark_read = "{0}/{1}".format($scope.MessageBoxMarkReadUrl, msg_readed.message_box_recipient_id);
                $http({
                    method: 'POST',
                    url: url_mark_read
                }).then(function (response) {
                    var data = response.data;
                    if (data.status == "200") {

                        var messagesBoxRecipient = data.response;
                        var index = $rootScope.listeMessageBoxData.findIndex(x => x.message_box_recipient_id == messagesBoxRecipient.id);
                        if (index >= 0) {
                            $rootScope.listeMessageBoxData[index].is_read = messagesBoxRecipient.is_read;

                            updateHtmlMessagesList();

                            MessageService.ReadMessage(
                                msg_readed.id,
                                $scope.user_id,
                                $scope.user_email,
                                msg_readed.user_sender_id,
                                msg_readed.user_sender_email
                            ).then(function (response) {
                                console.log('Message hub read successfully');
                            }, function (error) {
                                console.error('Error hub reading message', error);
                            });
                        }
                    }

                }, function (response) {
                    console.log(response);
                });
            }


            // get message if exist after notification //

            var GetMessageInbox = function (email, message_id) {

                var url_inbox = "{0}/{1}/{2}".format($scope.MessageBoxGetInBoxUrl, email, message_id);
                $http({
                    method: 'GET',
                    url: url_inbox
                }).then(function (response) {
                    var data = response.data;
                    if (data.status == "200") {

                        var msg_list = castListObjects(data.response);
                        var first_msg = msg_list[0];// always one message

                        var idx = $rootScope.listeMessageBoxData.findIndex(x => x.id == first_msg.id);

                        if (idx > -1)
                            $rootScope.listeMessageBoxData[idx] = first_msg;
                        else
                            $rootScope.listeMessageBoxData.unshift(first_msg);

                        $scope.$applyAsync();

                        //obj.is_read = true;
                        updateHtmlMessagesList();
                    }
                }, function (response) {
                    console.log(response);
                });
            }

            // update top header messaging notification //
            var updateNavigationHeader = function () {
                $scope.$emit("MessageBoxDbServiceUnreadCount");

            }
            /************* HUB SIGNALR  ***************/
            //On Sent 
            $scope.onReceiveSentMessage = function (messageId, userId, email, fullname, role, destinations) {
                try {

                    var dest = angular.fromJson(destinations);

                    if (isMe(userId, email)) return;// i'm the sender: do nothink

                    if (dest.findIndex(x => x == $scope.user_email) > -1) {
                        GetMessageInbox($scope.user_email, messageId);
                    }

                } catch (e) {
                    console.log(e);

                }

            };

            //On Read 
            $scope.onReceiveReadMessage = function (messageId, userId, email, userSenderId, userSenderEmail) {
                try {

                    if (isMe(userId, email)) {// i'm the reader of the mail
                        updateNavigationHeader();
                        return;
                    }
                    if (!isMe(userSenderId, userSenderEmail)) return;// i'm not who compose the mail: do nothink

                    var idx = $rootScope.listeMessageBoxData.findIndex(x => x.id == messageId);
                    if (idx >= 0) {
                        $rootScope.listeMessageBoxData[idx].is_read++;
                        $rootScope.listeMessageBoxData[idx] = castObject($rootScope.listeMessageBoxData[idx]);
                        $scope.$applyAsync();
                        updateHtmlMessagesList();


                    }
                } catch (e) {
                    console.log(e)
                }
            }


            //On Delete 
            $scope.onReceiveDeletedMessage = function (messageId, userId, email, userSenderId, userSenderEmail) {

                try {

                    if (isMe(userId, email)) return;// i delete the mail: do nothink

                    var idx = $rootScope.listeMessageBoxData.findIndex(x => x.id == messageId);
                    if (idx >= 0) {
                        //$rootScope.listeMessageBoxData = $rootScope.listeMessageBoxData.filter(item => item.id !== messageId);
                        $rootScope.listeMessageBoxData[idx].to_trash = true
                        $scope.$applyAsync();
                        updateHtmlMessagesList();
                        updateNavigationHeader();

                    }
                } catch (e) {
                    console.log(e)
                }
            }



        }]);