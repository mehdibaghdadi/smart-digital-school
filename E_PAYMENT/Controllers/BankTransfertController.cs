using Microsoft.AspNetCore.Mvc;
using E_PAYMENT.Models;
using Newtonsoft.Json;
using System.Transactions;
using Microsoft.Extensions.Options;
using E_PAYMENT.Helpers;
using E_PAYMENT.Services;
namespace E_PAYMENT.Controllers
{
    public class BankTransfertController : Controller
    {
        private readonly EGatewayService _eGatewayService;
        private readonly ILogger<BankTransfertController> _logger;
        private readonly AppSettings _appSettings;
        private readonly CaptchaService _captchaService;
        private readonly MailService _mailService;

        public BankTransfertController(EGatewayService eGatewayService, 
            ILogger<BankTransfertController> logger, 
            IOptions<AppSettings> appSettings, 
            CaptchaService captchaService,
            MailService mailService
            )
        {

            _logger = logger;
            _appSettings = appSettings.Value;
            _captchaService = captchaService;
            _eGatewayService = eGatewayService;
            _mailService = mailService;
        }


        // Création d'un paiement et génération d'un jeton
        public IActionResult Index(string paymentId, string amount, string returnUrl, 
            string returnCancelUrl,string showPayment="")
        {
            // Valider les paramètres obligatoires
            if (string.IsNullOrEmpty(amount))
            {
                return BadRequest("Missing or invalid parameters.");
            }
            TempData["Status"] = null;

            // Générer un jeton unique pour la transaction
            var transactionId = Guid.NewGuid().ToString();

            // Stocker les informations de la transaction dans la session
            HttpContext.Session.SetString(transactionId, JsonConvert.SerializeObject(new
            {
                PaymentId = paymentId,
                Amount = amount,
                ReturnUrl = returnUrl,
                ReturnCancelUrl = returnCancelUrl,
                ShowPayment= showPayment
            }));

            // Rediriger vers l'action Index avec le jeton
            return RedirectToAction("MakePayment", new { transactionId });
        }

        // Page principale du paiement
        public  IActionResult MakePayment(string transactionId)
        {
            var transactionDetailsJson = HttpContext.Session.GetString(transactionId);
            if (string.IsNullOrEmpty(transactionDetailsJson))
            {
                return  HtmlResponseHelper.Response(
                                                       "Invalid or expired session",
                                                       "Your session has expired or is invalid.",
                                                       _appSettings.ReturnUrl,
                                                       400);
            }

            var transactionDetails = JsonConvert.DeserializeObject<TransactionDetails>(transactionDetailsJson);

            var model = new BankTransfertViewModel
            {
                PaymentId = transactionDetails?.PaymentId,
                Amount = transactionDetails.Amount,
                ReturnUrl = transactionDetails.ReturnUrl,
                ReturnCancelUrl = transactionDetails.ReturnCancelUrl,
                ShowPayment = transactionDetails.ShowPayment,
                Token = transactionId,
                Status = TempData["Status"]?.ToString()
            };

            TempData["Status"] = null;
            return  View("Index", model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ProcessSubscription([FromForm] SubscriptionRequest request)
        {
            // Récupérer les détails de la transaction depuis la session
            var transactionDetailsJson = HttpContext.Session.GetString(request.Token);
            if (string.IsNullOrEmpty(transactionDetailsJson))
            {
                return HtmlResponseHelper.Response(
                    "Invalid or expired session",
                    "Your session has expired or is invalid.",
                    request.ReturnCancelUrl,
                    400);
            }

            var transactionDetails = JsonConvert.DeserializeObject<TransactionDetails>(transactionDetailsJson);

            // Valider le CAPTCHA avec le service dédié
            if (!await _captchaService.ValidateCaptchaAsync(request.CaptchaAnswer, request.CaptchaId))
            {
                TempData["Status"] = "Subscription Failed. Invalid CAPTCHA.";
                TempData["PaymentId"] = transactionDetails.PaymentId;

                return RedirectToAction("MakePayment", new { transactionId = request.Token });
            }

            // Vérifier les informations utilisateur
            if (IsValidInfos(request.FirstName, request.LastName, request.Email, request.Phone, request.CaptchaAnswer))
            {
                // Préparer les données pour l'API
                var subscriptionClient = new
                {
                    FirstName = request.FirstName,
                    LastName = request.LastName,
                    Email = request.Email,
                    Phone = request.Phone,
                    Address = request.Address,
                    PackageId = 2, // Exemple, à remplacer par une logique réelle
                    SchoolTypeId = 11, // Freelance
                    PaymentCompleted = false,
                    PaymentMethod = "bank_transfer",
                    AmountSubscription = decimal.Parse(request.Amount)
                };

                // Appeler l'API `egateway` via le service généralisé
                var response = await _eGatewayService.PostAsync<object, ApiResponse<int>>(
                    _appSettings.E_GATEWAY_SUBSCRIBE_URL, subscriptionClient);

                if (response != null && response.Success)
                {
                    TempData["Status"] = "Subscription Success!";
                    TempData["PaymentId"] = transactionDetails.PaymentId;

                    var mailOk = await _mailService.SendMailBankTransfert(request);
                    if (!mailOk)
                    {
                        TempData["Status"] = "Mail failed!";

                    }

                    // Supprimer les données de la session après succès
                    HttpContext.Session.Remove(request.Token);

                    //return Redirect(transactionDetails.ReturnUrl);
                    return View("PaymentSuccess", new PaymentSuccessViewModel
                    {
                        ReturnUrl = transactionDetails.ReturnUrl ?? "#",
                        PaymentId = transactionDetails.PaymentId ?? "N/A"
                    });
                }
                else
                {
                    TempData["Status"] = $"Subscription Failed. API returned: {response?.Message ?? "Unknown error"}";
                    TempData["PaymentId"] = transactionDetails.PaymentId;

                    return RedirectToAction("MakePayment", new { transactionId = request.Token });
                }
            }
            else
            {
                TempData["Status"] = "Subscription Failed. Invalid information.";
                TempData["PaymentId"] = transactionDetails.PaymentId;

                return RedirectToAction("MakePayment", new { transactionId = request.Token });
            }
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Cancel(string token, string returnCancelUrl)
        {
            var transactionDetailsJson = HttpContext.Session.GetString(token);
            if (string.IsNullOrEmpty(transactionDetailsJson))
            {
                return Redirect(returnCancelUrl);
            }

            var transactionDetails = JsonConvert.DeserializeObject<TransactionDetails>(transactionDetailsJson);

            // Supprimer les données de la session après annulation
            HttpContext.Session.Remove(token);

            return !string.IsNullOrEmpty(transactionDetails.ReturnCancelUrl)
                ? Redirect(transactionDetails.ReturnCancelUrl)
                : View("Index", new BankTransfertViewModel
                {
                    PaymentId = transactionDetails.PaymentId,
                    Status = "Subscription was cancelled."
                });
        }



        //*************************** METHODES **************

        // Méthode privée pour valider les informations du formulaire
        private bool IsValidInfos(string firstName, string lastName, string email, string phone, string captcha_answer)
        {
            // Validation simple (vous pouvez étendre cette logique)
            return !string.IsNullOrWhiteSpace(firstName) &&
                   !string.IsNullOrWhiteSpace(lastName) &&
                   !string.IsNullOrWhiteSpace(email) &&
                   !string.IsNullOrWhiteSpace(phone) &&
                   !string.IsNullOrWhiteSpace(captcha_answer);
        }

    }



}
