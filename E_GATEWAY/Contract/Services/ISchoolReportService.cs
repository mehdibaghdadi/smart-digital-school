using System.Data;

namespace E_GATEWAY.Contract
{
    public interface ISchoolReportService
    {
        Task<string> GetInstructorCoursesService(int schoolId, int instructorId, DateTime dateStart, DateTime dateEnd);
        Task<string> GetInstructorEnrollmentCoursesService(int schoolId,int instructorId, DateTime dateStart, DateTime dateEnd);
        Task<string> GetInstructorQuizCoursesService(int schoolId,int instructorId, DateTime dateStart, DateTime dateEnd);
        Task<string> GetFeedBackCoursesService(int schoolId,int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd);
        Task<string> GetMyStudentsService(int schoolId, string url_fm_api);
        Task<string> GetMyInstructorsService(int schoolId, string url_fm_api);
        Task<string> GetSchoolSubjectsService(int schoolId);
        Task<string> GetSchoolQualificationsService(int schoolId);
        Task<string> GetCoursesAssistanceService(int schoolId, DateTime dateStart, DateTime dateEnd);

    }
}
