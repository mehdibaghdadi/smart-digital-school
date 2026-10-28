using E_SIGNALR.Contract;
using MySql.Data.MySqlClient;
using System.Data;

namespace E_SIGNALR.Repositories
{
    public class AssistanceRepository : IAssistanceRepository
    {
        readonly IDbContext _db;
        public AssistanceRepository(IDbContext db)
        {
            _db = db;
        }
        public async Task<int> UnreadAssistance(int userId, string role)
        {
            var isInstructor = (role?.ToLower() == "instructor");
            var isStudent = (role?.ToLower() == "student");


            int unreadMessagesCount = 0;

            try
            {
                if (isInstructor)
                {
                    string query = @"
                    select count(id) as nbr
                    from elearningdb.instructor_calendar_assistance_view
                    where instructor_id = @instructorId
                    and accepted is null ";

                    using (var conn = _db.GetConnection())
                    {
                        await conn.OpenAsync();
                        using (var cmd = conn.CreateCommand())
                        {
                            cmd.CommandText = query;
                            cmd.Parameters.AddWithValue("@instructorId", userId);

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

                if (isStudent)
                {
                    string query = @"
                    select count(id) as nbr
                    from elearningdb.student_instructor_calendar_assistance_view
                    where student_id = @studentId
                    and accepted =1 
                    and (
                    ( instructor_calendar_id is null and DATEDIFF(NOW(),acceptance_date)<3 )
                    or (instructor_calendar_id is not null and DATEDIFF(pl_end,NOW())>=0 )
                    )";

                    using (var conn = _db.GetConnection())
                    {
                        await conn.OpenAsync();
                        using (var cmd = conn.CreateCommand())
                        {
                            cmd.CommandText = query;
                            cmd.Parameters.AddWithValue("@studentId", userId);

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




            }
            catch (Exception)
            {
                unreadMessagesCount = 0;
            }
            return unreadMessagesCount;
        }
    }
}
