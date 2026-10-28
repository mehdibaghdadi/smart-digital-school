using System.Runtime.Versioning;

namespace SmartDigitalSchoolApp
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();
        }

        [SupportedOSPlatform("android26.0")]
        protected override Window CreateWindow(IActivationState? activationState)
        {
            return new Window(new MainPage());
        }
    }
}