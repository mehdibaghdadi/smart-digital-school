using System.Data;
using System.Threading.Tasks;
using E_GATEWAY.Contract;

namespace E_GATEWAY.Repositories
{
    public class SubscriptionClientRepository : ISubscriptionClientRepository
    {
        private readonly IDbContext _dbContext;

        public SubscriptionClientRepository(IDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<int> InsertClientAsync(
            string firstName,
            string lastName,
            string email,
            string phone,
            string address,
            int packageId,
            int schoolTypeId,
            bool paymentCompleted,
            string paymentMethod,
            decimal amountSubscription)
        {
            var commandText = "CALL `insert_subscription_client`";

            using (var conn = _dbContext.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    // Format the SQL command to call the stored procedure
                    cmd.CommandText = $"{commandText}('{firstName}', '{lastName}', '{email}', '{phone}', '{address}', {packageId}, {schoolTypeId}, {paymentCompleted}, '{paymentMethod}', {amountSubscription});";

                    // Execute the command and return the inserted ID
                    var result = await cmd.ExecuteScalarAsync();
                    return Convert.ToInt32(result);
                }
            }
        }
    }
}
