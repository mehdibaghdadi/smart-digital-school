    using Microsoft.AspNetCore.Mvc;
    using E_PAYMENT.Services;

namespace E_PAYMENT.Controllers
{

    [ApiController]
    [Route("api/captcha")]
    public class CaptchaController : ControllerBase
    {
        private readonly CaptchaService _captchaService;

        public CaptchaController(CaptchaService captchaService)
        {
            _captchaService = captchaService;
        }

        /// <summary>
        /// Génère un CAPTCHA et retourne l'image et l'identifiant.
        /// </summary>
        [HttpGet("generate")]
        public async Task<IActionResult> GenerateCaptcha()
        {
            var (captchaId, captchaImage) = await _captchaService.GetCaptchaAsync();

            if (string.IsNullOrEmpty(captchaId) || captchaImage == null)
            {
                return BadRequest(new { success = false, message = "Failed to generate CAPTCHA." });
            }

            // Retourner l'image CAPTCHA et l'identifiant dans les en-têtes
            Response.Headers["Captcha-Id"] = captchaId;
            return File(captchaImage, "image/png");
        }

      
    }

}
