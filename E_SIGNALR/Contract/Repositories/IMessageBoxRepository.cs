using System.Data;

namespace E_SIGNALR.Contract
{
    public interface IMessageBoxRepository
    {
        Task<int> UnreadMessageBox(string email);
    }
}
