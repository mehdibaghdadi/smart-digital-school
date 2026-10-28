using Microsoft.AspNetCore.Mvc;
using E_GATEWAY.Contract;
using System.Net;
using System.Net.Mime;
using Microsoft.AspNetCore.Http.HttpResults;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace E_GATEWAY.Controllers
{
    [ApiController]
    [Route("api/school-report")]
    public class SchoolReportController : ControllerBase
    {
        private ISchoolReportService _reportService;
        private string folderReportInstructor = String.Empty;

        public SchoolReportController(ISchoolReportService reportService, IConfiguration configuration)
        {
            _reportService = reportService;
        }

        [HttpGet]
        [Route("instructor-courses/{schoolId}/{instructorId}/{dateStart}/{dateEnd}")]
        public async Task<string> GetInstructorCourses(
            int schoolId, int instructorId, DateTime dateStart, DateTime dateEnd)
        {
            try
            {

                var file_output = await _reportService.GetInstructorCoursesService(
                   schoolId, instructorId, dateStart, dateEnd);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }
        
        [HttpGet]
        [Route("instructor-enrollment-courses/{schoolId}/{instructorId}/{dateSubmissionStart}/{dateSubmissionEnd}")]
        public async Task<IActionResult> GetInstructorEnrollmentCourses(
           int schoolId, int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            try
            {

                var file_output = await _reportService.GetInstructorEnrollmentCoursesService(
                    schoolId, instructorId, dateSubmissionStart, dateSubmissionEnd);

                return Ok(file_output);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }

        [HttpGet]
        [Route("instructor-quiz-courses/{schoolId}/{instructorId}/{dateSubmissionStart}/{dateSubmissionEnd}")]
        public async Task<IActionResult> GetInstructorQuizCourses(
           int schoolId, int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            try
            {
                var file_output = await _reportService.GetInstructorQuizCoursesService(
                    schoolId, instructorId, dateSubmissionStart, dateSubmissionEnd);

                return Ok(file_output);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }


        [HttpGet]
        [Route("instructor-feedback-courses/{schoolId}/{instructorId}/{dateSubmissionStart}/{dateSubmissionEnd}")]
        public async Task<string> GetInstructorFeedBackCourses(
            int schoolId, int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            try
            {

                var file_output = await _reportService.GetFeedBackCoursesService(schoolId,
                    instructorId, dateSubmissionStart, dateSubmissionEnd);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }

        [HttpGet]
        [Route("my-students/{schoolId}/{url_fm_api}")]
        public async Task<string> GetMyStudents(int schoolId,string url_fm_api)
        {
            try
            {
                string decodedUrl = Uri.UnescapeDataString(url_fm_api);
                var file_output = await _reportService.GetMyStudentsService(schoolId, decodedUrl);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }
        
        [HttpGet]
        [Route("my-instructors/{schoolId}/{url_fm_api}")]
        public async Task<string> GetMyInstructors(int schoolId, string url_fm_api)
        {
            try
            {
                string decodedUrl = Uri.UnescapeDataString(url_fm_api);
                var file_output = await _reportService.GetMyInstructorsService(schoolId, decodedUrl);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        } 
        
        [HttpGet]
        [Route("school-subjects/{schoolId}")]
        public async Task<string> GetSchoolSubjects(int schoolId)
        {
            try
            {
                var file_output = await _reportService.GetSchoolSubjectsService(schoolId);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }
        
        [HttpGet]
        [Route("school-qualifications/{schoolId}")]
        public async Task<string> GetSchoolQualifications(int schoolId)
        {
            try
            {
                var file_output = await _reportService.GetSchoolQualificationsService(schoolId);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }

        [HttpGet]
        [Route("courses-assistance/{schoolId}/{dateStart}/{dateEnd}")]
        public async Task<string> GetCoursesAssistance(
         int schoolId,  DateTime dateStart, DateTime dateEnd)
        {
            try
            {
                var file_output = await _reportService.GetCoursesAssistanceService(schoolId, 
                    dateStart, dateEnd);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }
    }
}
