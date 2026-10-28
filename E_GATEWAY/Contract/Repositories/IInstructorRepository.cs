using System.Data;

namespace E_GATEWAY.Contract
{
    public interface IInstructorRepository
    {
        Task<DataTable> FeedBackCourse(int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd);
        Task<DataTable> MyStudents(int instructorId, string url_fm_api);
    }
}
