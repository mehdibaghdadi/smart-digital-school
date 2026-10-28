using System.Data;

namespace E_SIGNALR.Contract
{
    public interface IAssistanceRepository
    {
        Task<int> UnreadAssistance(int userId, string role  );
    }
}
