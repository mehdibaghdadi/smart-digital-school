const _watermarkVideo = app_settings.watermarkVideo || "";

var mediaPlayerContent = function (id) {
    var player = new Clappr.Player({
        // === CONFIGURATION DE BASE ===
        parentId: id,
        width: "100%",
        height: 400,
        autoPlay: false,
        mute: false,
        persistConfig: false,
        // === WATERMARK ===
        watermark: _watermarkVideo,
        position: 'top-right',

        // === CONTRÔLES & UI ===
        hideMediaControl: false,
        mediacontrol: {
            seekbar: "#0F78B3",
            buttons: "#0F78B3"
        },

        // === PRÉCHARGEMENT ===
        preload: 'metadata',

        // === PLUGINS ===
        plugins: [PlaybackRatePlugin],

        // === CONFIGURATION PLAYBACK ===
        playback: {
            playbacks: [Clappr.HTML5VideoPlayback],

            html5: {
                preload: 'metadata',
                crossOrigin: 'anonymous',
                minDvrSize: 10,
                maxBufferLength: 60,
                buffered: true,
            }
        },

        // === CONFIGURATION HTML5 SPÉCIFIQUE ===
        html5: {
            video: {
                preload: 'metadata',
                crossOrigin: 'anonymous',
                playsinline: true,
                disablePictureInPicture: false,
                controlsList: 'nodownload'
            }
        },

        // === CONFIGURATION VITESSE DE LECTURE ===
        playbackRateConfig: {
            defaultValue: 1,
            options: [
                { value: 0.5, label: '0.5x' },
                { value: 0.75, label: '0.75x' },
                { value: 1, label: '1x' },
                { value: 1.25, label: '1.25x' },
                { value: 1.5, label: '1.5x' },
                { value: 2, label: '2x' },
            ],
        },

        // === OPTIMISATION BUFFER ===
        buffering: {
            delay: 1500,
            hideDelay: 1000
        }
    });

    // === GESTIONNAIRES D'ÉVÉNEMENTS CORRIGÉS ===

    player.on(Clappr.Events.PLAYER_BUFFERING, function () {
        console.log('Buffering en cours...');
    });

    player.on(Clappr.Events.PLAYER_BUFFERFULL, function () {
        console.log('Buffer rempli');
    });

    player.on(Clappr.Events.PLAYER_ERROR, function (error) {
        console.error('Erreur lecteur:', error);
        if (error.message.includes('format') || error.message.includes('support')) {
            console.log('Format non supporté');
            showFormatError();
        }
    });

    player.on(Clappr.Events.PLAYER_READY, function () {
        setTimeout(() => {
            player.setVolume(75);
            console.log('Player prêt', player.getVolume());
        }, 500);

    });

    // === FONCTIONS UTILITAIRES ===
    function showFormatError() {
        const errorDiv = document.createElement('div');
        errorDiv.style.cssText = 'position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); background:rgba(0,0,0,0.8); color:white; padding:20px; border-radius:5px; text-align:center; z-index:1000;';
        errorDiv.innerHTML = '<h3>Format non supporté</h3><p>Veuillez utiliser un format MP4</p>';
        document.getElementById(id).appendChild(errorDiv);
    }

    return player;
};