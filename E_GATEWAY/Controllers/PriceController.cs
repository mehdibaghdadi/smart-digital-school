using Microsoft.AspNetCore.Mvc;
using E_GATEWAY.Contract;
using System.Net;
using System.Net.Mime;

namespace E_GATEWAY.Controllers
{
    [ApiController]
    [Route("api/price")]
    public class PriceController : ControllerBase
    {
        private IPriceService _reportService;
        public PriceController(IPriceService reportService, IConfiguration configuration)
        {
            _reportService = reportService;
        }

        [HttpGet]
        [Route("packages")]
        public async Task<string> GetPackages()
        {
            try
            {

                var file_output = await _reportService.GetPackagesService();

                return file_output;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }
    }
}
