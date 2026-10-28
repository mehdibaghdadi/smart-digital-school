
namespace E_PAYMENT.Models
{ 
    public class MailData
    {
        // Receiver
        public List<string> To { get; }
        public List<string> Cc { get; }

        // Sender
        public string? From { get; }
        // Content
        public string Subject { get; }
        public string? Body { get; }
        public MailData() { 
        }
        public MailData(List<string> to, string subject, string? body = null, List<string>? cc = null)
        {
            // Receiver
            To = to;     
            // Content
            Subject = subject;
            Body = body;
            Cc = cc ?? new List<string>();
        }
    }
}
