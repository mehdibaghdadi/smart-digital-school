
var previewsContainer = "#previews";
var previewsImage = "#image-profile";
var createProfilDropzone = function (url_post) {
    try {

        Dropzone.autoDiscover = false;
        var previewNode = document.querySelector("#template");
        previewNode.id = "";
        var previewTemplate = previewNode.parentNode.innerHTML;
        previewNode.parentNode.removeChild(previewNode);
        var bg_profil_picture = "bg-profil-picture";
        var initImageUrl = ""
        var profilDropzone = new Dropzone("#upload-profil", {
            url: url_post, // Set the url
            acceptedFiles: ".jpeg,.jpg,.png,.gif",
            thumbnailWidth: null,
            thumbnailHeight: 320,
            maxFilesize: 7,
            maxFiles: 1,
            previewTemplate: previewTemplate,
            autoQueue: false,
            previewsContainer: previewsContainer,
            clickable: ".fileinput-button",
            accept: function (file, done) {
                $(previewsContainer).removeClass(bg_profil_picture).removeAttr('style');
                done();
            }
        });

        // default picture
        profilDropzone.initPreview = function (imageUrl) {

            if (imageUrl == null)
                imageUrl = profilDropzone.initImageUrl;
            console.log(imageUrl)
            $(previewsContainer).addClass(bg_profil_picture)
                .css('background-image', 'url(' + imageUrl + ')');
        }

        profilDropzone.getPreview = function () {
            var files = profilDropzone.getAcceptedFiles();
            var images = $(previewsImage);
            if (files.length > 0 && images.length > 0)
                return images[0].currentSrc;

            return null;
        }

        //Events
        profilDropzone.on("error", function (file) {
            if (!file.accepted) {
                this.removeFile(file);
                toastr.error(JSR.acceptable_image_size.format(this.options.acceptedFiles, this.options.maxFilesize)
                    , "{0} : {1}".format(JSR.file, JSR.error), { timeOut: 10000 });
            }
            if (this.files.length < 1) {
                profilDropzone.initPreview();
            }
        });

        profilDropzone.on("addedfile", function (file) {
            // Hookup the start button
            if (this.files.length > 1) {
                this.removeFile(this.files[0]);
            }
        });

        // Update the total progress bar
        profilDropzone.on("totaluploadprogress", function (progress) {
            try {
                $("#total-progress .progress-bar").style.width = progress + "%";
            } catch { }
        });

        // Hide the total progress bar when nothing's uploading anymore
        profilDropzone.on("queuecomplete", function (progress) {
            try {
                document.querySelector("#total-progress").style.opacity = "0";
            } catch { }
        });

        document.querySelector("#actions .cancel").onclick = function () {
            profilDropzone.removeAllFiles(false);
            setTimeout(function () {
                profilDropzone.initPreview(null);
            }, 500);
        };

        $(previewsContainer).on("click", function (e) {
            toastr.image(profilDropzone.initImageUrl);
        });

        return profilDropzone;
    } catch (e) {
        console.log(e)
    }
    return null;
};


