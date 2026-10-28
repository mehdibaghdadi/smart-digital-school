var mySmEditor = "";

var placeholderSnote = `${JSR.write} ${JSR.text} ...`.toUpperCase();
//--- type creation ----
var createSummerNote = function (id) {
    mySmEditor = id;

    //Add text editor
    $(id).summernote({
        inheritPlaceholder: true,
        placeholder: placeholderSnote,
        lang: JSR.current_language_ext,
        dialogsInBody: true,
        disableDragAndDrop: true,
        disableResizeEditor: true,
        toolbar: [
            ['edit', ['undo', 'redo']],
            ['headline', ['style']],
            ['style', ['bold', 'italic', 'underline', 'superscript', 'subscript', 'strikethrough', 'clear']],
            ['fontface', ['fontname']],
            ['textsize', ['fontsize']],
            ['fontclr', ['color']],
            ['alignment', ['ul', 'ol', 'paragraph', 'lineheight']],
            ['height', ['height']],
            ['table', ['table']],
            ['insert', ['myImage', 'hr']],
            ['view', ['codeview']],
            //['misc', ['print']]
        ],
        buttons: createButtonsSmCustom(),
    });
    focusSummerNote(id);

};

var createSummerNoteLight = function (id) {
    mySmEditor = id;

    //Add text editor
    $(id).summernote({

        inheritPlaceholder: true,
        placeholder: placeholderSnote,
        lang: JSR.current_language_ext,
        dialogsInBody: true,
        disableDragAndDrop: true,
        toolbar: [
            ['edit', ['undo', 'redo']],
            ['style', ['bold', 'italic', 'underline']],
            ['textsize', ['fontsize']],
            ['fontclr', ['color']],
            ['insert', ['myImage']]
        ]
    });
    focusSummerNote(id);

};

var createFullSummerNote = function (id) {
    mySmEditor = id;

    //Add text editor
    $(id).summernote({
        inheritPlaceholder: true,
        placeholder: placeholderSnote,
        lang: JSR.current_language_ext,
        toolbar: [
            ['edit', ['undo', 'redo']],
            ['headline', ['style']],
            ['style', ['bold', 'italic', 'underline', 'superscript', 'subscript', 'strikethrough', 'clear']],
            ['fontface', ['fontname']],
            ['textsize', ['fontsize']],
            ['fontclr', ['color']],
            ['alignment', ['ul', 'ol', 'paragraph', 'lineheight']],
            ['height', ['height']],
            ['table', ['table']],
            ['insert', [ 'myImage', 'myFile', 'hr']],
            ['view', ['codeview',]],
            //['misc', ['print']]
        ],
        buttons: createButtonsSmCustom()
    });
    focusSummerNote(id);

}

//--- methods Buttons--------
var createButtonsSmCustom = function () {
    return {
        myImage: function (context) {
            const ui = $.summernote.ui;
            const lang = $.summernote.lang[JSR.current_language_ext] || {};
            const tooltip = lang.image && lang.image.image || 'Image';
            return ui.button({
                contents: '<i class="fa fa-image"></i>',
                tooltip: tooltip,
                click: function () {
                    openCustomImagePicker();
                }
            }).render();
        },
        myFile: function (context) {
            const ui = $.summernote.ui;
            const lang = $.summernote.lang[JSR.current_language_ext] || {};
            const tooltip = (lang.file && lang.file.upload) || JSR.file;
            return ui.button({
                contents: '<i class="fa fa-upload"></i>',
                tooltip: tooltip,
                click: function () {
                    openCustomFilePicker();
                }
            }).render();
        }
    }
}
//--- method Image--------
var openCustomImagePicker = () => {
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = 'image/*';

    input.onchange = async function (e) {
        const file = e.target.files[0];
        if (!file) return;

        const name = file?.name?.replace(/(\W+)/gi, '-');

        try {
            // 🔹 Redimensionnement avec Pica
            const resizedBase64 = await resizeImagePica(file, 1200, 1200, 'base64');

            // 🔹 Insertion dans Summernote
            const html = `<img src="${resizedBase64}" alt="${name}" style="max-width:100%" />`;
            $(mySmEditor).summernote('pasteHTML', html);

            console.log();
        } catch (error) {
            console.error("Erreur lors du redimensionnement :", error);
            toastr.error("Error image.");
        }
    };

    input.click();
};

//--- method Image--------

var openCustomFilePicker = () => {
    const ext = sds_app_constants.content_type.document[3];
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = ext;

    input.onchange = async function (e) {
        const file = e.target.files[0];
        if (!file) return;

        try {

            var reader = new FileReader();
            const name = file?.name?.replace(/(\W+)/gi, '-');
            reader.onload = function (e) {
                // browser completed reading file - display it
                var blob = (e.target.result);
                var html =
                    '<div>&nbsp;</div><div class="border text-left parent-smr d-inline-block" contenteditable="false" >' +
                    '<span contenteditable="false" class="text-center" style="height:50px">' +
                    '<button class="smnote-download btn btn-danger text-uppercase text-truncate" onclick="file_smnote_download(this)" data-filename="'
                    + name + '"  data-href="' + blob
                    + '" >'
                    + '<span class="d-inline-block"><i class="fa fa-download text-info mr-1"></i>'
                    + '<b>' + JSR.download + '</b> :</span> <span contenteditable="false" class="text-danger font-weight-bold d-inline-block text-truncate filename_smnote"> '
                    + name + '</span></button></span><button type="button" title="' + JSR.delete + ' : ' + JSR.file + '" class="delete-smr btn btn-sm btn-danger p-1" onclick="delete_smnote_download(this)"><i class="fa fa-close"></button></i></div>'
                    + '<div>&nbsp;</div>';

                $(mySmEditor).summernote('pasteHTML', html);
            };
            reader.readAsDataURL(file);

        } catch (error) {

            console.error("Erreur fichier:", error);
            toastr.error("Error file");
        }
    };

    input.click();
};


//--- methods SummerNote--------

var focusSummerNote = function (id) {
    setTimeout(function () {
        $(id).summernote('focus');
    }, 1000);
}


var delete_smnote_download = function (sender) {
    console.log($(sender).closest('.parent-smr'))
    $(sender).closest('.parent-smr').remove();
}

var file_smnote_download = function (sender) {
    var data = ($(sender)).attr("data-href");
    var filename = ($(sender)).attr("data-filename");
    var downloadLink = document.createElement("a");

    downloadLink.href = data;
    downloadLink.download = filename;
    downloadLink.click();

}

var setSummerNoteCode = function (id, html) {
    $(id).summernote('code', html);
};

var setSummerNoteFocus = function (id, html) {
    setTimeout(function () {
        if ($(id).length) {
            $(".note-toolbar")[0].scrollIntoView({
                behavior: "smooth",
                block: "start"
            });
        }
    }, 500);
    //$(id).summernote('focus');

}

var getSummerNoteCode = function (id) {
    return $(id).summernote('code');
};

var isSummerNoteEmpty = function (id) {
    return $(id).summernote('isEmpty');
}

var enableSummerNote = function (id, enabled) {
    var state = enabled ? 'enable' : 'disable';
    $(id).summernote(state);
}