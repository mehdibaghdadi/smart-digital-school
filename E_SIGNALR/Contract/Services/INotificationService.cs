namespace E_SIGNALR.Contract.Services
{
    public interface INotificationService
    {
        Task UserDataChangeService(string email_target, string email_sender);
        //assistance 
        Task<int> GetUnreadAssistanceService(int userId, string role);

        //message box
        Task SendMessageBoxService(long messageId, int userId, string email, string fullname, string role, string destinations);
        Task ReadMessageBoxService(long messageId, int userId, string email, int userSenderId, string userSenderEmail);
        Task DeleteMessageBoxService(long messageId, int userId, string email, int userSenderId, string userSenderEmail);
        Task<int> GetUnreadMessageBoxService(string email);

    }
}
