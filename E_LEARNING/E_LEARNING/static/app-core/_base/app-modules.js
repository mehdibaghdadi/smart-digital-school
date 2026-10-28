var app = angular.module('appSDS', ['chieffancypants.loadingBar', 'angular.filter', 'datatables']);

app.config(['$interpolateProvider', 'cfpLoadingBarProvider', '$locationProvider', '$httpProvider', '$compileProvider',
    function ($interpolateProvider, cfpLoadingBarProvider, $locationProvider, $httpProvider, $compileProvider) {
        $interpolateProvider.startSymbol('{$');
        $interpolateProvider.endSymbol('$}');
        cfpLoadingBarProvider.includeSpinner = false;
        $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|javascript):/);
        $locationProvider.html5Mode(true);
        $httpProvider.defaults.timeout = 10 * 1000; // 10 seconds

    }]);

app.authorizationBearer = function () {
    return 'Bearer ' +
        angular.element('input[name="__X_RVT"]').attr('value');
}

app.constant('settings', app_settings).run(['$rootScope', 'settings', '$http', function ($rootScope, settings, $http) {
    $rootScope.settings = settings;
    $http.defaults.headers.common['x-requested-with'] = 'XMLHttpRequest';
    $http.defaults.headers.common['Access-Control-Allow-Origin'] = '*';
    $http.defaults.headers.common['Authorization'] = app.authorizationBearer();

}]);

app.run(['$rootScope', function ($rootScope) {
    $rootScope.zoomImage = function (image) {
        toastr.image(image);
    };
}]);

// *********** FILTERS
app.filter('toHtml', ['$sce', function ($sce) {
    return function (text) {
        var html = $sce.trustAsHtml(text);
        return html;
    };
}]);

app.filter("trustUrl", ['$sce', function ($sce) {
    return function (recordingUrl) {
        return $sce.trustAsResourceUrl(recordingUrl);
    };
}]);

app.filter('detectMeetingService', ['$sce', function ($sce) {
    return function (text) {
        if (typeof window.detectMeetingService !== "function") {
            return "";
        }

        var url = window.detectMeetingService(text);

        var html = $sce.trustAsHtml(url);
        return html;
    };
}]);
app.filter('numberToLetter', function () {
    return function (num) {
        if (!num || isNaN(num)) return '';

        var result = '';
        while (num > 0) {
            num--; // passer à un index 0-based
            result = String.fromCharCode((num % 26) + 65) + result;
            num = Math.floor(num / 26);
        }
        return result;
    };
});

app.filter('localeDate', function () {
    return function (dateStr) {
        var userLocale = JSR.current_language_ext || navigator.language;

        if (!dateStr) {
            return '';
        }

        let date;

        // Handle format DD/MM/YYYY
        if (/^\d{2}\/\d{2}\/\d{4}$/.test(dateStr)) {
            const parts = dateStr.split('/');
            const day = parseInt(parts[0], 10);
            const month = parseInt(parts[1], 10) - 1; // JS months are 0-based
            const year = parseInt(parts[2], 10);
            date = new Date(year, month, day);
        } else {
            // Try normal parsing
            date = new Date(dateStr);
        }

        if (isNaN(date.getTime())) {
            return ".. .. ....";
        }

        return date.toLocaleDateString(userLocale, {
            year: 'numeric',
            month: 'short',
            day: '2-digit'
        });
    };
});


app.filter('formatNumber', function () {
    return function (input, decimals, currency) {
        // Vérifier si l'entrée est nulle ou indéfinie
        if (input === null || input === undefined) {
            return '';
        }

        var number = Number(input);
        if (isNaN(number)) {
            return input;
        }

        // Définir le nombre de décimales par défaut
        decimals = angular.isNumber(decimals) ? decimals : 0;

        // Options pour Intl.NumberFormat
        var options = {
            minimumFractionDigits: decimals,
            maximumFractionDigits: decimals
        };

        // Ajouter le style 'currency' si un symbole de monnaie est spécifié
        if (currency) {
            options.style = 'currency';
            options.currency = currency;
        }

        // Retourner le nombre formaté
        return new Intl.NumberFormat('fr-FR', options).format(number);
    };
});

app.filter('formatDuration', function () {
    return function (seconds) {
        if (seconds == null || seconds === '' || isNaN(seconds)) {
            return '00:00';
        }

        seconds = parseInt(seconds, 10);
        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);
        const secs = Math.floor(seconds % 60);

        if (hours > 0) {
            return hours + ':' +
                (minutes < 10 ? '0' + minutes : minutes) + ':' +
                (secs < 10 ? '0' + secs : secs);
        }
        return (minutes < 10 ? '0' + minutes : minutes) + ':' +
            (secs < 10 ? '0' + secs : secs);
    };
});

