using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Runtime.InteropServices;

namespace E_GATEWAY.Controllers
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
            return $"REPORT : {mode}";

        }


    }
}
