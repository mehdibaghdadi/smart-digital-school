using System.Numerics;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace E_SIGNALR.Contract.Services
{
    public interface INotificationClient
    {
        Task OnConnected(string cn);
        Task UserDataChange(string email_target,string email_sender);
        Task ReceiveSentMessageBox(
                                long messageId,
                                int userId,
                                string email,
                                string fullname,
                                string role,
                                string destinations);
        Task ReceiveReadMessageBox(long messageId, int userId, string email, int userSenderId, string userSenderEmail);
        Task ReceiveDeletedMessageBox(long messageId, int userId, string email, int userSenderId, string userSenderEmail);
    }
}
