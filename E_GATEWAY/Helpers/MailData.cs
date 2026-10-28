using MailKit.Net.Smtp;
using MimeKit;
using System.ComponentModel.DataAnnotations;

namespace E_GATEWAY.Helpers
{
    public class Message
    {
        [Required(ErrorMessage = "Votre nom est requis")]
        public string? Name { get; set; }

        [Required(ErrorMessage = "Votre email est requis")]
        [EmailAddress]
        public string? Email { get; set; }

        [Required(ErrorMessage = "Votre message est requis")]
        public string? Comment { get; set; }



    }

    public class MailData
    {
        // Receiver
        public List<string> To { get; }
        public List<string> Bcc { get; }
        public List<string> Cc { get; }

        // Sender
        public string? From { get; }
        public string? DisplayName { get; }
        public string? ReplyTo { get; }
        public string? ReplyToName { get; }

        // Content
        public string Subject { get; }

        public string? Body { get; }

        public MailData(List<string> to, string subject, string? body = null, string? from = null, 
            string? displayName = null, string? replyTo = null, string? replyToName = null, 
            List<string>? bcc = null, List<string>? cc = null)
        {
            // Receiver
            To = to;
            Bcc = bcc ?? new List<string>();
            Cc = cc ?? new List<string>();

            // Sender
            From = from;
            DisplayName = displayName;
            ReplyTo = replyTo;
            ReplyToName = replyToName;

            // Content
            Subject = subject;
            Body = body;
        }
    }
}
