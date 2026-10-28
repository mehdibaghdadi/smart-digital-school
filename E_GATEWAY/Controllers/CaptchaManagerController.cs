using System;
using System.IO;
using Microsoft.AspNetCore.Mvc;
using SixLabors.Fonts;
using SixLabors.ImageSharp.Drawing.Processing;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using E_GATEWAY.Models;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Caching.Memory;
using MySqlX.XDevAPI;


namespace E_GATEWAY.Controllers
{

    [Route("api/captcha-manager")]
    public class CaptchaManagerController : ControllerBase
    {
        private readonly ILogger<CaptchaManagerController> _logger;

        private static Random random = new Random();

        public CaptchaManagerController(ILogger<CaptchaManagerController> logger)
        {
            _logger = logger;
        }

        // API endpoint to generate the CAPTCHA
        [HttpGet("captcha")]
        public IActionResult GenerateCaptcha([FromServices] IMemoryCache cache)
        {
            try
            {
                // Générer un nouveau CAPTCHA
                string challenge = GenerateChallenge().ToUpper();

                // Générer une clé unique pour le CAPTCHA
                string captchaId = Guid.NewGuid().ToString();

                // Stocker le CAPTCHA dans le cache avec une expiration
                cache.Set(captchaId, challenge, TimeSpan.FromMinutes(15));

                // Ajouter l'identifiant dans les en-têtes de réponse
                Response.Headers["Captcha-Id"] = captchaId;

                // Générer l'image CAPTCHA
                using (var image = GenerateImageCaptcha(challenge))
                using (var memoryStream = new MemoryStream())
                {
                    image.SaveAsPng(memoryStream);
                    return File(memoryStream.ToArray(), "image/png");
                }
            }
            catch (Exception ex)
            {
                var error = ex.Message;
                _logger.LogError("GenerateCaptcha error. CacheKey: {error}", error);

                return BadRequest(new { error = ex.Message });
            }
        }

        [HttpPost("validate-captcha")]
        public IActionResult ValidateCaptcha([FromBody] CaptchaValidationModel model, [FromServices] IMemoryCache cache)
        {
            string captchaId = model.CaptchaId; // L'identifiant envoyé par le client
            string answer = model.Answer;

            if (string.IsNullOrEmpty(captchaId) || string.IsNullOrEmpty(answer))
            {
                //return BadRequest(new { Success = false, Message = "Captcha ID : Requise / Required." });
                return BadRequest(new ApiResponse<string> { Success = false, Message = "Captcha ID : Requise / Required." });

            }

            // Récupérer le CAPTCHA à partir du cache
            if (!cache.TryGetValue(captchaId, out string storedCaptcha))
            {
                _logger.LogError("CAPTCHA expired. CacheKey: {CaptchaId}", captchaId);
                // return BadRequest(new { Success = false, Message = "CAPTCHA expiré / CAPTCHA expired." });
                return BadRequest(new ApiResponse<string> { Success = false, Message = "CAPTCHA expiré / CAPTCHA expired." });

            }

            // Comparer la réponse utilisateur
            if (string.Equals(storedCaptcha, answer, StringComparison.OrdinalIgnoreCase))
            {
                cache.Remove(captchaId); // Supprimer après validation
                //return Ok(new { Success = true, Message = "CAPTCHA Success." });
                return Ok(new ApiResponse<string> { Success = true, Message = "CAPTCHA Success." });

            }

            _logger.LogError("CAPTCHA incorrect. CacheKey: {CaptchaId}", captchaId);
            //return BadRequest(new { Success = false, Message = "CAPTCHA incorrect." });
            return BadRequest(new ApiResponse<string> { Success = false, Message = "CAPTCHA incorrect." });

        }


        //*************************** METHODES **************

        // Generate a random string for the CAPTCHA challenge
        public static string GenerateChallenge(int length = 5)
        {
            const string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            char[] challenge = new char[length];
            for (int i = 0; i < length; i++)
            {
                challenge[i] = characters[random.Next(characters.Length)];
            }
            return new string(challenge);
        }



        // Generate an image CAPTCHA
        public static Image<Rgba32> GenerateImageCaptcha(string text)
        {
            int width = 160;
            int height = 58;

            var image = new Image<Rgba32>(width, height);
            image.Mutate(ctx =>
            {
                // Fill the background
                ctx.Fill(Color.FromRgb(255, 255, 230)); // Light yellow

                // Draw random lines
                for (int i = 0; i < 5; i++)
                {
                    var startPoint = new PointF(random.Next(width), random.Next(height));
                    var endPoint = new PointF(random.Next(width), random.Next(height));
                    var color = Color.FromRgb((byte)random.Next(256), (byte)random.Next(256), (byte)random.Next(256));
                    ctx.DrawLine(color, 2, startPoint, endPoint);
                }

                // Add the text
                var font = SystemFonts.CreateFont("Liberation Sans", 42, FontStyle.Regular);
                var textColor = Color.Black;
                var textOptions = new RichTextOptions(font)
                {
                    HorizontalAlignment = HorizontalAlignment.Center,
                    VerticalAlignment = VerticalAlignment.Center,
                    Origin = new PointF(width / 2, height / 2)
                };
                ctx.DrawText(textOptions, text, textColor);
            });

            return image;
        }

    }


}
