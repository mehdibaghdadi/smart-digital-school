using System.Data;
using E_GATEWAY.Contract;

namespace E_GATEWAY.Repositories
{
    public class SchoolRepository : ISchoolRepository
    {
        readonly IDbContext _db;
        public SchoolRepository(IDbContext db)
        {
            this._db = db;
        }

        public async Task<DataTable> InstructorCourses(int schoolId, int instructorId, DateTime dateStart, DateTime dateEnd)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_instructor_courses`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId},{instructorId}, '{dateStart.ToString("yyyy-MM-dd")}','{dateEnd.ToString("yyyy-MM-dd 23:59:59")}');";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }

        public async Task<DataTable> InstructorEnrollmentCourses(int schoolId, int instructorId, DateTime dateStart, DateTime dateEnd)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_instructor_enrollment_courses`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId},{instructorId}, '{dateStart.ToString("yyyy-MM-dd")}','{dateEnd.ToString("yyyy-MM-dd 23:59:59")}');";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }

        public async Task<DataTable> InstructorQuizCourses(int schoolId, int instructorId, DateTime dateStart, DateTime dateEnd)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_instructor_quiz_courses`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId},{instructorId}, '{dateStart.ToString("yyyy-MM-dd")}','{dateEnd.ToString("yyyy-MM-dd 23:59:59")}');";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }



        public async Task<DataTable> InstructorFeedBackCourses(int schoolId, int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_school_instructor_feedback_course`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId},{instructorId}, '{dateSubmissionStart.ToString("yyyy-MM-dd")}','{dateSubmissionEnd.ToString("yyyy-MM-dd 23:59:59")}');";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }

        public async Task<DataTable> MyStudents(int schoolId,string url_fm_api)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_school_my_students`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId},'{url_fm_api}');";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }

        public async Task<DataTable> MyInstructors(int schoolId, string url_fm_api)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_school_my_instructors`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId},'{url_fm_api}');";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }
        public async Task<DataTable> SchoolSubjects(int schoolId)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_school_subjects`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId});";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }
        
        public async Task<DataTable> SchoolQualifications(int schoolId)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_school_qualifications`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId});";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }
         public async Task<DataTable> CoursesAssistance(int schoolId, DateTime dateStart, DateTime dateEnd)
        {
            var dataTable = new DataTable();
            var command = "CALL `rpt_school_courses_assistance`";

            using (var conn = _db.GetConnection())
            {
                await conn.OpenAsync();
                using (var cmd = conn.CreateCommand())
                {
                    cmd.CommandText = $"{command}({schoolId},'{dateStart.ToString("yyyy-MM-dd")}','{dateEnd.ToString("yyyy-MM-dd 23:59:59")}');";
                    using (var read = await cmd.ExecuteReaderAsync())
                        dataTable.Load(read);
                }
            }
            return dataTable;
        }


    }
}