app.filter('formatFileSize', function () {
    return function (bytes) {
        if (bytes === 0 || isNaN(bytes)) return '0 Octets';

        const k = 1024;
        const sizes = ['Octets', 'Ko', 'Mo', 'Go', 'To'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));

        const size = parseFloat(Math.round(bytes / Math.pow(k, i)));
        return size + ' ' + sizes[i];
    };
});


// Filtre pour extraire l'ID YouTube
app.filter('youtubeId', function () {
    return function (url) {
        if (!url) return null;
        const regex = /(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|embed)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})/;
        const match = url.match(regex);
        return match ? match[1] : null;
    };
});

// Filtre pour générer l'URL embed YouTube
app.filter('youtubeEmbed', ['$sce', function ($sce) {
    return function (url) {
        if (!url) return null;
        const regex = /(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|embed)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})/;
        const match = url.match(regex);
        if (!match) return null;
        const videoId = match[1];
        return $sce.trustAsResourceUrl('https://www.youtube.com/embed/' + videoId);
    };
}]);

// Filtre pour générer l'URL de la miniature YouTube
app.filter('youtubeCoverId', function () {
    return function (url, quality) {
        if (!url) return null;
        const regex = /(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|embed)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})/;
        const match = url.match(regex);
        if (!match) return null;
        const videoId = match[1];
        const thumbQuality = quality || 'hqdefault';
        return 'https://img.youtube.com/vi/' + videoId + '/' + thumbQuality + '.jpg';
    };
});


// ********** DIRECTIVES
//phone
app.directive('intlTelInput', function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            if (typeof window.intlTelInput === 'function') {
                // Initialize intlTelInput
                var input = element[0];
                var iti = window.intlTelInput(input, {
                    showSelectedDialCode: true,
                    autoPlaceholder: 'aggressive',
                    initialCountry: "ma",
                    utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/21.2.4/js/utils.min.js"
                });

                // Function to update the input mask
                var setInputMask = function () {
                    iti.promise.then(function () {
                        var ph = element.attr('placeholder');
                        if (ph == null) return;

                        var currentMask = ph.replace(/[0-9+]/ig, '9');

                        var listNumber = currentMask.match(/\d/g);
                        if (listNumber == null) return;

                        var digitCount = currentMask.match(/\d/g).length;
                        var phonePattern = ".{" + digitCount + ",}";
                        element.attr('pattern', phonePattern);
                        element.inputmask(currentMask, {
                            "placeholder": "_",
                            clearIncomplete: true,
                            autoUnmask: true
                        });
                    });
                };

                // Function to validate the phone number
                var validateInputPhone = function () {
                    var isValid = iti.isValidNumber();
                    var num = isValid ? iti.getNumber() : '';
                    ngModelCtrl.$setViewValue(num);
                    ngModelCtrl.$render();
                };

                // Render function to set initial value
                ngModelCtrl.$render = function () {
                    iti.promise.then(function () {
                        setTimeout(function () {
                            var modelValue = ngModelCtrl.$modelValue || '';
                            var checkDigit = modelValue.indexOf('+') == 0;
                            iti.setNumber(modelValue);
                            var isValid = iti.isValidNumber() && modelValue;
                            if (!isValid || !checkDigit) {
                                iti.setNumber('');
                                element.val('');
                            }
                            setInputMask();
                        }, 100);

                    });

                };

                // Update input mask on country change
                element.on('countrychange', setInputMask);

                // Validate the phone number on blur
                element.on("change", validateInputPhone);
            }
        }
    };
});

app.directive('convertToNumber', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attrs, ngModel) {
            ngModel.$parsers.push(function (val) {
                return parseInt(val, 10);
            });
            ngModel.$formatters.push(function (val) {
                return '' + val;
            });
        }
    };
});

app.directive("callbackOnEnd", function () {
    return {
        restrict: "A",
        link: function (scope, element, attrs) {
            if (scope.$last) {
                eval(attrs.callbackOnEnd);
            }
        }
    };
});


// Hide if no payement
app.directive('hideIfNoPayment', ['$window', function ($window) {
    return {
        restrict: 'A', // As attribut
        link: function (scope, element, attrs) {
            // Verify if JSR and unused_days exists
            if ($window.JSR && typeof $window.JSR.unused_days !== 'undefined') {
                if ($window.JSR.unused_days === 0) {
                    element.addClass('if-no-payment'); // hide
                } else {
                    element.removeClass('if-no-payment'); // show
                }
            } else {
                console.log('JSR.unused_days undefined.');
            }
        }
    };
}]);

