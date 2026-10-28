using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartDigitalSchoolApp.Helpers
{
    public static class AppConstants
    {
        public static readonly string BaseUrl =
         (string)Application.Current?.Resources["BaseUrl"];
    }
}
