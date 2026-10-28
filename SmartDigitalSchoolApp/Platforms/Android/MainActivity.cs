using Android.App;
using Android.Content;
using Android.Content.PM;
using Android.OS;
using Android.Webkit;
using AndroidX.Core.View;
using SmartDigitalSchoolApp.Handlers;

namespace SmartDigitalSchoolApp;

[Activity(
    Theme = "@style/Maui.SplashTheme",
    MainLauncher = true,
    ConfigurationChanges = ConfigChanges.ScreenSize
        | ConfigChanges.Orientation
        | ConfigChanges.UiMode
        | ConfigChanges.ScreenLayout
        | ConfigChanges.SmallestScreenSize
        | ConfigChanges.Density
)]
public class MainActivity : MauiAppCompatActivity
{
    protected override async void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);

        // ✅ Ajustement visuel : cacher barre de navigation, etc.
        if (Window != null)
        {
            WindowCompat.SetDecorFitsSystemWindows(Window, true);
            var controller = new WindowInsetsControllerCompat(Window, Window.DecorView);
            controller.Hide(WindowInsetsCompat.Type.NavigationBars());
            controller.SystemBarsBehavior =
                WindowInsetsControllerCompat.BehaviorShowTransientBarsBySwipe;
        }

        if (Build.VERSION.SdkInt >= BuildVersionCodes.Tiramisu) // Android 13+
        {

#pragma warning disable CA1416 // Valider la compatibilité de la plateforme
            RequestPermissions(new[]
            {
                Android.Manifest.Permission.ReadMediaImages,
                Android.Manifest.Permission.ReadMediaVideo,
                Android.Manifest.Permission.ReadMediaAudio
            }, 0);
#pragma warning restore CA1416 // Valider la compatibilité de la plateforme

        }
        else if (Build.VERSION.SdkInt >= BuildVersionCodes.O)
        {
            RequestPermissions(new[]
            {
                Android.Manifest.Permission.ReadExternalStorage,
                Android.Manifest.Permission.WriteExternalStorage
            }, 0);
        }



        // ✅ Vérifie via API MAUI (facultatif mais plus propre)
        if (OperatingSystem.IsAndroidVersionAtLeast(23))
        {
            var status = await Permissions.RequestAsync<Permissions.StorageWrite>();
            if (status != PermissionStatus.Granted)
            {
                await MainThread.InvokeOnMainThreadAsync(() =>
                {
                    new AndroidX.AppCompat.App.AlertDialog.Builder(this)
                        ?.SetTitle("Permission required")
                        ?.SetMessage("Please allow storage access to save downloaded files.")
                        ?.SetPositiveButton("OK", (sender, args) => { })
                        ?.Show();
                });
            }
        }
    }

    // ✅ Nécessaire pour WebView file chooser (upload)
    protected override void OnActivityResult(int requestCode, Result resultCode, Intent? data)
    {
        base.OnActivityResult(requestCode, resultCode, data);

        if (requestCode == 1000)
        {
            if (CustomWebViewHandler.PendingFilePathCallback != null)
            {
                var result = WebChromeClient.FileChooserParams.ParseResult((int)resultCode, data);
                CustomWebViewHandler.PendingFilePathCallback.OnReceiveValue(result);
                CustomWebViewHandler.PendingFilePathCallback = null;
            }
        }
    }
}
