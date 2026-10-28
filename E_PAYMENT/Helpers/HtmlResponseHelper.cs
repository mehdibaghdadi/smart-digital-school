using Microsoft.AspNetCore.Mvc;

namespace E_PAYMENT.Helpers
{
    public static class HtmlResponseHelper
    {
        public static ContentResult Response(string title, string message, string returnUrl, int statusCode)
        {
            var htmlContent = $@"
                <html>
                    <body style='text-align: center;text-transform: uppercase;'>
                        <h1>{title}</h1>
                        <p>{message}</p>
                        <p><a href='{returnUrl}'>Click here to return</a></p>
                    </body>
                </html>";
            return new ContentResult
            {
                Content = htmlContent,
                ContentType = "text/html",
                StatusCode = statusCode
            };
        }
    }
}