// HELPERS
String.prototype.format = function () {
    var result = this.toString();

    for (var i = 0; i < arguments.length; i++) {
        var strToReplace = new RegExp("\\{" + i + "\\}", "g");
        result = result.replace(strToReplace, arguments[i] !== undefined ? arguments[i] : '');
    }
    return result;
};

app.updateProperties = function (srcObj, destObj) {
    for (var key in destObj) {
        if (destObj.hasOwnProperty(key) && srcObj.hasOwnProperty(key)) {
            destObj[key] = srcObj[key];
        }
    }
}
app.generateFileName = function (t1, t2, t3, originalName) {
    try {
        const maxBaseLength = 50 ;
        const ext = originalName.split('.').pop().toLowerCase();

        // On garde une marge
        if (t1.length > maxBaseLength) {
            t1 = t1.slice(0, maxBaseLength);
        }
        if (t2.length > maxBaseLength) {
            t2 = t2.slice(0, maxBaseLength);
        }
        if (t3.length > maxBaseLength) {
            t3 = t3.slice(0, maxBaseLength);
        }

        const slugify = s => s
            .toLowerCase()
            .normalize('NFD').replace(/[\u0300-\u036f]/g, '') // enlever accents
            .replace(/[^a-z0-9]+/g, '-')                     // remplacer caractères spéciaux
            .replace(/(^-|-$)/g, '');                        // trim tirets

        const date = new Date();
        const timestamp = date.toISOString().slice(2, 19).replace(/[-:T]/g, '').slice(0, 12);
        // yyMMddHHmmss

        // Concatène les parties
        let baseName = `${slugify(t1)}-${slugify(t2)}-${slugify(t3)}`;        

        return `${baseName}-${timestamp}.${ext}`;
    } catch (ex) {
        console.log(ex);
        return originalName;
    }
}




app.removeSpace = function (string) {
    return string.replace(/\s+/g, '');
};

app.canSubmit = function (enable) {
    if (enable) {
        $(':input').removeClass('disabled').removeAttr("disabled");
    }
    else {
        $(':input').prop('disabled', true).addClass('disabled');
    }
}

app.enableControl = function (enable, id) {

    if (enable) {
        $(id).removeClass('disabled').removeAttr("disabled");
    }
    else {
        $(id).prop('disabled', true).addClass('disabled');
    }
}

app.formatBytes = function (bytes, decimals) {
    if (decimals == undefined) decimals = 2
    if (bytes === 0) return '0 Bytes';

    var k = 1024;
    var dm = decimals < 0 ? 0 : decimals;
    var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    var i = Math.floor(Math.log(bytes) / Math.log(k));

    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}

app.number_attempts = 1;
app.responseStatus = function (response) {
    var limit_timer = app_settings.login_timer_attempts;

    if (response.status != 429)
        app.canSubmit(true);


    var text_error = response?.data?.response ? response.data.response : JSR.error_occurred_retry;

    switch (response.status) {
        case 400: toastr.error(text_error, "", { timeOut: 30000 });
            break;
        case 426: toastr.error(text_error, "", { timeOut: 20000 });
            break;
        case 429:
            limit_timer = limit_timer * app.number_attempts;
            app.number_attempts++;
            toastr.info(response.data.error + "<br/>" + JSR.form_activation_at.format(limit_timer / 1000), JSR.limit_reached, { timeOut: limit_timer, disableClick: true });
            app.canSubmit(false);
            setTimeout(function () {
                toastr.info(JSR.star_your_session, JSR.form_activated);
                app.canSubmit(true);
            }, limit_timer);

            break;
        case 409: toastr.error(text_error, JSR.conflict, { timeOut: 10000 });
            break;
        case 413: toastr.error(JSR.file_size_exceeded, JSR.file_size_exceeded, { timeOut: 10000 });
            break;
        case 503: toastr.error(JSR.service_unavailable, JSR.error_occurred, { timeOut: 20000 });
            break;
        case -1: toastr.error(JSR.connection_remote_server_interrupted, JSR.error_occurred, { timeOut: 20000 });
            break;
        default:

            const errorMsg = response?.data?.response || '';

            if (typeof errorMsg === 'string' && errorMsg.includes("Data too long for column")) {
                toastr.error(JSR.error_data_too_long_for_column, JSR.error_occurred, { timeOut: 10000, toast: true });
            } else
                toastr.error(JSR.error + ' {0}'.format(response.status), JSR.error_occurred, { timeOut: 10000, toast: true });

            //console.log(response.data.response);
            break;
    }
    return response.status;
}

app.subjectColor = {
    get latest() {
        var color = window.localStorage.getItem("ls-subject-color") || 'bg-info';
        return color;
    },
    set current(color) {
        window.localStorage.setItem("ls-subject-color", color);
    }
}