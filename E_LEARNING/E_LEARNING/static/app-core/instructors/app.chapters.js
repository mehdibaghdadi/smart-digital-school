app.initFileInfo = function () {
    return { file: null, size: 0, type: "", ext: "", file_size_in_bytes: 0 };
}
app.initContent = function () {
    return {
        id: 0, course_chapter_id: 0, content_type_id: 0, is_important: 0, time_required_in_sec: 0, time_required_in_min: 0,
        is_open_for_free: 1, is_visible: 1, content_url: "", content_cover_url: "", content_text: "", content_brief: "",
        sequence: 0, new_blob_file: true, update_cover: false
    };
}

app.buildContentPath = function (school_id, instructor_id, course_id, chapter_id) {
    return `${school_id}/${instructor_id}/${course_id}/${chapter_id}`;
}

app.controller('ChapterEditCtrl', ['$scope','downloadFactory', '$filter', '$window', '$http', 'cfpLoadingBar', '$timeout', 'settings',
    function ($scope, downloadFactory, $filter, $window, $http, cfpLoadingBar, $timeout, settings) {

        $scope.newChapter = { id: 0, chapter_title: "", chapter_description: "", sequence: 0, is_visible: 1 };

        $scope.editContent = app.initContent();
        $scope.content_list = [];
        $scope.content_sequence_list = [];

        $scope.content = {};
        $scope.editChapter = {};
        $scope.course_edit_url = "";
        $scope.course_chapter_update_url = "";
        $scope.course_chapter_content_update_url = "";
        $scope.course_chapter_content_delete_url = "";
        $scope.course_chapter_content_visibility_url = "";
        $scope.course_chapter_content_importance_url = "";
        $scope.course_chapter_content_sequence_update_url = "";
        $scope.course_chapter_edit_url = "";
        $scope.course_chapter_list = [];
        $scope.content_type = {};
        $scope.content_file_info = app.initFileInfo();
        $scope.msg_content_authorized = "";
        $scope.progressBar = 0;
        $scope.progressInfo = "";
        $scope.content_type_dict = {};
        $scope.showEditChapter = false;
        $scope.modalForVideo = false;
        $scope.modalForAudio = false;

        var msg_content_authorized = JSR.msg_content_authorized;
        var msg_max_file = JSR.msg_max_file.format(app.formatBytes(settings.max_size_upload))

        var content_upload_file_url = settings.content_upload_file_url;
        var content_delete_file_url = settings.content_delete_file_url;
        var content_update_upload_file_url = settings.content_update_upload_file_url;
        var content_download_media_url = settings.content_download_media_url;
        var content_download_file_url = settings.content_download_file_url;
        var content_get_image_url = settings.content_get_image_url;


        var upload_modal_id = "#uploadModalContent";
        var summernote_modal_id = "#writingModalContent";
        var social_modal_id = "#socialMediaModalContent";
        var summernote_editor_id = "#snEditorContent";
        var loaderVideoSpinnerId = '#loaderSocialMediaSpinner';

        var modal_id = "";

        //Chapter
        $scope.init = function (
            chapter, content, course_edit_url, course_chapter_update_url, course_chapter_content_update_url,
            course_chapter_content_visibility_url, course_chapter_content_importance_url, course_chapter_content_sequence_update_url,
            course_chapter_content_delete_url, course_chapter_list_url, course_chapter_edit_url
        ) {
            $scope.course_edit_url = course_edit_url;
            $scope.course_chapter_update_url = course_chapter_update_url;
            $scope.course_chapter_content_delete_url = course_chapter_content_delete_url;
            $scope.course_chapter_content_update_url = course_chapter_content_update_url;
            $scope.course_chapter_content_visibility_url = course_chapter_content_visibility_url;
            $scope.course_chapter_content_importance_url = course_chapter_content_importance_url;
            $scope.course_chapter_content_sequence_update_url = course_chapter_content_sequence_update_url;
            $scope.course_chapter_edit_url = course_chapter_edit_url;

            // for list content : css and text
            $scope.content_type_dict = settings.content_type_dict();

            if (chapter.status == 200) {
                $scope.editChapter = chapter.response;
                console.log($scope.editChapter)
            }

            if (content.status == 200) {
                $scope.content_list = content.response;

                angular.forEach($scope.content_list, function (val, key) {
                    // convert seconds to minutes
                    val.time_required_in_sec = (val.time_required_in_sec || 0)
                    val.time_required_in_min = convertToMinutes(val.time_required_in_sec);
                    val.file_size_in_bytes = (val.file_size_in_bytes || 0)
                });
            }

            //get chapters list
            $http({
                method: 'GET',
                url: course_chapter_list_url,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var data = response.data;
                if (data.status == 200) {
                    $scope.course_chapter_list = data.response;

                    angular.forEach($scope.course_chapter_list, function (val, key) {
                        val.href = "{0}/{1}".format(course_chapter_edit_url, val.id)
                        val.currentId = $scope.editChapter.id == val.id;
                    });
                }
            }, function (response) {
                app.responseStatus(response);
            });
        }

        $scope.editCourse = function ($event, obj) {
            $window.location.href = "{0}/{1}".format($scope.course_edit_url, obj.course_id);
        }

        $scope.listeChapters = function ($event, obj) {
            $window.location.href = "{0}/{1}#tb-chapters".format($scope.course_edit_url, obj.course_id);
        }

        $scope.reloadPage = function () { location.reload(); }

        var convertToMinutes = function (seconds) {
            return (seconds) ? Math.round(seconds / 60) : 0;
        }

        // reset all for file
        var resetContentFile = function () {
            $scope.content_file_info = app.initFileInfo();
            $scope.progressBar = 0;
            //$('#filesUpload').val('');
            window.resetFormUpload();
        }

        // reset all for summernote
        var resetContentSummerNote = function () {
            $scope.editContent.content_brief = ""
            $scope.editContent.content_text = ""
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
                        window.resetFormUpload();
                        toastr.error(JSR.msg_type_not_authorized.format(ext));
                        allowed = false;
                    };

                    if (file.size > settings.max_size_upload) {
                        window.resetFormUpload();
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
                    $scope.content_file_info.file_size_in_bytes = file.size;
                }
                $scope.$apply();
            } catch (e) {
                console.log(e);
                toastr.error(JSR.error_occurred_loading);
            }
        }

        // build url
        var buildUploadUrl = function (isNew, path_content, fileName, oldFileName) {
            path_content = encodeURIComponent(path_content);
            fileName = encodeURIComponent(fileName);

            if (isNew) {
                // Nouveau fichier
                return content_upload_file_url.format(path_content, fileName);
            } else {
                // Mise à jour d'un fichier existant
                return content_update_upload_file_url.format(
                    path_content,
                    fileName,
                    encodeURIComponent(oldFileName || '')
                );
            }
        }

        // helper ISO8601 → secondes
        function iso8601DurationToSeconds(isoDuration) {
            var regex = /PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?/;
            var matches = regex.exec(isoDuration);
            if (!matches) return 0;
            var h = parseInt(matches[1] || 0, 10);
            var m = parseInt(matches[2] || 0, 10);
            var s = parseInt(matches[3] || 0, 10);
            return h * 3600 + m * 60 + s;
        }

        $scope.fetchYouTubeInfo = function () {

            console.log(loaderVideoSpinner)
            var videoId = $filter('youtubeId')($scope.editContent.content_url);
            $scope.editContent.videoId = videoId;
            $scope.editContent.time_required_in_sec = 0;

            if (!videoId) {
                if ($scope.editContent.content_url) toastr.error(JSR.error_occurred);
                $scope.editContent.content_url = "";
                $scope.editContent.content_brief = "";
                $scope.editContent.content_cover_url = "";
                return;
            }

            var loaderVideoSpinner = $(loaderVideoSpinnerId);
            loaderVideoSpinner.removeClass("d-none");

            var oembedUrl = settings.youtube.oembedUrl + videoId + "&format=json";
            var apiKey = settings.youtube.api_key || ""; // stocke ta clé ici
            var apiUrl = settings.youtube.api_url + videoId + "&key=" + apiKey;

            // Si pas de clé → on saute direct au oEmbed
            if (!apiKey) {
                return fallbackToOembed();
            }

            $.getJSON(apiUrl, function (data) {
                if (data.items && data.items.length > 0) {
                    var video = data.items[0];
                    var isoDuration = video.contentDetails.duration;
                    var durationInSeconds = iso8601DurationToSeconds(isoDuration);
                    $scope.$applyAsync(function () {
                        $scope.editContent.content_brief = video.snippet.description;
                        $scope.editContent.content_cover_url = video.snippet.thumbnails.high.url;
                        $scope.editContent.time_required_in_sec = durationInSeconds;
                    });
                } else {
                    toastr.error(JSR.error_occurred);
                }
            }).fail(function () {
                fallbackToOembed();
            }).always(function () {
                loaderVideoSpinner.addClass("d-none");
            });

            function fallbackToOembed() {
                $.getJSON(oembedUrl, function (data) {
                    $scope.$applyAsync(function () {
                        $scope.editContent.content_brief = `${data.author_name} : ${data.title}`;
                        $scope.editContent.content_cover_url = data.thumbnail_url;
                    });
                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.error("Erreur lors de la récupération OEmbed :", textStatus, errorThrown);
                    toastr.error(JSR.error_occurred);
                    $scope.$applyAsync(function () {
                        $scope.editContent.content_brief = null;
                        $scope.editContent.content_cover_url = null;
                    });
                }).always(function () {
                    loaderVideoSpinner.addClass("d-none");
                });
            }
        };


        // --------------
        // Méthode Submit Principale du contenu du chapitre
        // --------------

        // step : submit update chapter min change
        $scope.submitForm = function (obj) {
            var url = $scope.course_chapter_update_url;
            $scope.editChapter = obj;
            $scope.editChapter.date_chapter_update = new Date();

            app.canSubmit(false);
            $http({
                method: 'POST',
                url: url,
                data: $scope.editChapter,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.showEditChapter = false;
                var response = response.data.response;
                if (response.id > 0) {
                    toastr.success(JSR.update_success, "", { timeOut: 10000 });
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                $scope.showEditChapter = false;
                app.responseStatus(response);
            });
        };

        // step : submit social media content
        $scope.submitSocialMediaContent = function (obj) {
            var id = $scope.editContent.id;
            var ct = $scope.editContent.ct;//css type
            //return;
            $http({
                method: 'POST',
                url: $scope.course_chapter_content_update_url,
                data: $scope.editContent,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var data = response.data;
                if (data.status == 200) {
                    var list = $scope.content_list;
                    if (id > 0) {
                        angular.forEach(list, function (val, key) {
                            if (val.id === id) {
                                list[key] = data.response;
                                list[key].ct = ct;
                            }
                        });
                    }
                    else
                        list.push(data.response);

                    $scope.content_list = list;

                    $(modal_id).modal('hide');
                    toastr.success(JSR.content_saved, "", { timeOut: 30000 });
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });

        };

        // step : submit writing content
        $scope.submitWritingContent = function (obj) {
            var id = $scope.editContent.id;
            var ct = $scope.editContent.ct;//css type
            var html = window.getSummerNoteCode(summernote_editor_id);
            $scope.editContent.content_text = html;

            $scope.editContent.time_required_in_sec = ($scope.editContent.time_required_in_min) ?
                Math.round($scope.editContent.time_required_in_min * 60) : 0;


            //return;
            $http({
                method: 'POST',
                url: $scope.course_chapter_content_update_url,
                data: $scope.editContent,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var data = response.data;
                if (data.status == 200) {
                    var list = $scope.content_list;
                    if (id > 0) {
                        angular.forEach(list, function (val, key) {
                            if (val.id === id) {
                                list[key] = data.response;
                                list[key].ct = ct;
                            }
                        });
                    }
                    else
                        list.push(data.response);

                    $scope.content_list = list;

                    $(modal_id).modal('hide');
                    toastr.success(JSR.content_saved, "", { timeOut: 30000 });
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });

        };

        // step : submit file if new or just data info
        $scope.submitContent = function (obj) {
            //console.log("submitContent", $scope.content_file_info);
            const isVideo = $scope.modalForVideo === true;
            const ec = $scope.editContent;
            const chapt = $scope.editChapter;
            const isNew = ec.id <= 0;

            // Construit le chemin et un nom de base pour les fichiers
            let path_content = app.buildContentPath(
                chapt.school_id,
                chapt.instructor_id,
                chapt.course_id,
                chapt.id
            );

            // Exemple: 123-45-678-9
            const baseFileName = `${chapt.school_id}-${chapt.instructor_id}-${chapt.course_id}-${chapt.id}`;

            // Récupère les blobs/file depuis le scope
            const input_media_blob = $scope.content_file_info.file;
            const file_size_in_bytes = $scope.content_file_info.file_size_in_bytes;
            const ext = $scope.content_file_info.ext;
            // Si c'est une vidéo, on récupère éventuellement la cover
            const input_media_cover_blob = isVideo ? window.getVideoCover() : null;

            // Nom des fichiers à uploader
            const file_name_media = input_media_blob
                ? `${baseFileName}.${ext}`
                : 'none';

            const file_name_cover = `${baseFileName}.jpeg`;

            // Construit les URLs d'upload pour la vidéo et/ou la cover
            const url_file_media = buildUploadUrl(
                isNew,
                path_content,
                file_name_media,
                ec.content_url
            );

            let url_file_media_cover = null;
            if (input_media_cover_blob) {
                // Si c'est un nouveau content ou qu'il n'existe pas encore de cover
                const newCover = isNew || !ec.content_cover_url;
                url_file_media_cover = buildUploadUrl(
                    newCover,
                    path_content,
                    file_name_cover,
                    ec.content_cover_url
                );
            }

            // Cas 1 : On a un nouveau fichier à uploader
            if (obj.new_blob_file) {
                // On prépare un tableau de Promises pour uploader la vidéo + éventuellement la cover
                const uploadPromises = [
                    uploadFileContent(url_file_media, input_media_blob) // upload de la vidéo
                ];

                if (input_media_cover_blob) {
                    uploadPromises.push(
                        uploadFileContent(url_file_media_cover, input_media_cover_blob) // upload de la cover
                    );
                }

                // On lance les uploads en parallèle
                Promise.all(uploadPromises)
                    .then(([filePath, filePathCover]) => {
                        // filePathCover sera undefined si on n'a pas de cover
                        saveInfoContent(filePath, filePathCover, file_size_in_bytes);
                    })
                    .catch((err) => {
                        console.error('Erreur lors de l’upload', err);
                    });

                // Cas 2 : On n'a pas de nouveau fichier, mais on peut vouloir mettre à jour la cover
            } else {
                // Si on a une nouvelle cover à uploader
                if (input_media_cover_blob && ec.update_cover) {
                    uploadFileContent(url_file_media_cover, input_media_cover_blob)
                        .then((filePathCover) => {
                            saveInfoContent(obj.content_url, filePathCover, obj.file_size_in_bytes);
                        })
                        .catch((err) => {
                            console.error('Erreur upload nouvelle cover :', err);
                        });
                } else {
                    // Sinon, on met juste à jour les infos (sans re-upload de fichier)
                    saveInfoContent(obj.content_url, obj.content_cover_url, obj.file_size_in_bytes);
                }
            }
        };

        //step 2
        var uploadFileContent = function (url_upload, fileBlob) {

            app.canSubmit(false);
            $scope.progressInfo = JSR.inprogress;
            var star_percent = 0.001;
            $scope.progressBar = star_percent;

            return $http({
                method: 'POST',
                headers: { 'Content-Type': 'application/octet-stream' },
                timeout: settings.timeout_file_post,
                url: url_upload,
                data: fileBlob,
                uploadEventHandlers: {
                    progress: function (e) {
                        if (e.lengthComputable) {
                            var pb = Math.round((e.loaded / e.total) * 100);
                            var loaded = app.formatBytes(e.loaded);
                            //console.log('Progression : ', pb + '%', 'Chargé : ', loaded); // Log de la progression

                            if (pb < star_percent) return;
                            $scope.progressBar = pb;
                            if (pb <= 99)
                                $scope.progressInfo = "{0}% - {1}: ".format(pb, loaded) + ((pb < 95) ? JSR.sent : JSR.almost_finished);
                            if (pb == 100)
                                $scope.progressInfo = "{0}% - {1}:{2} ...".format(pb, JSR.backup, JSR.file);

                            // Enable control
                            app.enableControl(true, "#btnCancelUpload");
                        }
                    }
                }
            }).then(function (response) {
                var data = response.data;
                if (response.status == 200) {
                    $scope.progressInfo = "100% - {0} ...".format(JSR.final_phase);
                    return data.file;
                }
                else {
                    toastr.error(response);
                }
                app.canSubmit(true);
            }, function (error) {
                $scope.progressBar = star_percent;
                $scope.progressInfo = JSR.error_connection;
                app.responseStatus(error);
                throw error;
            });
        }

        //step 3
        var saveInfoContent = function (filePath, filePathCover = "", file_size_in_bytes = null) {
            //console.log("saveInfoContent")
            var content_id = $scope.editContent.id;
            $scope.editContent.content_url = filePath;
            $scope.editContent.content_cover_url = filePathCover;
            $scope.editContent.file_size_in_bytes = file_size_in_bytes || $scope.editContent.file_size_in_bytes;
            var ct = $scope.editContent.ct;//css type
            $http({
                method: 'POST',
                url: $scope.course_chapter_content_update_url,
                data: $scope.editContent,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var data = response.data;
                if (data.status == 200) {
                    var list = $scope.content_list;
                    if (content_id > 0) {
                        angular.forEach(list, function (val, key) {
                            if (val.id === content_id) {
                                list[key] = data.response;
                                list[key].ct = ct;
                            }
                        });
                    }
                    else {
                        content_id = data.response.id;
                        list.push(data.response);
                    }

                    setTimeout(function () {
                        var vid = $("div#thumbvid{0}".format(content_id));
                        if (vid[0]) {
                            window.initToolTip(vid[0]);
                        }
                    }, 700);

                    $scope.content_list = list;

                    $(modal_id).modal('hide');
                    toastr.success(JSR.content_saved, "", { timeOut: 30000 });
                    $scope.$applyAsync();
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });

        }

        var getRemoteImage = function (image_url) {
            if (image_url == null || image_url == undefined || image_url?.length <= 0)
                return null;
            return `${content_get_image_url}${image_url}`;
        }


        // --------------
        // Display Media, Download or show text
        // --------------

        //Add New Content files or writing
        $scope.addContent = function (type_content) {
            var type = $scope.content_type_dict[type_content[0]];
            $scope.content_type = type;

            // Calcul de la séquence
            var sequence = 0;
            if ($scope.content_list.length > 0) {
                angular.forEach($scope.content_list, function (val) {
                    if (val.sequence > sequence)
                        sequence = val.sequence;
                });
            }
            sequence += 1;

            $scope.msg_content_authorized = msg_content_authorized.format(type.text, type.allowed_ext);
            $scope.msg_content_authorized += "<br/><br/>" + msg_max_file;

            // Déterminer le modal selon le type de contenu
            var is_summernote = (type.id == settings.content_type.text[0]);
            var is_video = (type.id == settings.content_type.video[0]);
            var is_audio = (type.id == settings.content_type.audio[0]);
            var is_social = (type.id == settings.content_type.youtube[0]); // ou tout autre social media

            // Choix du modal
            if (is_summernote) {
                modal_id = summernote_modal_id;
            } else if (is_social) {
                modal_id = social_modal_id;
            } else {
                modal_id = upload_modal_id;
            }

            // Préparer le modal
            $(modal_id).one('show.bs.modal', function (e) {
                $scope.modalForVideo = is_video;
                $scope.modalForAudio = is_audio;
                $scope.modalForSocial = is_social;

                $scope.editContent = angular.copy(app.initContent());
                $scope.editContent.sequence = sequence;
                $scope.editContent.content_type_id = type.id;

                if (is_summernote) {
                    resetContentSummerNote();
                    window.createSummerNote(summernote_editor_id);
                    window.setSummerNoteCode(summernote_editor_id, "");
                } else if (is_social) {
                    // Initialisation spécifique pour social media
                    $scope.editContent.youtube_url = "";
                } else {
                    resetContentFile();
                }
            }).on('hidden.bs.modal', function (e) {
                if (!is_summernote && !is_social) {
                    resetContentFile();
                }
            }).modal('show');
        };


        // Edit content
        $scope.editContentClick = function ($event, obj) {
            var content_type_id = obj.content_type_id;
            var type = $scope.content_type_dict[content_type_id];
            $scope.content_type = type;

            $scope.msg_content_authorized = msg_content_authorized.format(type.text, type.allowed_ext);
            $scope.msg_content_authorized += "<br/><br/>" + msg_max_file;

            // Détecter le type de contenu
            var is_summernote = (content_type_id == settings.content_type.text[0]);
            var is_video = (content_type_id == settings.content_type.video[0]);
            var is_audio = (content_type_id == settings.content_type.audio[0]);
            var is_social = (content_type_id == settings.content_type.youtube[0]); // ou autre social media

            // Sélection du modal
            if (is_summernote) modal_id = summernote_modal_id;
            else if (is_social) modal_id = social_modal_id;
            else modal_id = upload_modal_id;

            $(modal_id).one('show.bs.modal', function (e) {
                $scope.modalForVideo = is_video;
                $scope.modalForAudio = is_audio;
                $scope.modalForSocial = is_social;
                obj.time_required_in_min = convertToMinutes(obj.time_required_in_sec);
                $scope.editContent = angular.copy(obj);
                if (is_summernote) {
                    window.createSummerNote(summernote_editor_id);
                    window.setSummerNoteCode(summernote_editor_id, $scope.editContent.content_text);
                } else if (is_social) {
                    // Initialisation spécifique pour social media
                    $scope.editContent.youtube_url = obj.youtube_url || "";
                } else {
                    resetContentFile();
                    $scope.editContent.new_blob_file = false;
                    $scope.editContent.update_cover = false;

                    if (is_video || is_audio) {
                        setTimeout(function () {
                            var url_media = content_download_media_url.format(encodeURIComponent(obj.content_url));

                            if (is_video) {
                                window.loadPreviewVideoData(url_media, false);
                                var cover_url = getRemoteImage(obj.content_cover_url);
                                window.setThumbnailPreview(cover_url);
                            }

                            if (is_audio) {
                                window.loadPreviewAudioData(url_media);
                            }
                        }, 1000);
                    }
                }
            }).on('hidden.bs.modal', function (e) {
                if (!is_summernote && !is_social) {
                    resetContentFile();
                }
            }).modal('show');
        };

        $scope.player = null;
        // toggle fullscreen
        $scope.fullscreen = function () {
            if ($scope.player)
                $scope.player.core.mediaControl.toggleFullscreen();
        }
        // read content
        $scope.readUploadedContent = function ($event, obj) {
            window.closeAllToolTips();
            $scope.uploaded_content = angular.copy(obj);

            $scope.uploaded_content.content_sequence = obj.sequence;
            $scope.uploaded_content.chapter_sequence = $scope.editChapter.sequence;

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
                        $scope.uploaded_content = app.initContent();
                        $scope.$applyAsync();

                    }).modal('show');
                }
                else if (isSocial) { // social media                    
                    $("#socialMediaModal").on('hidden.bs.modal', function (e) {                       
                        $scope.$applyAsync(function () {
                            $scope.uploaded_content = app.initContent();
                        });                        
                    }).modal('show');
                }
                else { // download file

                    downloadFactory.startDownload(
                        obj.content_url,
                        content_download_file_url,
                        { "content_url": obj.content_url },
                        JSR,
                        app,null
                    ).then(function () {
                       
                        console.log("Download ended...")
                    });


                }
        }

        //delete content click
        $scope.deleteContentClick = function ($event, obj, index) {
            $event.preventDefault();
            var titre = obj.content_brief;
            var msg_delete = '<div class="alert alert-danger" role="alert">{0}'.format(JSR.alert_action_irreversible)
                + '<hr/>' + JSR.msg_delete_confirm + '<small class="d-block border-0 rounded p-2  bg-black text-center p-1 text-xs mt-2">{0}</small></div>'.format(titre);
            toastr.confirm(msg_delete,
                function () {
                    deleteContentInfo(obj);
                }, null);
        }

        // delete content info
        var deleteContentInfo = function (obj) {
            app.canSubmit(false);
           
            // console.log(obj)
            $http({
                method: 'POST',
                url: $scope.course_chapter_content_delete_url,
                data: { "id": obj.id },
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                app.canSubmit(true);
                var data = response.data;
                if (data.status == 200) {
                    var index = $scope.content_list.findIndex(function (c) { return c.id === obj.id });
                    $scope.content_list.splice(index, 1);

                    //reorder sequence
                    if ($scope.content_list.length)
                        angular.forEach($scope.content_list, function (val, idx) {
                            val.sequence = idx + 1;
                        });

                    toastr.success('{0} : {1}'.format(JSR.content2, JSR.deleted));
                    $scope.$applyAsync();

                }
                else {
                    toastr.error(data.response);
                }

            }, function (response) {
                app.responseStatus(response);
            });

        }

        //status content
        $scope.statusChangeContent = function ($event, obj) {
            $event.preventDefault();
            $scope.content = obj;
            var changeTo = $scope.content.is_visible ? JSR.offline : JSR.online;
            toastr.confirm('{0} : <b class="text-red">{1}</b> ?'.format(JSR.change_visibility, changeTo),
                function () {
                    app.canSubmit(false);
                    $scope.content.is_visible = !$scope.content.is_visible;

                    $http({
                        method: 'POST',
                        url: $scope.course_chapter_content_visibility_url,
                        data: { "id": $scope.content.id, "is_visible": $scope.content.is_visible },
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        var response = response.data.response;
                        app.canSubmit(true);
                        if (response.id > 0) {
                            var status = !$scope.content.is_visible ? JSR.offline : JSR.online;
                            toastr.success('{0} : <b>{1}</b> '.format(JSR.content2, status));
                        }
                        else {
                            toastr.error(response.data.response);
                        }

                    }, function (response) {
                        app.responseStatus(response);
                        $scope.content.is_visible = !$scope.content.is_visible;
                        $scope.$apply();
                    });
                }, null);
        }

        //importance content
        $scope.importanceChangeContent = function ($event, obj) {
            $event.preventDefault();
            $scope.content = obj;
            var changeTo = $scope.content.is_important ? JSR.normal : JSR.important;
            
            toastr.confirm('{0} : <b class="text-red">{1}</b> ?'.format(JSR.change_visibility, changeTo),
                function () {
                    app.canSubmit(false);
                    $scope.content.is_important = !$scope.content.is_important;

                    $http({
                        method: 'POST',
                        url: $scope.course_chapter_content_importance_url,
                        data: { "id": $scope.content.id, "is_important": $scope.content.is_important },
                        headers: { 'Content-Type': 'application/json; charset=utf-8' }
                    }).then(function (response) {
                        var response = response.data.response;
                        app.canSubmit(true);
                        if (response.id > 0) {
                            var status = !$scope.content.is_important ? JSR.normal : JSR.important;
                            toastr.success('Le contenu est de type <b>{0}</b> '.format(status));
                        }
                        else {
                            toastr.error(response.data.response);
                        }

                    }, function (response) {
                        app.responseStatus(response);
                        $scope.content.is_important = !$scope.content.is_important;
                        $scope.$apply();
                    });
                }, null);
        }

        //sort sequence content
        $scope.sortContent = function ($event) {
            $scope.content_sequence_list = angular.copy($scope.content_list);
            if ($scope.content_sequence_list.length < 2) {
                toastr.info(JSR.no_need_to_order, "", { timeOut: 10000 });
                return;
            }

            $('#sortable').sortable({
                autocreate: false,
                update: function (evt) {
                    var lst = $(this).sortable('serialize');
                    var seq = 1;
                    var listSorted = [];
                    angular.forEach(lst, function (val) {
                        $scope.content_sequence_list[val.id].sequence = seq++;
                        listSorted.push($scope.content_sequence_list[val.id]);
                    });
                    $scope.content_sequence_list = angular.copy(listSorted);
                    $scope.$apply();
                }
            });
        }

        //save change sequence
        $scope.submitContentSequence = function (list) {
            var dictSequences = {};
            angular.forEach(list, function (val) {
                dictSequences[val.id] = val.sequence;
            });
            $("#editModalContentList").modal('hide');
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.course_chapter_content_sequence_update_url,
                data: dictSequences,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.sequence == "ok") {
                    toastr.success(JSR.change_success, "", { timeOut: 10000 });
                    $scope.content_list = angular.copy($scope.content_sequence_list);
                }
                else {
                    toastr.error(response.data.response);
                }
                app.canSubmit(true);

            }, function (response) {
                app.responseStatus(response);
            });
        }

        //***** new chapter *****/

        //create chapter
        $scope.createChapter = function ($event) {
            console.log("createChapter");
            $event.preventDefault();
            $event.stopPropagation();
            var sequence = 0;
            if ($scope.course_chapter_list.length > 0) {
                angular.forEach($scope.course_chapter_list, function (val) {
                    if (val.sequence > sequence)
                        sequence = val.sequence;
                });
            }
            sequence += 1;
            $scope.newChapter.sequence = sequence;
            $("#editModalChapter").modal('show');
        }


        // save chapter info
        $scope.submitChapitre = function (obj) {
            $scope.newChapter = obj;
            $("#editModalChapter").modal('hide');
            app.canSubmit(false);
            $http({
                method: 'POST',
                url: $scope.course_chapter_update_url,
                data: $scope.newChapter,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                var response = response.data.response;
                if (response.id > 0) {
                    var msg = "<div class='p-2'><div>{0}</div><i class='fa fa-arrow-right-long fa-2x'></i></div>".format(JSR.registration_completed)
                    toastr.success(msg, JSR.chapter, { timeOut: 10000, disableClick: true });
                    setTimeout(function () {
                        $window.location.href = "{0}/{1}".format($scope.course_chapter_edit_url, response.id);
                    }, 1000)
                }
                else {
                    toastr.error(response.data.response);
                    app.canSubmit(true);
                }

            }, function (response) {
                app.responseStatus(response);
            });
        }


    }]);