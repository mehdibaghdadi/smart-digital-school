using Microsoft.AspNetCore.Mvc;
using E_GATEWAY.Contract;
using System.Net;
using System.Net.Mime;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace E_GATEWAY.Controllers
{
    [ApiController]
    [Route("api/instructor-report")]
    public class InstructorReportController : ControllerBase
    {
        private IInstructorReportService _reportService;
        private string folderReportInstructor = String.Empty;

        public InstructorReportController(IInstructorReportService reportService, IConfiguration configuration)
        {
            _reportService = reportService;
        }

        [HttpGet]
        [Route("feedback-course/{instructorId}/{dateSubmissionStart}/{dateSubmissionEnd}")]
        public async Task<string> GetFeedBackCourse(
            int instructorId, DateTime dateSubmissionStart, DateTime dateSubmissionEnd)
        {
            try
            {

                var file_output = await _reportService.GetFeedBackCourseService(
                    instructorId, dateSubmissionStart, dateSubmissionEnd);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }

        [HttpGet]
        [Route("my-students/{instructorId}/{url_fm_api}")]
        public async Task<string> GetMyStudents(
            int instructorId, string url_fm_api)
        {
            try
            {
                string decodedUrl = Uri.UnescapeDataString(url_fm_api);
                var file_output = await _reportService.GetMyStudentsService(instructorId, decodedUrl);

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }


    }
}
