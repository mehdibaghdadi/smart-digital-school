using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Options;
using System.Linq;
using System.Net;
using E_MEDIAHUB.Models; // Assure-toi d'inclure le namespace approprié pour AppSettings

namespace E_MEDIAHUB.Filters
{
    public class DownloadValidationFilter : IActionFilter
    {
        private readonly AppSettings _appSettings;

        public DownloadValidationFilter(IOptions<AppSettings> options)
        {
            _appSettings = options.Value;
        }

        public void OnActionExecuting(ActionExecutingContext context)
        {
            //var domain = context.HttpContext.Request.Headers["Referer"].ToString();
            //var remoteAddress = context.HttpContext.Connection.RemoteIpAddress?.ToString();
            //var acceptedDomains = _appSettings.AcceptDomains;


            //// Vérification de l'adresse distante ou du domaine
            //if (!IsDomainAccepted(domain, acceptedDomains))
            //{
            //    context.Result = new UnauthorizedResult();
            //}
        }

        public void OnActionExecuted(ActionExecutedContext context) { }

        private bool IsDomainAccepted(string domain, string[] acceptedDomains)
        {
            return !string.IsNullOrEmpty(domain) && acceptedDomains.Any(d => domain.Contains(d));
        }

        private bool IsRemoteAddressAccepted(string remoteAddress, string[] acceptedDomains)
        {
            if (string.IsNullOrEmpty(remoteAddress))
                return false;

            // Préfixer l'adresse distante avec "://"
            var formattedAddress = $"://{remoteAddress}";
            return acceptedDomains.Any(d => formattedAddress.Contains(d));
        }
    }
}
