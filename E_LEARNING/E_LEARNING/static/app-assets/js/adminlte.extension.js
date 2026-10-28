
//History
var goBack = function () {
    if (history.length > 1) {
        history.back();
    } else {
        window.location.href = "/";
    }
}

//IS MOBILE
var isMobile = () => {
    const userAgentCheck = /Android|webOS|iPhone|iPad|iPod|BlackBerry|Windows Phone|IEMobile|Mobile Safari|Opera Mini/i.test(navigator.userAgent);
    const screenCheck = window.innerWidth <= 768;
    var ok = userAgentCheck || screenCheck;
    return ok;
};

//SCROLL VIEW
var SmootScrollView = function (id) {
    document.getElementById(id).scrollIntoView({
        behavior: 'smooth',
        block: 'start'
    });
}
var SmootScrollViewTopLayout = function () {
    SmootScrollView('Layout-content-section');
}

//Change Language
var initSelectChangeLanguague = function (url) {
    $('#languageDropdown').change(function () {
        var sender = $(this);
        var selectedLanguage = sender.val();
        var k = 'Bearer ' + $('input[name="__X_RVT"]').attr('value');
        toastr.success("LOADING . . . ", "", { toast: true });

        app.canSubmit(false);
        $.ajax({
            url: url + "?lang=" + selectedLanguage,
            type: "POST",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Access-Control-Allow-Origin', '*');
                xhr.setRequestHeader('Authorization', k);
            },
            success: function (data) {
                window.location.reload();
                setTimeout(function () { app.canSubmit(true); }, 50000);

            },
            error: function (request, status, error) {
                toastr.error(JSR.error, "", { toast: true });
                app.canSubmit(true);
                console.log(request.responseText);

            }
        });

    });
}

//SWAL FIRE
var toastr = Swal.mixin();
var toastr_timeOut = 7000;

// Tools UI
var initToolTip = function (target) {
    $(target).tooltip({
        container: 'body',
        hide: { "show": 500, "hide": 100, effect: "hide" },
        track: true,
        html: true,
        trigger: "hover",
        position: {
            my: "right bottom-10",
        },
        content: function () {
            return "<div class='p-1'>" + $(this).prop('title') + "</div>";
        },
    }).on('focus focusin focusout blur dragstart mouseleave click', function (e) {
        $(this).tooltip('close');
    });
}

// Close all tooltips
var closeAllToolTips = function () {
    setTimeout(() => {
        $('.ui-tooltip').hide();
    }, 300);
}

// MAUI BRIDGE
var notifyMaui = function (message) {
    if (window.jsBridge && window.jsBridge.postMessage) {
        window.jsBridge.postMessage(message);
    }
}

// Remove modal from history
var removeModalHistory = function () {

    if ($('.modal.show').length) {
        $('.modal.show').modal('hide');
    }
    if (history.state && history.state.modalOpen) {
        notifyMaui('modalClosed');
        history.replaceState({ modalOpen: false }, "", location.pathname);
        history.back();
    }

    if (history.state && history.state.modalFormOpen) {
        notifyMaui('modalClosed');
        history.replaceState({ modalFormOpen: false, formMustClose: true }, "", location.pathname);
        history.back();
    }



}

var downloadBlob = function (blobUrl, fileName) {


    // Vérifie que l’interface Android existe
    if (!window.BlobReceiver || !window.BlobReceiver.postBlob) {
        toastr.error("Android interface not available.");
        return;
    }

    // Télécharge le blob à partir de l’URL
    fetch(blobUrl)
        .then(response => response.blob())
        .then(blob => {
            const reader = new FileReader();
            reader.onloadend = function () {
                try {
                    const base64 = reader.result.split(',')[1];

                    // Envoie à Android
                    var done = window.BlobReceiver.postBlob(base64, fileName);
                    if (done)
                        toastr.success(
                            `${JSR.download}`,
                            `<i class='mr-2 text-info fa fa-check'></i> ${JSR.finished} `,
                            { timeOut: 15000, toast: true, position: 'bottom-start' }
                        );
                } catch (e) {
                    console.error("❌ Error :", e);

                }
            };
            reader.readAsDataURL(blob);
        })
        .catch(error => {
            console.error("❌ Error fetching blob:", error);
        });
}

