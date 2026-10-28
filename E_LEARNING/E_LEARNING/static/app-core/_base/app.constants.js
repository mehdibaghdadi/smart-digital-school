var sds_app_constants = {
    roles: {
        student: 'Student',
        instructor: 'Instructor',
        school: 'School',
        admin: 'Admin',
        any: 'Any'
    },
    login_timer_attempts: 30000, //msc
    morocco_country_id: 116,
    maxBufferSize: 4 * 1048576, // 4 Mo pour HD
    watermarkVideo: "//" + window.location.host + '/static/app-assets/img/logo.png',
    payment_status: {
        finished: '1',
        pending: '2',
        failed: '3',
        canceled: '4',
        to_validate: '5',
    },
    payment_method: {
        credit_card: "credit_card",
        paypal: "paypal",
        bank_transfer: "bank_transfer",
        contact_sales: "contact_sales"
    },
    youtube: {
        oembedUrl: "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=",
        api_key: 'AIzaSyC2bUT2W-a3kyA1jtSpTnbOZWAUO5-aC5Q', // Replace with your actual API key
        api_url: 'https://www.googleapis.com/youtube/v3/videos?part=contentDetails,snippet&id='
        
    }
};

sds_app_constants.content_type = {
    video: [1, JSR.video, "fa fa-video", ".mp4, .webm, .ogg", "bg-gradient-video", "text-info"],
    audio: [2, JSR.audio, "fa fa-microphone-alt", ".mp3, .wav, .ogg", "bg-gradient-audio", "text-olive"],
    document: [3, JSR.file, "fa fa-ew-document", ".xlsx, .xls, .doc, .docx, .ppt, .pptx, .pdf, .zip, .rar", "bg-gradient-file", "text-orange"],
    text: [4, JSR.writing, "fab fa-wordpress", "*", "bg-gradient-text", "text-info"],
    youtube: [5, "Youtube", "fab fa-youtube", "url", "bg-gradient-youtube", "text-danger"]
};

sds_app_constants.content_type_dict = function () {
    const dict = {};
    angular.forEach(sds_app_constants.content_type, (value) => {
        const [id, text, css, allowed_ext, bg, color] = value;
        dict[id] = { id, text, css, allowed_ext, bg, color };
    });
    return dict;
};

sds_app_constants.content_type_from_ext = function (ext) {
    let result = {};
    angular.forEach(sds_app_constants.content_type, function (value) {
        if (value[3].includes(ext)) {
            result = {
                id: value[0],
                text: value[1],
                css: value[2],
                allowed_ext: value[3],
                bg: value[4],
                color: value[5]
            }
        }
    });
    return result;
};
