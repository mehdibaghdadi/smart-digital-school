using Microsoft.Maui.Handlers;
using Microsoft.Maui.Dispatching;
using SmartDigitalSchoolApp.Helpers;
using System.Diagnostics;

#if ANDROID
using Android.Content;
using Android.App;

using Android.Widget;
using Java.Interop;
using Android.Webkit;
using Application = Android.App.Application;
using WebView = Android.Webkit.WebView;
#endif    

namespace SmartDigitalSchoolApp.Handlers
{
    public static class CustomWebViewHandler
    {

#if ANDROID
        public static Android.Webkit.IValueCallback? PendingFilePathCallback { get; set; }

        // SmartWebViewClient déclenche l'overlay pour toutes les WebView
        public class SmartWebViewClient : WebViewClient
        {
            private readonly WebView _webView;
            private readonly Action _onPageStarted;
            private readonly Action _onPageFinished;

            public SmartWebViewClient(WebView webView, Action onPageStarted, Action onPageFinished)
            {
                _webView = webView;
                _onPageStarted = onPageStarted;
                _onPageFinished = onPageFinished;
            }

            public override void OnPageStarted(WebView view, string url, Android.Graphics.Bitmap favicon)
            {
                base.OnPageStarted(view, url, favicon);
                if (WebViewHistory.History.Count == 0 || WebViewHistory.History.Peek() != url)
                    WebViewHistory.History.Push(url);
                _onPageStarted?.Invoke();
            }

            public override void OnPageFinished(WebView view, string url)
            {
                base.OnPageFinished(view, url);
                _onPageFinished?.Invoke();
            }

            public override bool ShouldOverrideUrlLoading(WebView? view, IWebResourceRequest? request)
            {
                var url = request?.Url?.ToString();
                if (string.IsNullOrEmpty(url)) return false;

                if (!url.Contains(AppConstants.BaseUrl))
                {
                    OpenExternalUrl(url);
                    return true; // handled
                }


                // Pour les URL internes, on laisse Android gérer la navigation
                return false; // NOT handled => WebView mettra à jour CanGoBack
            }

            private static void OpenExternalUrl(string url)
            {
                try
                {
                    var intent = new Android.Content.Intent(Android.Content.Intent.ActionView, Android.Net.Uri.Parse(url));
                    intent.AddFlags(Android.Content.ActivityFlags.NewTask);
                    Application.Context.StartActivity(intent);
                }
                catch { }
            }



            public override void OnReceivedSslError(Android.Webkit.WebView? view,
                Android.Webkit.SslErrorHandler handler, Android.Net.Http.SslError error)
            {
#if DEBUG
                // ⚠️ En développement : ignorer les erreurs SSL pour localhost (auto-signé)
                handler.Proceed();
#else
                // 🚫 En production : bloquer pour éviter les failles de sécurité
                handler.Cancel();
#endif
            }



        }
        //  Gestion des popups et upload de fichiers ---
        public class CustomChromeClient : WebChromeClient
        {
            private readonly WebView _parent;
            private readonly Action _onPageStarted;
            private readonly Action _onPageFinished;

            public CustomChromeClient(WebView parent, Action onPageStarted, Action onPageFinished)
            {
                _parent = parent;
                _onPageStarted = onPageStarted;
                _onPageFinished = onPageFinished;
            }

            // ✅ Intercepte window.open('_blank')
            public override bool OnCreateWindow(WebView? view, bool isDialog, bool isUserGesture, Android.OS.Message? resultMsg)
            {
                try
                {
                    var transport = resultMsg?.Obj as WebView.WebViewTransport;
                    if (transport == null)
                        return false;

                    // 👉 On redirige vers la WebView principale (pas de popup)
                    transport.WebView = _parent;
                    resultMsg?.SendToTarget();

                    return true;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"[CustomChromeClient] OnCreateWindow error: {ex.Message}");
                    return false;
                }
            }

