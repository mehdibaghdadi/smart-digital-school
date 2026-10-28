using E_PAYMENT.Models;
using Microsoft.AspNetCore.Mvc;


namespace E_PAYMENT.Controllers
{
    public class PaymentSuccessModel : Controller
    {       
        public IActionResult PaymentSuccess(string paymentId, string returnUrl)
        {
            var model = new PaymentSuccessViewModel
            {
                PaymentId = paymentId,
                ReturnUrl = returnUrl
            };

            return View(model);
        }
    }
}
