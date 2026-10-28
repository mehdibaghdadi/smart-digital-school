using E_SIGNALR.Contract;
using MySql.Data.MySqlClient;
using System.Data;

namespace E_SIGNALR.Repositories
{
    public class MessageBoxRepository : IMessageBoxRepository
    {
        readonly IDbContext _db;
        public MessageBoxRepository(IDbContext db)
        {
            _db = db;
        }
        public async Task<int> UnreadMessageBox(string email)
        {
            int unreadMessagesCount = 0;

            try
            {
                string query = @"
                    select count(id) as nbr
                    from elearningdb.messages_box_inbox_view
                    where user_recipient_email = @Email
                    and is_read = 0 and to_trash = 0 ";

                using (var conn = _db.GetConnection())
                {
                    await conn.OpenAsync();
                    using (var cmd = conn.CreateCommand())
                    {
                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@Email", email);

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                unreadMessagesCount = reader.GetInt32("nbr");
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                unreadMessagesCount = 0;
            }
            return unreadMessagesCount;
        }
    }
}
