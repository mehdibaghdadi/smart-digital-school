using System.Data;
using E_GATEWAY.Contract;
using E_GATEWAY.Repositories;

namespace E_GATEWAY.ReportService
{
    public class InstructorReportService : IInstructorReportService
    {
        private readonly IReportHelper _reportHelper;
        private readonly IInstructorRepository _prof;

        public InstructorReportService(IReportHelper reportHelper, IInstructorRepository prof)
        {
            _reportHelper = reportHelper;
            _prof = prof;
        }

        public async Task<string> GetFeedBackCourseService(int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            var dataTable = await _prof.FeedBackCourse(instructorId, dateSubmissionStart, dateSubmissionEnd);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }
        public async Task<string> GetMyStudentsService(int instructorId, string url_fm_api)
        {
            var dataTable = await _prof.MyStudents(instructorId,url_fm_api);

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }


    }
}
