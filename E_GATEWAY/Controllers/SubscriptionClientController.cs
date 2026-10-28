using Microsoft.AspNetCore.Mvc;
using E_GATEWAY.Contract;
using E_GATEWAY.Models;
using System.Threading.Tasks;
using System.Net;

namespace E_GATEWAY.Controllers
{
    [ApiController]
    [Route("api/subscription-client")]
    public class SubscriptionClientController : ControllerBase
    {
        private readonly ISubscriptionClientService _subscriptionClientService;

        public SubscriptionClientController(ISubscriptionClientService subscriptionClientService)
        {
            _subscriptionClientService = subscriptionClientService;
        }

        /// <summary>
        /// Inserts a new subscription client.
        /// </summary>
        /// <param name="model">Subscription client data</param>
        /// <returns>Result of the insertion</returns>
        [HttpPost]
        [ProducesResponseType(typeof(int), (int)HttpStatusCode.OK)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        public async Task<IActionResult> InsertClient([FromBody] SubscriptionClientDto model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                var clientId = await _subscriptionClientService.AddSubscriptionClientAsync(
                    model.FirstName,
                    model.LastName,
                    model.Email,
                    model.Phone,
                    model.Address,
                    model.PackageId,
                    model.SchoolTypeId,
                    model.PaymentCompleted,
                    model.PaymentMethod,
                    model.AmountSubscription
                );

                return Ok(new ApiResponse<int> { Success = true, Data = clientId });

            }
            catch (Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}
