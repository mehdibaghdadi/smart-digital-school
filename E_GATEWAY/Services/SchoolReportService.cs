using System.Data;
using E_GATEWAY.Contract;
using E_GATEWAY.Repositories;

namespace E_GATEWAY.ReportService
{
    public class SchoolReportService : ISchoolReportService
    {
        private readonly IReportHelper _reportHelper;
        private readonly ISchoolRepository _sch;

        public SchoolReportService(IReportHelper reportHelper, ISchoolRepository sch)
        {
            _reportHelper = reportHelper;
            _sch = sch;
        }

        public async Task<string> GetInstructorCoursesService(int schoolId, int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            var dataTable = await _sch.InstructorCourses(schoolId, instructorId, dateSubmissionStart, dateSubmissionEnd);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }

        public async Task<string> GetInstructorEnrollmentCoursesService(int schoolId, int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            var dataTable = await _sch.InstructorEnrollmentCourses(schoolId, instructorId, dateSubmissionStart, dateSubmissionEnd);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }

        public async Task<string> GetInstructorQuizCoursesService(int schoolId, int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            var dataTable = await _sch.InstructorQuizCourses(schoolId, instructorId, dateSubmissionStart, dateSubmissionEnd);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }



        public async Task<string> GetFeedBackCoursesService(int schoolId, int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            var dataTable = await _sch.InstructorFeedBackCourses(schoolId, instructorId, dateSubmissionStart, dateSubmissionEnd);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }

        public async Task<string> GetMyStudentsService(int schoolId,string url_fm_api)
        {
            var dataTable = await _sch.MyStudents(schoolId, url_fm_api);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }
         public async Task<string> GetMyInstructorsService(int schoolId, string url_fm_api)
        {
            var dataTable = await _sch.MyInstructors(schoolId,url_fm_api);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }
         public async Task<string> GetSchoolSubjectsService(int schoolId)
        {
            var dataTable = await _sch.SchoolSubjects(schoolId);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }
           public async Task<string> GetSchoolQualificationsService(int schoolId)
        {
            var dataTable = await _sch.SchoolQualifications(schoolId);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }

        public async Task<string> GetCoursesAssistanceService(int schoolId, DateTime dateStart, DateTime dateEnd)
        {
            var dataTable = await _sch.CoursesAssistance(schoolId, dateStart, dateEnd);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }
    }
}
