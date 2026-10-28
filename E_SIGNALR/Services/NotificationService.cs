using E_SIGNALR.Contract;
using E_SIGNALR.Contract.Services;
using E_SIGNALR.Helpers;
using E_SIGNALR.Hubs;
using Microsoft.AspNetCore.SignalR;
using System.Data;
namespace E_SIGNALR.Services
{

    public class NotificationService: INotificationService
    {
        private readonly IHubContext<NotificationHub, INotificationClient> _context;
        private readonly IReportHelper _reportHelper;
        private readonly IMessageBoxRepository _msg;
        private readonly IAssistanceRepository _asst;
        public NotificationService(IHubContext<NotificationHub, INotificationClient> context, 
                                    IReportHelper reportHelper, IMessageBoxRepository msg,IAssistanceRepository asst)
        {
            _context = context;
            _reportHelper = reportHelper;
            _msg = msg;
            _asst = asst;
        }

        public async Task UserDataChangeService(string email_target, string email_sender)
        {
            await _context.Clients.All.UserDataChange( email_target,  email_sender);

        }

        //--------------assistance

        public async Task<int> GetUnreadAssistanceService(int userId, string role)
        {
            return await _asst.UnreadAssistance( userId,role);
        }

        // ----------- message box
        public async Task SendMessageBoxService(long messageId,int userId,string email,string fullname,string role,string destinations)
        {
            await _context.Clients.All.ReceiveSentMessageBox(messageId, userId, email, fullname, role, destinations);

        }
        public async Task ReadMessageBoxService(long messageId, int userId, string email, int userSenderId, string userSenderEmail)
        {
            await _context.Clients.All.ReceiveReadMessageBox(messageId, userId, email, userSenderId, userSenderEmail);
        }
        public async Task DeleteMessageBoxService(long messageId, int userId, string email, int userSenderId, string userSenderEmail)
        {
            await _context.Clients.All.ReceiveDeletedMessageBox(messageId, userId, email, userSenderId, userSenderEmail);
        }

        public async Task<int> GetUnreadMessageBoxService(string email)
        {
            return await _msg.UnreadMessageBox(email);
        }

        
    }

}
