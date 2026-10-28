// Fonction pour charger le CAPTCHA
var attempt = 1;
function loadCaptcha(url) {
    const captchaImage = document.getElementById('captcha-image');
    const loadingSpinner = document.getElementById('captcha-loading');
    const captchaIdInput = document.getElementById('captcha-id'); // Champ caché pour stocker l'ID CAPTCHA

    // Afficher le spinner pendant le chargement
    loadingSpinner.style.display = 'block';
    captchaImage.style.display = 'none';

    // Appeler l'API pour générer un CAPTCHA
    fetch(url)
        .then(response => {
            // Vérifier si l'API retourne un ID CAPTCHA dans les en-têtes
            const captchaId = response.headers.get('Captcha-Id');
            if (captchaId) {
                captchaIdInput.value = captchaId; // Stocker l'ID dans un champ caché
            } else {
                console.error('Captcha-Id manquant dans les en-têtes.');
                throw new Error('Captcha-Id manquant dans les en-têtes.');
            }
            return response.blob(); // Continuer pour récupérer l'image
        })
        .then(blob => {
            const imageUrl = URL.createObjectURL(blob);
            captchaImage.src = imageUrl;

            // Afficher l'image et cacher le spinner
            captchaImage.style.display = 'block';
            loadingSpinner.style.display = 'none';
        })
        .catch(error => {
            console.error('Erreur lors du chargement du CAPTCHA:', error);
            if (attempt <= 7) {
                attempt++;
                setTimeout(function () {
                    loadCaptcha(url);
                }, 1000)
                return;
            }
            console.error('Erreur : Impossible de charger le CAPTCHA.');
        });
}



$(function () {

    // Ajouter un écouteur au bouton pour régénérer le CAPTCHA
    document.getElementById('reload-captcha-button').addEventListener('click', function () {
        loadCaptcha(_global.captcha_url);
    });

    loadCaptcha(_global.captcha_url);


    // amount format
    $('.amount').each(function () {
        const rawValue = parseInt($(this).data('raw'), 10);
        $(this).text(rawValue.toLocaleString('fr-FR') + " DH");
    });


    const checkbox = document.getElementById('agreeTerms');
    const button = document.getElementById('subscribeButton');
    button.disabled = !checkbox.checked;

    // Écouter les changements de la case à cocher
    checkbox.addEventListener('change', function () {
        button.disabled = !checkbox.checked;
    });

 });