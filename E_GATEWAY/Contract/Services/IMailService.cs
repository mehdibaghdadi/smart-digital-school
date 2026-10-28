using E_GATEWAY.Helpers;

namespace E_GATEWAY.Contracts
{
    public interface IMailService
    {
        Task<bool> SendAsync(MailData message, CancellationToken ct); 
    }
}
