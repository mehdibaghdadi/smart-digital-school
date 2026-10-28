namespace E_PAYMENT.Models
{
    public class ApiResponse<T>
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public T Data { get; set; } // Données dynamiques basées sur le type générique
    }
    // Modèle pour stocker les détails de la transaction
    public class TransactionDetails
    {
        public string PaymentId { get; set; }
        public string Amount { get; set; }
        public string ReturnUrl { get; set; }
        public string ReturnCancelUrl { get; set; }
        public string ShowPayment { get; set; }
    }

    // Classe pour représenter la réponse de l'API CAPTCHA
    public class ContentResponse
    {
        public bool Success { get; set; }
        public string Message { get; set; }
    }



}
