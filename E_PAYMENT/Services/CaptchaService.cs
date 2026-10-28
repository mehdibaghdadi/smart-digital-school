using System;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using E_PAYMENT.Models;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace E_PAYMENT.Services
{
    public class CaptchaService
    {
        private readonly EGatewayService _eGatewayService;
        private readonly ILogger<CaptchaService> _logger;
        private readonly AppSettings _appSettings;

        public CaptchaService(EGatewayService eGatewayService, ILogger<CaptchaService> logger, IOptions<AppSettings> appSettings)
        {
            _eGatewayService = eGatewayService;
            _logger = logger;
            _appSettings = appSettings.Value;
        }

        /// <summary>
        /// Appelle l'API pour générer un CAPTCHA et retourne l'identifiant et l'image.
        /// </summary>
        public async Task<(string CaptchaId, byte[] CaptchaImage)> GetCaptchaAsync()
        {
            try
            {
                // Appeler l'API de génération de CAPTCHA via EGatewayService
                var response = await _eGatewayService.GetAsync(_appSettings.E_GATEWAY_CAPTCHA_GENERATE_URL);

                if (response != null && response.IsSuccessStatusCode)
                {
                    // Récupérer l'identifiant du CAPTCHA depuis les en-têtes
                    string captchaId = response.Headers.GetValues("Captcha-Id").FirstOrDefault();

                    // Télécharger l'image CAPTCHA
                    byte[] captchaImage = await response.Content.ReadAsByteArrayAsync();

                    return (captchaId, captchaImage);
                }
                else
                {
                    _logger.LogError($"Failed to generate CAPTCHA: {response?.ReasonPhrase ?? "No response"}");
                    return (null, null);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Exception occurred while generating CAPTCHA");
                return (null, null);
            }
        }


        /// <summary>
        /// Valide un CAPTCHA en envoyant l'identifiant et la réponse utilisateur à l'API.
        /// </summary>
        public async Task<bool> ValidateCaptchaAsync(string captchaAnswer, string captchaId)
        {
            if (string.IsNullOrEmpty(captchaAnswer))
            {
                return false;
            }

            try
            {
                var payload = new { answer = captchaAnswer, captchaId };

                // Appeler l'API de validation de CAPTCHA via EGatewayService
                var response = await _eGatewayService.PostAsync<object, ApiResponse<ApiResponse<string>>>(
                    _appSettings.E_GATEWAY_CAPTCHA_VALIDATION_URL, payload);

                if (response != null && response.Success)
                {
                    return true;
                }
                else
                {
                    _logger.LogError($"CAPTCHA validation failed: {response?.Message ?? "Unknown error"}");
                    return false;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "CAPTCHA validation exception");
                return false;
            }
        }
    }
}
