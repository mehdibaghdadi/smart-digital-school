using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Mvc;
using System.Globalization;
namespace E_PAYMENT.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LanguageController : ControllerBase
    {
        [HttpPost("SetLanguage")]
        public IActionResult SetLanguage([FromBody] LanguageRequest request)
        {
            // Vérifier si la culture est valide
            var supportedCultures = new[] { "fr", "en", "es" }; // Liste des cultures supportées
            var culture = supportedCultures.Contains(request.Culture)
                ? request.Culture
                : HttpContext.Session.GetString("Culture") ?? "fr"; // Culture par défaut

            // Enregistrer la culture dans un cookie
            Response.Cookies.Append(
                CookieRequestCultureProvider.DefaultCookieName,
                CookieRequestCultureProvider.MakeCookieValue(new RequestCulture(culture)),
                new CookieOptions { Expires = DateTimeOffset.UtcNow.AddYears(1) }
            );

            // Enregistrer la culture dans la session
            HttpContext.Session.SetString("Culture", culture);

            // Retourner une réponse JSON indiquant la culture configurée
            return Ok(new { success = true, culture });
        }
    }

    // Modèle de requête pour l'API
    public class LanguageRequest
    {
        public string Culture { get; set; } // Culture à configurer (ex: "fr" ou "en")
    }


}