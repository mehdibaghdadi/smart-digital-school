using MySql.Data.MySqlClient;
using E_GATEWAY.Contract;

namespace E_GATEWAY.Repositories
{
    public class DbContext: IDbContext
    {
        private readonly IConfiguration _configuration;
        private readonly string? _connectionString;

        public DbContext(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("elearningdb");
        }
       
        public MySqlConnection GetConnection()
        {
            return new MySqlConnection(_connectionString);
        }
    }
}
