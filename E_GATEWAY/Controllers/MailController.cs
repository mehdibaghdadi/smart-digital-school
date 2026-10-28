using Microsoft.AspNetCore.Mvc;
using E_GATEWAY.Contracts;
using E_GATEWAY.Helpers;
using E_GATEWAY.Models;
using Microsoft.Extensions.Options;

namespace E_GATEWAY.Controllers
{
    [ApiController]
    [Route("api/mail")]
    public class MailController : ControllerBase
    {
        private readonly IMailService _mail;
        private readonly MailSettings _settings;
        
        public MailController(IMailService mail, IOptions<MailSettings> settings)
        {
            _settings = settings.Value;
            _mail = mail;
        }

        [HttpPost("sendmail-form-contact")]
        public async Task<IActionResult> SendMailFormContactAsync([FromBody] Message msg)
        {
            var to = new List<string>();
            to.Add(_settings.To);

            //To SDS
            var subject = $"WEBSITE, FROM : <{msg.Email}>";
            var comment = $"FROM : {msg.Name} - {msg.Email} - <hr/>{msg.Comment}";
            MailData mailData = new MailData(to, subject, comment, msg.Email);

            return await SendMailAsync(mailData);
        }
                 

        [HttpPost("sendmail")]
        public async Task<IActionResult> SendMailAsync(MailData mailData)
        {

            bool result = await _mail.SendAsync(mailData, new CancellationToken());

            if (result)
            {
                return StatusCode(StatusCodes.Status200OK, "Mail has successfully been sent.");
            }
            else
            {
                return StatusCode(StatusCodes.Status500InternalServerError, "An error occured. The Mail could not be sent.");
            }
        }

        


    }
}
