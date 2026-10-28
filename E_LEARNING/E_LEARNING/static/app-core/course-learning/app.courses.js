app.controller('CourseCtrl', ['$scope', 'downloadFactory', '$window', '$filter', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, downloadFactory, $window, $filter, $http, cfpLoadingBar, $timeout, settings) {

        var content_download_media_url = settings.content_download_media_url;
        var content_download_file_url = settings.content_download_file_url;
        var content_get_image_url = settings.content_get_image_url;

        //ids
        $scope.course_id = 0;
        $scope.enroll_id = 0;
        $scope.isFavorite = 0;
        $scope.isStudent = 0;
        $scope.getDataStudent = 0;
        //urls
        $scope.instructor_assistance_url = '';
        $scope.delete_instructor_assistance_url = '';
        $scope.learning_progress_begin_url = '';
        $scope.learning_progress_end_url = '';


        // for list content : css and text
        $scope.content_type_dict = settings.content_type_dict();
        $scope.subjectColor = app.subjectColor.latest;

        $scope.assistance_course = [];
        $scope.assistance_course_filtred = {};
        $scope.contents = {};
        $scope.dmd = {};
        $scope.learning_progress_course = [];
        $scope.percent_progress_course = 0;
        $scope.learning_progress_chapters = {};
        $scope.quizzes = [];
        $scope.percent_progress_quiz = 0;

        $scope.ratingScore = 3;
        $scope.commentText = "";
        $scope.player = null;
        var player_id = "#player";

        //****** init course
        $scope.init = function (isStudent, getDataStudent, isFavorite, course_id, enroll_id, feedback, assistance_course, instructor_assistance_url,
            delete_instructor_assistance_url, learning_progress_begin_url, learning_progress_end_url,
            learning_progress_course, list_quizzes_url) {

            $scope.isStudent = isStudent;
            $scope.getDataStudent = getDataStudent;

            $scope.learning_progress_begin_url = learning_progress_begin_url;
            $scope.learning_progress_end_url = learning_progress_end_url;

            $scope.instructor_assistance_url = instructor_assistance_url;
            $scope.delete_instructor_assistance_url = delete_instructor_assistance_url;
            $scope.assistance_course = assistance_course.status == 200 ? assistance_course.response : [];
            if (getDataStudent) {
                $scope.learning_progress_course = learning_progress_course.status == 200 ? learning_progress_course.response : [];

                $scope.learning_progress_chapters = getChaptersProgression($scope.learning_progress_course);
                $scope.percent_progress_course = getCourseProgression($scope.learning_progress_course);

                if (feedback.status == 200) {
                    $scope.commentText = feedback.response["feedback_text"];
                    $scope.ratingScore = feedback.response["rating_score"];
                }
                $('.package-tag').addClass('d-none');
            }
            $scope.course_id = course_id;
            $scope.enroll_id = enroll_id;
            $scope.isFavorite = isFavorite;
            $('.starrr').starrr({
                max: 5,
                rating: $scope.ratingScore,
                change: function (e, value) { $scope.changeScore(e, value) }
            })

            $scope.initQuizzesData(list_quizzes_url);

            if (!$scope.isStudent) {
                var hash = $(location).attr('hash');
                if (hash && hash.length > 1) {
                    $timeout(function () {
                        var target = $(hash);
                        if (target.length) {
                            console.log('scroll to', $(hash));
                            $(hash).trigger('click');
                        }
                    }, 500);

                }
            }
        }

        //***** init content assistance
        $scope.initContentData = function (contentId) {
            if (!$scope.contents[contentId]) {
                $scope.contents[contentId] = {};
            }
            $scope.contents[contentId].minmize_content_brief = true;

        }

        //***** init assistance
        $scope.initAssistanceData = function (contentId) {

            $scope.filterAssistanceData(contentId);
            // Initialiser dmd[contentId] si besoin
            if (!$scope.dmd[contentId]) {
                $scope.dmd[contentId] = {};
            }
            $scope.dmd[contentId].hide = true;
            $scope.dmd[contentId].nbrAssist = 0;
        };

        $scope.filterAssistanceData = function (contentId) {
            // 1. Trier la liste par date_demand
            var ordered = $filter('orderBy')($scope.assistance_course, 'date_demand');

            // 2. Filtrer par course_chapter_content_id == contentId
            var filtered = $filter('filter')(ordered, { course_chapter_content_id: contentId });

            // 3. Assigner le résultat dans assistance_course_filtred[contentId]
            $scope.assistance_course_filtred[contentId] = filtered;
        }

        //***** init quizzes
        $scope.initQuizzesData = function (url) {

            $http({
                method: 'GET',
                url: url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {

                    $scope.quizzes = response.data.response;
                    $scope.quizzes = $filter('orderBy')($scope.quizzes, 'quiz_id');
                    $scope.percent_progress_quiz = quizCompletion($scope.quizzes);
                    console.log('quizzes', $scope.quizzes);
                    $scope.$applyAsync();

                }


            }, function (response) {
                console.log(response);
            });

        }

        $scope.startQuiz = function (quiz, url, student_id) {
            var link = "{0}/{1}".format(url, quiz.id)
            if ($scope.getDataStudent && !$scope.isStudent)
                link = "{0}/{1}/{2}".format(url, quiz.id, student_id);
            window.location.href = link;

        };

        var quizCompletion = function (quizzes) {
            const total = quizzes.length;
            const done = quizzes.filter(q => q.done == true).length;
            return Math.round((done / total) * 100);
        };


        //***** init helpers
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
        $scope.fullscreen = function () {
            if ($scope.player)
                $scope.player.core.mediaControl.toggleFullscreen();
        }

        //call api image
        var getRemoteImage = function (image_url) {
            if (image_url == null || image_url == undefined || image_url?.length <= 0)
                return null;
            return `${content_get_image_url}${image_url}`;
        }

        //toggle chapter
        $scope.toggleChapter = function (id, chapter) {
            var minmize = !chapter.hide;
            chapter.hide = minmize;
            if (minmize)
                setTimeout(function () {
                    window.SmootScrollView(id);
                }, 300);
        }

        $scope.toggleText = function (id) {
            var minmize = !$scope.contents[id].minmize_content_brief;
            $scope.contents[id].minmize_content_brief = minmize;
            if (minmize)
                setTimeout(function () {
                    window.SmootScrollView("timelineBody" + id);
                }, 300);
        };

        //*********************** learning progress ***************/
        // Calcul de la progression par chapitre
        function getChaptersProgression(dataChapters) {
            if (!dataChapters || dataChapters.length === 0) return {};

            const weights = { N: 0, B: 0.5, C: 1 };
            const progression = {};

            // Accumulateur par chapitre
            const chapters = {};

            dataChapters.forEach(({ course_chapter_id, status }) => {
                if (!chapters[course_chapter_id]) {
                    chapters[course_chapter_id] = { total: 0, done: 0 };
                }
                chapters[course_chapter_id].total++;
                chapters[course_chapter_id].done += weights[status] || 0;
            });

            // Calcul final en %
            Object.keys(chapters).forEach(chapterId => {
                const { total, done } = chapters[chapterId];
                progression[chapterId] = ((done / total) * 100).toFixed(0);
            });

            return progression;
        }


        //calculate course progress by chapters
        var getCourseProgression = function (data) {
            console.log('getCourseProgression', data);
            const weights = { N: 0, B: 50, C: 100 };

            if (!data || data.length === 0) return 0;

            let total = 0;
            data.forEach(item => {
                total += weights[item.status] || 0;
            });

            var coursePercentage = (total / data.length).toFixed(0); // pourcentage moyen

            return coursePercentage; // Return as an integer
        }

        // update data after submit
        var updateLearningProgress = function (item) {


            if (item.status) {
                // Trouver l'élément dans $scope.learning_progress_course par course_chapter_content_id
                var content = $scope.learning_progress_course.find(function (content) {
                    return content.course_chapter_content_id === item.course_chapter_content_id;
                });

                if (content && item.status) {
                    // Si l'élément existe, mettre à jour son statut et ses autres propriétés si nécessaire
                    content.status = item.status;
                    content.begin_timestamp = item.begin_timestamp || new Date();
                    content.completion_timestamp = item.completion_timestamp || new Date();
                } else {
                    // Si l'élément n'existe pas, l'ajouter au tableau
                    $scope.learning_progress_course.push(item);
                }

                $scope.learning_progress_chapters = getChaptersProgression($scope.learning_progress_course);
                $scope.percent_progress_course = getCourseProgression($scope.learning_progress_course);
                $scope.$applyAsync();
            }
        };

        // set db learning progress
        var setLeaningProgressDb = function (url, course_chapter_content_id, date) {

            var date_db = $filter('date')(date, "yyyy-MM-dd hh:mm");
            var data_lp = {
                "course_chapter_content_id": course_chapter_content_id,
                "date_start": date_db,
                "date_end": date_db,
            };

            $http({
                method: 'POST',
                url: url,
                data: data_lp,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    updateLearningProgress(response.data.response);
                }

            }, function (response) {
                console.log(response)
            });

        }

        // start learning progress
        $scope.setLearningProgressBegin = function (course_chapter_content_id) {
            setLeaningProgressDb($scope.learning_progress_begin_url, course_chapter_content_id, new Date());
        }

        // end learning progress
        $scope.setLearningProgressEnd = function (course_chapter_content_id) {
            setLeaningProgressDb($scope.learning_progress_end_url, course_chapter_content_id, new Date());
        }

        $scope.matchContentId = function (content_id) {
            return function (item) {
                return item.course_chapter_content_id == content_id;
            };
        };


        // read content by type
        $scope.readUploadedContent = function ($event, obj) {
            window.closeAllToolTips();
            $scope.uploaded_content = angular.copy(obj);

            // Détecter le type de contenu
            // video / audio
            var medias = [settings.content_type.video[0], settings.content_type.audio[0]];
            var isMedia = medias.includes(obj.content_type_id);
            var url_media = content_download_media_url.format(encodeURIComponent(obj.content_url));

            // text editor
            var writing = [settings.content_type.text[0]];
            var isWriting = writing.includes(obj.content_type_id);

            // social media
            var social = [settings.content_type.youtube[0]];
            var isSocial = social.includes(obj.content_type_id);

            $scope.content_type_uploaded = $scope.content_type_dict[obj.content_type_id];
            $scope.$applyAsync();
            console.log('readUploadedContent', $scope.uploaded_content);
            if (isMedia) { // video / audio
                var cover_video_url = getRemoteImage(obj.content_cover_url);

                if ($scope.player) {
                    $scope.player.destroy();
                }
                $scope.player = mediaPlayerContent("#player");
                $("#mediaModal").one('show.bs.modal', function (e) {
                    $scope.player.configure({
                        source: url_media,
                        poster: cover_video_url
                    });
                }).on('hidden.bs.modal', function (e) {
                    if ($scope.player) {
                        $scope.player.stop();
                        $scope.player.destroy();
                    }
                }).modal('show');
            } else
                if (isWriting) { // text editor
                    $("#writingModal").on('hidden.bs.modal', function (e) {

                    }).modal('show');
                }
                else if (isSocial) { // social media                    
                    $("#socialMediaModal").one('show.bs.modal', function (e) {

                    }).on('hidden.bs.modal', function (e) {

                        $scope.$applyAsync(function () {
                            $scope.uploaded_content.content_url = "";
                        });
                    }).modal('show');
                }
                else { // download file
                    var originalName = obj.content_url.split('/').pop();
                    var rename_file = app.generateFileName(obj.content_brief, `${obj.course_id}`, `${obj.chapter_id}`, originalName);


                    downloadFactory.startDownload(
                        obj.content_url,
                        content_download_file_url,
                        { "content_url": obj.content_url },
                        JSR,
                        app,
                        rename_file
                    ).then(function () {
                        //  Mise à jour progression apprentissage
                        if ($scope.isStudent) {
                            setTimeout(() => {
                                $scope.setLearningProgressEnd(obj.content_id);
                            }, 2000);
                        }
                    });

                }
        }

        // attachement file
        $scope.readAttachmentFile = function ($event, attachment_url, type, obj) {
            var objFile = angular.copy(obj);
            objFile.content_type_id = type.id;
            objFile.content_url = attachment_url;
            objFile.content_brief = JSR.attachment + " : " + obj.content_brief;

            $scope.readUploadedContent($event, objFile);
        }

        // Start chapter content
        $scope.contentBeginClik = function ($event, obj) {
            console.clear();
            console.log('contentBeginClik');
            window.closeAllToolTips();

            $scope.readUploadedContent($event, obj);
            if ($scope.isStudent)
                setTimeout($scope.setLearningProgressBegin(obj.content_id), 1000);
        }

        // End chapter content
        $scope.contentEndClik = function ($event, obj) {
            console.clear();
            console.log('contentEndClik');

            if ($scope.isStudent)
                setTimeout($scope.setLearningProgressEnd(obj.content_id), 1000);
        }

        $scope.needProgressionInfoClick = function ($event, id) {
            $(id).trigger('click', ['trigger']);
        }
        $scope.showProgressionInfos = function ($event, p) {
            var msg = '';
            var formatdate = 'dd-MM-yyyy , HH:mm ';
            switch (p.status) {
                case 'C': msg = "<b class='text-green'>{0}</b> !<hr/><span class='row m-0 p-0'>   <small class='col-md'>{1} <br/> <b class=''>{2}</b></small>    <small class='col-xs'>&nbsp;</small>    <small class='col-md'>{3} <br/> <b class=''>{4}</b></small>  </span>".format(JSR.finished, JSR.date_start, $filter('date')(p.begin_timestamp, formatdate), JSR.date_end, $filter('date')(p.completion_timestamp, formatdate)); break;
                case 'B': msg = "<b  class='text-red'>{0}</b><hr/><small>{1} : <b class='text-md'>{2}</b></small>".format(JSR.inprogress, JSR.date_start, $filter('date')(p.begin_timestamp, formatdate)); break;
                default: msg = " <b class='text-info'>{0}</b> !!".format(JSR.not_yet);
            }
            if (p.status === 'C')
                toastr.success(msg, JSR.progression, { timeOut: 30000 });
            else if (p.status === 'B')
                toastr.warning(msg, JSR.progression, { timeOut: 20000 });
            else
                toastr.info(msg, JSR.progression, { timeOut: 20000 });

        }

        // *************************** favorite ****************
        // add to favorite
        $scope.addToFavoriteClick = function (url) {
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    toastr.success(JSR.course_fav_added, "", { timeOut: 10000 });
                    $scope.isFavorite = true;
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
        $scope.deleteFromFavoriteClick = function (url) {
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    toastr.success(JSR.course_fav_deleted, "", { timeOut: 10000 });
                    $scope.isFavorite = false;
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        }

        //***************************** Assistance *****************
        //need Assistance 
        $scope.needAssistanceClick = function ($event, obj) {
            var exist = $scope.assistance_course.find(x => x.course_chapter_content_id == obj.content_id && x.accepted == (undefined || null))
            if (exist) {
                toastr.warning("<small>{0}</small>".format(JSR.alert_demand_inprogress), "", { timeOut: 30000 });
                return;
            }

            $scope.uploaded_content = obj;
            $scope.content_type_uploaded = $scope.content_type_dict[obj.content_type_id];
            $scope.uploaded_content.demandAssistanceId = 0;
            $scope.uploaded_content.demandAssistanceText = "";

            $("#assistanceRequestModal").modal('show');
        }

        //update Assistance 
        $scope.updateAssistanceClick = function ($event, obj, assistance) {
            $scope.uploaded_content = obj;
            $scope.content_type_uploaded = $scope.content_type_dict[obj.content_type_id];
            $scope.uploaded_content.demandAssistanceId = assistance.id;
            $scope.uploaded_content.demandAssistanceText = assistance.description_demand;

            $("#assistanceRequestModal").modal('show');
        }

        //submit Assistance
        $scope.sendAssistanceSubmit = function ($event) {
            var url = $scope.instructor_assistance_url;
            var o = angular.copy($scope.uploaded_content);
            var data_assistance = { "demand_id": o.demandAssistanceId, "course_id": o.course_id, "chapter_id": o.chapter_id, "content_id": o.content_id, "description_demand": o.demandAssistanceText }

            if (data_assistance.description_demand.length < 5) {
                toastr.error(JSR.demande_atleast_five_char, "", { toast: true });
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
                    $scope.assistance_course = response.data.response;
                    $scope.filterAssistanceData(data_assistance.content_id);
                    toastr.success(JSR.alert_demand_sent, "", { timeOut: 15000 });
                    updateNavigationHeader();

                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });

            $("#assistanceRequestModal").modal('hide');
        }

        //delete Assistance click
        $scope.deleteAssistanceClick = function ($event, obj, assistance) {

            $event.preventDefault();
            var url = $scope.delete_instructor_assistance_url;
            var data_assistance = { "demand_id": assistance.id };

            var titre = obj.content_brief;
            var msg_delete = '<div class="alert alert-danger p-2" role="alert">{0}</div>'.format(JSR.msg_delete_confirm);
            toastr.confirm(msg_delete,
                function () {
                    app.canSubmit(false);
                    $http({
                        method: 'POST',
                        url: url,
                        data: data_assistance,
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        if (response.status == 200) {
                            $scope.assistance_course = response.data.response;
                            $scope.filterAssistanceData(obj.content_id);
                        }
                        else {
                            toastr.error(response.data.response);
                        }
                        app.canSubmit(true);
                        $scope.$applyAsync();

                    }, function (response) {
                        app.responseStatus(response);
                    });
                }, null);
        }


        // update top header messaging notification //
        var updateNavigationHeader = function () {
            $scope.$emit("AssistanceDbServiceUnreadCount");

        }

        //*************************** feedback ***************
        $scope.feedBackClik = function (url) {
            var evaluation = ($scope.commentText && $scope.commentText.length > 1);

            if (!evaluation) {
                toastr.warning(JSR.litte_comment_plz, "", { timeOut: 10000 });
                return;
            }


            var data_feedback = { "enrollment_id": $scope.enroll_id, "rating_score": $scope.ratingScore, "feedback_text": $scope.commentText };
            // return; 
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: data_feedback,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                if (response.status == 200) {
                    toastr.success(JSR.your_review_hasbeen_sent, "", { timeOut: 10000 });
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        }

        $scope.changeScore = function (e, value) {
            //$("#score").html(value);
            $scope.ratingScore = value;
            $scope.$apply();
        }

        $scope.showNotAllowedMessage = function () {
            toastr.warning(JSR.demand_assist, JSR.student);
        };
    }]);
