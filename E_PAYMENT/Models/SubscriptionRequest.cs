namespace E_PAYMENT.Models
{
    public class SubscriptionRequest
    {
        public string Token { get; set; }
        public string Amount { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public string ReturnCancelUrl { get; set; }
        public string CaptchaAnswer { get; set; }
        public string CaptchaId { get; set; }
    }

}