//ON READY
$(function () {

    initToolTip('[data-toggle="tooltip"]');
    

    $(document).on('click', function (e) {
        if (!$(e.target).closest('[data-toggle="tooltip"], .ui-tooltip').length) {
            closeAllToolTips();
        }
    });
    $(".modal-dialog").draggable({
        handle: ".modal-header"

    });
    $('.dropdown-menu').on('click', function (e) {
        e.stopPropagation();
    });

    // ***********Modal events
    // Intercepter le clic sur "Back"
    window.addEventListener('popstate', function (event) {
        // Si un modal est ouvert, on le ferme et on empêche le retour        
        removeModalHistory();
    });

    $(document).on("show.bs.modal", '.modal', function (e) {
        
        if (document.documentElement.scrollTop < 25 && isMobile())
            window.scrollBy({
                top: 25,
                behavior: 'smooth'
            });

        history.replaceState({ modalOpen: false }, "", location.pathname);

        setTimeout(() => {
            history.pushState({ modalOpen: true }, "");
            notifyMaui('modalOpened');
            closeAllToolTips();
        }, 200);

        $(".modal-dialog").css({
            top: 0,
            left: 0
        });
    });
    $(document).on('hidden.bs.modal', '.modal', function () {
        // Quand on ferme le modal manuellement, on enlève l’état ajouté
        removeModalHistory();
    });


    //************SWAL FIRE SETUP
    var toastr_fire = function (icon, content, title, options) {
        title = title == undefined ? '' : title;
        var opt = options ? options : {};
        var iconHtml = '';
        switch (icon) {

            case 'success':
                iconHtml = '<i class="fa fa-check fa-fade"></i>';
                break;
            case 'error':
                iconHtml = '<i class="fa fa-times fa-fade"></i>';
                break;
            case 'info':
                iconHtml = '<i class="fa fa-info fa-fade"></i>';
                break;
            case 'warning':
                iconHtml = '<i class="fa fa-exclamation fa-fade"></i>';
                break;
            default:
                iconHtml = '';
        }

        toastr.fire({
            icon: icon,
            iconHtml = iconHtml,
            title: " " + title,
            html: content,
            timer: opt.timeOut ? opt.timeOut : toastr_timeOut,
            toast: opt.toast ? opt.toast : false,
            position: opt.position ? opt.position : (opt.toast ? 'top-end' : 'center'),
            showConfirmButton: !opt.toast,
            timerProgressBar: true,
            allowOutsideClick: opt.disableClick ? false : true,
            showClass: {
                popup: 'animate-opacity'
            },
            willClose: () => {
                closeAllToolTips();
            }
        });
        if (opt.disableTimer)
            toastr.stopTimer();

    }
    toastr.success = function (content, title, options) { toastr_fire('success', content, title, options) }
    toastr.error = function (content, title, options) { toastr_fire('error', content, title, options) }
    toastr.info = function (content, title, options) { toastr_fire('info', content, title, options) }
    toastr.warning = function (content, title, options) { toastr_fire('warning', content, title, options) }
    toastr.image = function (imageUrl) {
        Swal.fire({
            imageUrl: imageUrl,
            width: '800px',
        });
    }
    toastr.confirm = function (title, callBack, callBackDenied) {
        toastr.fire({
            html: title,
            showDenyButton: true,
            icon: 'warning',
            iconHtml = '<i class="fa fa-exclamation fa-fade"></i>',
            denyButtonText: JSR.cancel,
            confirmButtonText: JSR.yes_i_confirm,
            showClass: {
                popup: 'animate-opacity'
            }
        }).then(function (result) {
            if (result.isConfirmed) {
                if (callBack)
                    callBack();
                return true;
            } else if (result.isDenied) {
                if (callBackDenied)
                    callBackDenied();
            }
        });
        return false;
    }


});



