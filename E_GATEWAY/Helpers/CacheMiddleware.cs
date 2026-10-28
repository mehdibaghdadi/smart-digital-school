    using Microsoft.AspNetCore.Http;
    using Microsoft.Net.Http.Headers;
    using System;
    using System.Threading.Tasks;
namespace E_GATEWAY.Helpers
{
    public class CacheMiddleware
    {
        private readonly RequestDelegate _next;

        public CacheMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {           
            // Set the Cache-Control header to make the response public and cacheable for 20 seconds
            context.Response.GetTypedHeaders().CacheControl =
                new CacheControlHeaderValue()
                {
                    Public = true,
                    MaxAge = TimeSpan.FromSeconds(20),
                };

            // Add the Vary header to indicate that the response varies by the Accept-Encoding header
            context.Response.Headers[HeaderNames.Vary] = new string[] { "Accept-Encoding" };

            // Call the next middleware in the pipeline
            await _next(context);
        }
    }


}
