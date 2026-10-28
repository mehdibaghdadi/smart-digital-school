using System.Data;
using E_GATEWAY.Contract;

namespace E_GATEWAY.Repositories
{
    public class InstructorRepository : IInstructorRepository
    {
        readonly IDbContext _db;
        public InstructorRepository(IDbContext db)
        {
            this._db = db;
        }

        public async Task<DataTable> FeedBackCourse(int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_instructor_feedback_course`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({instructorId}, '{dateSubmissionStart.ToString("yyyy-MM-dd")}','{dateSubmissionEnd.ToString("yyyy-MM-dd 23:59:59")}');";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        } 
        public async Task<DataTable> MyStudents(int instructorId,string url_fm_api)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_instructor_my_students`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({instructorId},'{url_fm_api}',1);";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }





    }
}
