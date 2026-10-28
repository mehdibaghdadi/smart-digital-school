const filesUploadId = '#filesUpload';
const loaderVideoSpinnerId = '#loaderVideoSpinner';
const videoPlayerId = '#videoPlayer';
const audioPlayerId = '#audioPlayer';
const captureBtnId = '#captureBtn';
const thumbnailPreviewId = '#thumbnailPreview';
const timeDisplayId = '#timeDisplay';
const maxHeightImg = 250;
const minHeightImg = 200;
var videoCoverBlob = null;

// Affiche ou masque le spinner de chargement
var showSpinner = function (show) {
    const loaderVideoSpinner = $(loaderVideoSpinnerId);
    const video = $(videoPlayerId);
    const $captureBtn = $(captureBtnId);

    if (show) {
        loaderVideoSpinner.removeClass("d-none");
        video.addClass("f-blur");
        $captureBtn.prop("disabled", true);
    }
    else {
        loaderVideoSpinner.addClass("d-none");
        video.removeClass("f-blur");
        $captureBtn.prop("disabled", false);
    }
}

// Formate une durée en secondes en mm:ss
var formatTime = function (seconds) {
    const min = Math.floor(seconds / 60);
    const sec = Math.floor(seconds % 60);
    // Formater pour que les secondes aient toujours 2 chiffres
    return min + ":" + (sec < 10 ? "0" : "") + sec;
}

// Retourne le Blob de la miniature capturée (ou null si aucune)
var getVideoCover = function () {
    return videoCoverBlob;
}

// Redimensionne un canvas source avec Pica et retourne un dataURL JPEG via callback
var resizeCanvasWithPica = function (canvasSource, callback) {
    const picaInstance = window.pica();
    videoCoverBlob = null;
    // Dimensions d'origine
    const origWidth = canvasSource.width;
    const origHeight = canvasSource.height;

    // Calcul de la hauteur/largeur cibles selon min/max
    let targetHeight = origHeight;
    if (origHeight > maxHeightImg) {
        targetHeight = maxHeightImg;
    } else if (origHeight < minHeightImg) {
        targetHeight = minHeightImg;
    }
    const scale = targetHeight / origHeight;
    const targetWidth = origWidth * scale;

    // Crée le canvas cible
    const canvasTarget = document.createElement('canvas');
    canvasTarget.width = targetWidth;
    canvasTarget.height = targetHeight;

    // Redimensionnement haute qualité avec Pica
    picaInstance.resize(canvasSource, canvasTarget)
        .then(() => {
            // Convertir le canvas cible en Blob JPEG
            return picaInstance.toBlob(canvasTarget, 'image/jpeg', 0.70);
        })
        .then(blob => {
            // Convertir ce Blob en dataURL (base64) pour pouvoir l'afficher dans un <img>
            const reader = new FileReader();
            reader.onload = (e) => {
                const resizedDataURL = e.target.result;
                // => "data:image/jpeg;base64,...."
                callback(resizedDataURL);
            };

            reader.onerror = function () { videoCoverBlob = null; callback(null) };

            videoCoverBlob = new File([blob], "coverImage.jpg", { type: "image/jpeg" });
            reader.readAsDataURL(blob);
        })
        .catch(error => {
            console.error('Erreur lors du redimensionnement Pica:', error);
            videoCoverBlob = null;
            callback(null);
        });
}

// Définit l'aperçu de la miniature dans le scope Angular
var setThumbnailPreview = function (url) {
    const $thumbnailPreview = $(thumbnailPreviewId);
    if (url) {
        $thumbnailPreview.css({
            "background-image": "url('" + url + "')",
            "background-size": "contain",  
            "background-position": "top center", 
            "background-repeat": "no-repeat",
            "background-color": "#000"
        })
    } else
        $thumbnailPreview.css({ "background-image": "url('')" });

}

// Définit la durée requise dans le scope Angular
var setInfoFileMedia = function (scope, file) {
    var durationSec = Math.round(file.duration || 0);
    scope.editContent.time_required_in_sec = durationSec;
    console.log("filesize :", file.duration);

}