            // ✅ Gestion de l'upload de fichiers (input type="file")
            public override bool OnShowFileChooser(
                Android.Webkit.WebView? webView,
                Android.Webkit.IValueCallback? filePathCallback,
                WebChromeClient.FileChooserParams? fileChooserParams)
            {
                try
                {
                    var activity = Platform.CurrentActivity ?? throw new InvalidOperationException("No current activity");

                    var intent = fileChooserParams?.CreateIntent();
                    activity.StartActivityForResult(intent, 1000);

                    // Garde le callback pour plus tard (résultat)
                    CustomWebViewHandler.PendingFilePathCallback = filePathCallback;

                    return true;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"[OnShowFileChooser] Erreur : {ex.Message}");
                    return false;
                }
            }
            public override void OnCloseWindow(WebView? window)
            {
                try { window?.Destroy(); window?.Dispose(); } catch { }
            }
        }

        //  Communication depuis le JavaScript ---
        public class JsBridge : Java.Lang.Object
        {
            private readonly WebView _webView;

            public JsBridge(WebView webView)
            {
                _webView = webView;
            }

            [JavascriptInterface]
            [Export("postMessage")]
            public void PostMessage(string message)
            {
                try
                {
                    MainThread.BeginInvokeOnMainThread(() =>
                    {
                        // Appeler une méthode statique ou un singleton
                        MainPage.Instance?.OnJsMessageReceived(message);
                    });
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"[JsBridge] Error: {ex.Message}");
                }
            }
        }

        // Recevoir les blobs (fichiers) depuis le JavaScript ---
        class SmartDownloader : Java.Lang.Object, IDownloadListener
        {
            private readonly Context? _context;
            private readonly WebView _webView;

            public SmartDownloader(Context? context, WebView webView)
            {
                _context = context;
                _webView = webView;
            }

            public void OnDownloadStart(string? url, string? userAgent, string? contentDisposition, string? mimetype, long contentLength)
            {
                try
                {
                    string fileName = URLUtil.GuessFileName(url, contentDisposition, mimetype) ?? "download.bin";

                    if (url !=null && url.StartsWith("blob:"))
                    {
                        // 🔹 Appelle la fonction JS avec les bons paramètres
                        string jsCall = $"downloadBlob('{url}', '{fileName}')";
                        _webView.EvaluateJavascript(jsCall, null);

                        return;
                    }

                    DownloadManager.Request request = new DownloadManager.Request(Android.Net.Uri.Parse(url));
                    request.SetMimeType(mimetype);

                    // Extraire le nom du fichier
                     request.AddRequestHeader("cookie", CookieManager.Instance?.GetCookie(url));
                    
                    request.AddRequestHeader("User-Agent", userAgent);
                    request.SetDescription("Download file ...");
                    request.SetTitle(fileName);
                    request.SetNotificationVisibility(DownloadVisibility.VisibleNotifyCompleted);
                    request.SetDestinationInExternalPublicDir(Android.OS.Environment.DirectoryDownloads, fileName);

                    // Respecter la dépréciation à partir d'Android 29
                    if (Android.OS.Build.VERSION.SdkInt < Android.OS.BuildVersionCodes.Q)
                    {
#pragma warning disable CA1422 // Valider la compatibilité de la plateforme
                        request.AllowScanningByMediaScanner();
#pragma warning restore CA1422 // Valider la compatibilité de la plateforme
                    }

                    DownloadManager? dm = _context?.GetSystemService(Context.DownloadService) as DownloadManager;
                    dm?.Enqueue(request);

                    Toast.MakeText(_context, "📥 Download complete : " + fileName, ToastLength.Short)?.Show();
                }
                catch (Exception ex)
                {
                    Toast.MakeText(_context, ex.Message, ToastLength.Long)?.Show();
                }
            }
        }

        // Stocke l'historique de navigation (pour gérer le bouton "Retour")
        public static class WebViewHistory
        {
            public static Stack<string> History = new();
        }


        // Injecter le client dans toutes les WebView MAUI
        public static void Register()
        {
            Microsoft.Maui.Handlers.WebViewHandler.Mapper.AppendToMapping("CustomHandler", (handler, view) =>
            {
                if (handler.PlatformView != null)
                {
                    var settings = handler.PlatformView.Settings;
                    settings.JavaScriptEnabled = true;
                    settings.DomStorageEnabled = true;
                    settings.AllowFileAccess = true;
                    settings.AllowFileAccessFromFileURLs = true;
                    settings.AllowUniversalAccessFromFileURLs = true;

                    // ✅ Étape 3: C'est la ligne la plus importante !
                    // Elle autorise la WebView à gérer plusieurs fenêtres (popups, target="_blank").
                    settings.SetSupportMultipleWindows(false);

                    // ✅ Étape 4: Autoriser le JS à ouvrir des fenêtres automatiquement
                    settings.JavaScriptCanOpenWindowsAutomatically = true;

                    // Notre WebViewClient personnalisé
                    handler.PlatformView.SetWebViewClient(new SmartWebViewClient(
                        handler.PlatformView,
                        () => MainPage.Instance?.CustomHandler_PageStarted(),
                        () => MainPage.Instance?.CustomHandler_PageFinished()
                    ));
                    handler.PlatformView.SetWebChromeClient(new CustomChromeClient(
                        handler.PlatformView,
                        () => MainPage.Instance?.CustomHandler_PageStarted(),
                        () => MainPage.Instance?.CustomHandler_PageFinished()
                    ));

                    // Ajoute l'interface JS (une seule fois)
                    handler.PlatformView.AddJavascriptInterface(new BlobReceiver(handler.PlatformView.Context), "BlobReceiver");
                    handler.PlatformView.AddJavascriptInterface(new JsBridge(handler.PlatformView), "jsBridge");
                    handler.PlatformView.SetDownloadListener(new SmartDownloader(handler.PlatformView.Context, handler.PlatformView));
                }
            });
        }
#endif

    }
}
