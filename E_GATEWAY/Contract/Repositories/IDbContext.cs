using MySql.Data.MySqlClient;

namespace E_GATEWAY.Contract
{
    public interface IDbContext
    {
        MySqlConnection GetConnection();
        
    }
}