// Capture la frame courante de la vidéo et la redimensionne pour l'afficher en miniature
var captureCurrentFrame = function () {
    const $videoPlayer = $(videoPlayerId);
    const $thumbnailPreview = $(thumbnailPreviewId);
    const $timeDisplay = $(timeDisplayId)[0];

    // Récupère l'élément video du DOM
    const video = $videoPlayer[0];

    // Met à jour l'affichage du temps si besoin
    $timeDisplay.innerHTML = formatTime(video.currentTime);

    // Crée un canvas source pour la frame capturée
    const captureCanvas = document.createElement('canvas');
    captureCanvas.width = video.videoWidth;
    captureCanvas.height = video.videoHeight;

    // Dessine la frame actuelle du <video> dans ce canvas
    const ctx = captureCanvas.getContext('2d');
    ctx.drawImage(video, 0, 0, captureCanvas.width, captureCanvas.height);

    // Redimensionne le canvas source via Pica et obtient un dataURL JPEG
    resizeCanvasWithPica(captureCanvas, function (resizedDataURL) {
        if (resizedDataURL) {
            setThumbnailPreview(resizedDataURL);
            // (Optionnel) Animation
            $thumbnailPreview.addClass("fa-fade");
            setTimeout(() => $thumbnailPreview.removeClass("fa-fade"), 700);
        } else {
            console.error("Le redimensionnement de l'image a échoué ou a été annulé.");
        }
    });
}

// Réinitialise le formulaire d'upload
var resetFormUpload = function () {
    videoCoverBlob = null;
    var filesUpload = $(filesUploadId);
    filesUpload.val('');
    var ok = angular.element(filesUpload).scope().modalForVideo || angular.element(filesUpload).scope().modalForAudio;
    if (ok) {
        $(videoPlayerId).attr('src', '');    // retire la vidéo
        $(audioPlayerId).attr('src', '');    // retire audio
        setThumbnailPreview(null); // retire la miniature
        $(captureBtnId).prop("disabled", true);
        showSpinner(false);
    }
}

// Charge une vidéo dans le player et capture la frame 0 si demandé
var loadPreviewVideoData = function (videoURL, capture = true) {
    const $videoPlayer = $(videoPlayerId);
    const $captureBtn = $(captureBtnId);
    const $timeDisplay = $(timeDisplayId)[0];

    // Dès que les données de la vidéo sont disponibles, on capture automatiquement la frame 0
    $videoPlayer.off('loadeddata').on('loadeddata', function () {
        console.log("loadeddata");
        const video = $videoPlayer[0];

        // Affiche la durée requise
        setInfoFileMedia(angular.element(this).scope(), video);

        setTimeout(function () {
            showSpinner(false);
            if (capture)
                captureCurrentFrame();
        }, 700);
    });

    $videoPlayer.off('error').on('error', function (e) {
        if (!$(this).attr('src')) {
            // src vide => on ignore cette "erreur" 
            return;
        }
        console.log("error", e);
        setTimeout(function () {
            showSpinner(false);
            $captureBtn.prop("disabled", true);
        }, 700);
    });

    showSpinner(true);
    $videoPlayer.attr('src', videoURL);
    $timeDisplay.innerHTML = "";
    $videoPlayer[0].load();


}

// Charge un audio dans le player
var loadPreviewAudioData = function (audioURL) {
    const $audioPlayer = $(audioPlayerId);
    // Dès que les données de la vidéo sont disponibles, on capture automatiquement la frame 0
    $audioPlayer.off('loadeddata').on('loadeddata', function () {
        console.log("loadeddata");
        const audio = $audioPlayer[0];
        // Affiche la durée requise
        setInfoFileMedia(angular.element(this).scope(), audio);
        setTimeout(function () {
            showSpinner(false);
        }, 700);
    });

    $audioPlayer.off('error').on('error', function (e) {
        if (!$(this).attr('src')) {
            // src vide => on ignore cette "erreur" 
            return;
        }
        console.log("error", e);
        setTimeout(function () {
            showSpinner(false);
        }, 700);
    });

    showSpinner(true);
    $audioPlayer.attr('src', audioURL);
    $audioPlayer[0].load();
}

// Initialisation des événements jQuery
$(document).ready(function () {
    const $filesUpload = $(filesUploadId);
    const $captureBtn = $(captureBtnId);
    const $thumbnailPreview = $(thumbnailPreviewId);

    $filesUpload.on('change', function (event) {
        videoCoverBlob = null;
        angular.element(this).scope().fileNameChanged(this);
        var modalForVideo = angular.element(this).scope().modalForVideo;
        var modalForAudio = angular.element(this).scope().modalForAudio;

        const file = event.target.files[0];
        if (!file) {
            return;
        }
        const mediaURL = URL.createObjectURL(file);

        // Crée une URL temporaire pour la vidéo ou audio sélectionnée
        if (modalForVideo)
            loadPreviewVideoData(mediaURL, true);
        else if (modalForAudio)
            loadPreviewAudioData(mediaURL, true);

    });

    $captureBtn.on('click', function (e) {
        captureCurrentFrame();
    });
    $thumbnailPreview.on('click', function () {
        var url = $(this).css("background-image");
        // Nettoyer `url("...")` pour garder l'URL brute
        url = url.replace(/^url\(["']?/, '').replace(/["']?\)$/, '');
        toastr.image(url)
    });
    $(".btnThumbnailPreview").on('click', function () {
        $thumbnailPreview.trigger('click');
    });
});