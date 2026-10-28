using Microsoft.AspNetCore.Mvc;
using E_SIGNALR.Models;
using E_SIGNALR.Contract.Services;

namespace E_SIGNALR.Controllers
{
    [Route("notification")]
    public class NotificationController : ControllerBase
    {
        INotificationService _context;
        public NotificationController(INotificationService context)
        {
            _context = context;
        }

        //----------------------# Notify users
        [HttpPost]
        [Route("user-data-change/{email_target}/{email_sender}")]
        public async Task<IResult> UserDataChange(string email_target, string email_sender)
        {
            await _context.UserDataChangeService( email_target, email_sender);
            return Results.NoContent();
        }


        //----------------------# Notify Assistance users

        [HttpGet]
        [Route("unread-assistance-count/{userId}/{role}")]
        public async Task<int> GetUnreadAssistanceBox(int userId,string role)
        {
            var nbr_unread = await _context.GetUnreadAssistanceService(userId,role).ConfigureAwait(false);
            return nbr_unread;
        }

        //----------------------# Notify MessageBox users

        [HttpPost]
        [Route("send-message-box")]
        public async Task<IResult> SendMessageBox([FromBody] MessageBoxRequest request)
        {
            await _context.SendMessageBoxService(
                                        request.MessageId,
                                        request.UserId,
                                        request.Email,
                                        request.Fullname,
                                        request.Role,
                                        request.Destinations);
            return Results.NoContent();
        }

        [HttpPost]
        [Route("read-message-box")]
        public async Task<IResult> ReadMessageBox([FromBody] MessageReadDeleteRequest request)
        {
            await _context.ReadMessageBoxService(request.MessageId,
                                        request.UserId,
                                        request.Email,
                                        request.UserSenderId,
                                        request.UserSenderEmail);


            return Results.NoContent();
        }

        [HttpPost]
        [Route("delete-message-box")]
        public async Task<IResult> DeleteMessageBox([FromBody] MessageReadDeleteRequest request)
        {
            await _context.DeleteMessageBoxService(request.MessageId,
                                        request.UserId,
                                        request.Email,
                                        request.UserSenderId,
                                        request.UserSenderEmail);


            return Results.NoContent();
        }

        [HttpGet]
        [Route("unread-message-box-count/{email}")]
        public async Task<int> GetUnreadMessageBox(string email)
        {
            var nbr_unread = await _context.GetUnreadMessageBoxService(email).ConfigureAwait(false);
            return nbr_unread;
        }



    }
}
