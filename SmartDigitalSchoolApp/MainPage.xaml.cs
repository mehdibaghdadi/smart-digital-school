#if ANDROID
using Android.Widget;
using Android.Content;
#endif

using Microsoft.Maui.Controls;
using Microsoft.Maui.Controls.PlatformConfiguration.WindowsSpecific;
using Microsoft.Maui.Dispatching;
using SmartDigitalSchoolApp.Handlers;
using SmartDigitalSchoolApp.Helpers;
using System;
using System.Threading;
using System.Threading.Tasks;
using static SmartDigitalSchoolApp.Handlers.CustomWebViewHandler;

namespace SmartDigitalSchoolApp;

public partial class MainPage : ContentPage
{
    public static MainPage? Instance; // pour que le handler Android puisse appeler les méthodes
    CancellationTokenSource _pulseCts = new();
    bool _isPulsing = false;

    public MainPage()
    {
        InitializeComponent();
        Instance = this;
#if ANDROID
        CustomWebViewHandler.Register();
#endif

        MyWebView.Navigating += CustomHandler_PageStarted;
        MyWebView.Navigated += CustomHandler_PageFinished;
    }

    private DateTime _lastBackPressed;
    private const int BackPressDelay = 2000; // 2 secondes
    bool IsModalOpen = false;
    private void refreshView_Refreshing(object sender, EventArgs e)
    {
        MyRefreshView.IsRefreshing = true;
        MyWebView.Reload();
        MyRefreshView.IsRefreshing = false;
        IsModalOpen = false;

    }
    public void OnJsMessageReceived(string message)
    {
        if (message == "modalOpened")
        {
            IsModalOpen = true;
        }
        else if (message == "modalClosed")
        {
            IsModalOpen = false;
        }
    }
#if ANDROID
    protected override bool OnBackButtonPressed()
    {

        if (IsModalOpen)
        {
            MyWebView.EvaluateJavaScriptAsync("removeModalHistory();");
            return true;
        }
        // Si l'historique a plus d'une entrée, on revient en arrière
        if (MyWebView != null && WebViewHistory.History.Count > 1)
        {
            WebViewHistory.History.Pop();
            var previousUrl = WebViewHistory.History.Peek();
            MyWebView.Source = previousUrl;
            return true;
        }
        else
        {
            var now = DateTime.Now;
            if ((now - _lastBackPressed).TotalMilliseconds <= BackPressDelay)
            {
                // Appuye deux fois rapidement → quitter
                return base.OnBackButtonPressed();
            }
            else
            {
                _lastBackPressed = now;
                // Afficher un message Toast
                var context = Android.App.Application.Context;
                if (context != null)
                    Toast.MakeText(context,
                        "Press back again to exit.",
                        ToastLength.Short)?.Show();

                // Recharge la page d'accueil au lieu de fermer l'app
                if (MyWebView != null)
                    MyWebView.Source = AppConstants.BaseUrl;
                return true; // empêche la fermeture
            }
        }
       
    }
#endif

    protected override void OnDisappearing()
    {
        _pulseCts?.Cancel();
        MyWebView.Navigating -= CustomHandler_PageStarted;
        MyWebView.Navigated -= CustomHandler_PageFinished;
        base.OnDisappearing();
    }
    private void CustomHandler_PageStarted(object? sender, WebNavigatingEventArgs e)
    {
        CustomHandler_PageStarted();
    }
    private void CustomHandler_PageFinished(object? sender, WebNavigatedEventArgs e)
    {
        CustomHandler_PageFinished();
    }

    public void CustomHandler_PageStarted()
    {
        IsModalOpen = false;

        MainThread.BeginInvokeOnMainThread(() =>
        {
            LoadingOverlay.IsVisible = true;
            _ = StartPulseLoopAsync();
        });
    }
    public void CustomHandler_PageFinished()
    {
        MainThread.BeginInvokeOnMainThread(() =>
        {
            _pulseCts?.Cancel();
            _ = HideLoaderAsync();
        });
    }

    async Task HideLoaderAsync()
    {
        try { await LoadingOverlay.FadeTo(0, 250); } catch { }
        LoadingOverlay.IsVisible = false;
        LoadingOverlay.Opacity = 1;
        LogoImage.Scale = 1;
    }

    async Task StartPulseLoopAsync()
    {
        if (_isPulsing) return;

        _isPulsing = true;
        _pulseCts?.Cancel();
        _pulseCts = new CancellationTokenSource();
        var ct = _pulseCts.Token;

        try
        {
            while (!ct.IsCancellationRequested && LoadingOverlay.IsVisible)
            {
                await LogoImage.ScaleTo(1.15, 1000, Easing.SinInOut).ConfigureAwait(false);
                await LogoImage.ScaleTo(1.0, 1000, Easing.SinInOut).ConfigureAwait(false);
            }
        }
        catch (OperationCanceledException) { }
        finally { _isPulsing = false; }
    }
}
