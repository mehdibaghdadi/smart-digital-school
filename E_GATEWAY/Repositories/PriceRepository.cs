using System.Data;
using E_GATEWAY.Contract;

namespace E_GATEWAY.Repositories
{
    public class PriceRepository : IPriceRepository
    {

        readonly IDbContext _db;
        public PriceRepository(IDbContext db)
        {
            this._db = db;
        }
        public async Task<DataTable> Packages()
        {
            var dataTable = new DataTable();
            var command = "select * from package";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = command;
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }
    }
}
