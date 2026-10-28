namespace E_PAYMENT.Models
{
    public class BankTransfertViewModel
    {
        public string PaymentId { get; set; }
        public string Amount { get; set; }
        public string ReturnUrl { get; set; }
        public string ReturnCancelUrl { get; set; }
        public string ShowPayment { get; set; }
        public string Status { get; set; }
        public string Token { get; set; }

        // Champs pour le CAPTCHA
        public string CaptchaId { get; set; }
        public string CaptchaImage { get; set; } // Image CAPTCHA encodée en Base64
    }
}
