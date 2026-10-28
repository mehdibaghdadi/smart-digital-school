using System.Numerics;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace E_SIGNALR.Models
{
    public class MessageBoxRequest
    {
        public required long MessageId { get; set; } 
        public int UserId { get; set; } 
        public string Email { get; set; } = string.Empty;
        public string Fullname { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
        public string Destinations { get; set; } = string.Empty;
    }
    public class MessageReadDeleteRequest
    {
        public required long MessageId { get; set; } 
        public int UserId { get; set; } 
        public string Email { get; set; } = string.Empty;
         public int UserSenderId { get; set; } 
        public string UserSenderEmail { get; set; } = string.Empty;
        
    }


}
