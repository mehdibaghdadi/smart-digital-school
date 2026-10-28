using E_PAYMENT.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Resx = E_PAYMENT.Resources.Resources;


namespace E_PAYMENT.Services
{
    public class MailService
    {

        private readonly EGatewayService _eGatewayService;
        private readonly IRazorViewToStringRenderer _razorViewToStringRenderer;
        private readonly ILogger<MailService> _logger;
        private readonly AppSettings _appSettings;




        public MailService(EGatewayService eGatewayService, ILogger<MailService> logger,
            IOptions<AppSettings> appSettings, IRazorViewToStringRenderer razorViewToStringRenderer)
        {
            _eGatewayService = eGatewayService;
            _logger = logger;
            _appSettings = appSettings.Value;
            _razorViewToStringRenderer = razorViewToStringRenderer;
        }

        public async Task<bool> SendMailBankTransfert(SubscriptionRequest data)
        {
#if DEBUG
            await Task.CompletedTask; // Ajout d'un await pour respecter la signature async
            return true;
#else
            try
            {
                var to = new List<string>();
                to.Add(data.Email);
                var cc = new List<string>();
                cc.Add(_appSettings.Email);

                var subject = Resx.MailSendSubject;
                var body = await _razorViewToStringRenderer.RenderViewToStringAsync("~/Views/Mail/body-html.cshtml", data);

                var payload = new MailData(to, subject, body, cc);

                // Appeler l'API de validation de CAPTCHA via EGatewayService
                var response = await _eGatewayService.PostAsync<object, ApiResponse<ApiResponse<string>>>(
                                 _appSettings.E_GATEWAY_MAIL_URL, payload);
                var ok = response != null && response.Success;

                if(!ok)
                {
                    _logger.LogError($"Send Mail failed: {response?.Message ?? "Unknown error"}");
                }
                await Task.CompletedTask;
                return ok;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Send Mail exception");
                await Task.CompletedTask;
                return false;
            }
#endif

        }



    }
}
