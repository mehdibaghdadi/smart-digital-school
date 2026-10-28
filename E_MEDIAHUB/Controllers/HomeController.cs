using Microsoft.AspNetCore.Mvc;

namespace E_MEDIAHUB.Controllers
{
    public class HomeController : Controller
    {
        // GET: HomeController

        public string Index()
        {
            string mode = "";
#if DEBUG
            mode = ("Mode=Debug");
#else
            mode = ("Mode=Release");
#endif
            return $"MEDIA HUB : {mode}";

        }


    }
}
