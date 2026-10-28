using System.Data;

namespace E_GATEWAY.Contract
{
    public interface ISchoolRepository
    {
        Task<DataTable> InstructorCourses(int schoolId, int instructorId, DateTime dateStart, DateTime dateEnd);
        Task<DataTable> InstructorEnrollmentCourses(int schoolId,int instructorId, DateTime dateStart, DateTime dateEnd);
        Task<DataTable> InstructorQuizCourses(int schoolId,int instructorId, DateTime dateStart, DateTime dateEnd);
        Task<DataTable> InstructorFeedBackCourses(int schoolId,int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd);
        Task<DataTable> MyStudents(int schoolId, string url_fm_api);
        Task<DataTable> MyInstructors(int schoolId, string url_fm_api);
        Task<DataTable> SchoolSubjects(int schoolId);
        Task<DataTable> SchoolQualifications(int schoolId);
        Task<DataTable> CoursesAssistance(int schoolId, DateTime dateStart, DateTime dateEnd);


    }
}
