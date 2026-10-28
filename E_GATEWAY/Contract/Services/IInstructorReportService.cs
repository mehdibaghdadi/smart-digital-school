using System.Data;

namespace E_GATEWAY.Contract
{
    public interface IInstructorReportService
    {
        Task<string> GetFeedBackCourseService(int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd);
        Task<string> GetMyStudentsService(int instructorId, string url_fm_api);
    }
}
