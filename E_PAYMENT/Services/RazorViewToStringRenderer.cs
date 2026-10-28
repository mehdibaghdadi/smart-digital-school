using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Razor;
namespace E_PAYMENT.Services
{

    public interface IRazorViewToStringRenderer
    {
        Task<string> RenderViewToStringAsync(string viewPath, object model);
    }

    public class RazorViewToStringRenderer : IRazorViewToStringRenderer
    {
        private readonly IRazorViewEngine _razorViewEngine;
        private readonly IServiceProvider _serviceProvider;
        private readonly ITempDataProvider _tempDataProvider;

        public RazorViewToStringRenderer(IRazorViewEngine razorViewEngine, ITempDataProvider tempDataProvider, IServiceProvider serviceProvider)
        {
            _razorViewEngine = razorViewEngine;
            _tempDataProvider = tempDataProvider;
            _serviceProvider = serviceProvider;
        }

        public async Task<string> RenderViewToStringAsync(string viewPath, object model)
        {
            var actionContext = new ActionContext(
                new Microsoft.AspNetCore.Http.DefaultHttpContext { RequestServices = _serviceProvider },
                new Microsoft.AspNetCore.Routing.RouteData(),
                new Microsoft.AspNetCore.Mvc.Abstractions.ActionDescriptor());

            var viewResult = _razorViewEngine.GetView("", viewPath, false);

            if (!viewResult.Success)
            {
                throw new FileNotFoundException("Vue introuvable : " + viewPath);
            }

            var view = viewResult.View;

            using var sw = new StringWriter();
            var viewData = new ViewDataDictionary(new EmptyModelMetadataProvider(), new ModelStateDictionary())
            {
                Model = model
            };
            var tempData = new TempDataDictionary(actionContext.HttpContext, _tempDataProvider);

            var viewContext = new ViewContext(actionContext, view, viewData, tempData, sw, new HtmlHelperOptions());

            await view.RenderAsync(viewContext);
            return sw.ToString();
        }
    }

}
