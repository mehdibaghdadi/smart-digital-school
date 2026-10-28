using MySql.Data.MySqlClient;

namespace E_SIGNALR.Contract
{
    public interface IDbContext
    {
        MySqlConnection GetConnection();
        
    }
}
