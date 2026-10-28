using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Localization.Routing;
using Microsoft.Extensions.Options;
using System.Globalization;
using System.Text.RegularExpressions;
using Serilog;
using E_PAYMENT.Services;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder(args);

// Logger Serilog
builder.Host.UseSerilog((ctx, lc) => lc
    .Filter.ByExcluding("SourceContext = 'Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware'")
    .ReadFrom.Configuration(ctx.Configuration));

builder.Services.Configure<AppSettings>(builder.Configuration);

// Ajouter les services de localisation
builder.Services.AddLocalization(options => options.ResourcesPath = "Resources");

// Ajouter les services MVC
builder.Services.AddControllersWithViews();

builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30); // Temps d'expiration de la session
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true; // Requis pour le RGPD si utilisé
});


builder.Services.AddHttpClient<EGatewayService>((serviceProvider, client) =>
{
    var appSettings = serviceProvider.GetRequiredService<IOptions<AppSettings>>().Value;
    client.BaseAddress = new Uri(appSettings.E_GATEWAY_BASE_URL);
})
.ConfigurePrimaryHttpMessageHandler(() =>
{
    var handler = new HttpClientHandler
    {
        ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true
    };
    return handler;
});

// Enregistrer CaptchaService
builder.Services.AddTransient<CaptchaService>();
builder.Services.AddTransient<MailService>();
builder.Services.AddScoped<IRazorViewToStringRenderer, RazorViewToStringRenderer>();


var app = builder.Build();


// Configurer les cultures supportées
var supportedCultures = new[]
{
    new CultureInfo("fr"), // Français
    new CultureInfo("en") , // Anglais
    new CultureInfo("es")  // Anglais
};

// Configurer la localisation
app.UseRequestLocalization(new RequestLocalizationOptions
{
    DefaultRequestCulture = new RequestCulture("fr"),
    SupportedCultures = supportedCultures,
    SupportedUICultures = supportedCultures,
    RequestCultureProviders = new[] {
        new RouteDataRequestCultureProvider
        {
            RouteDataStringKey = "culture",
            UIRouteDataStringKey = "culture",
            Options = app.Services.GetRequiredService<IOptions<RequestLocalizationOptions>>().Value
        }
    }
});

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();
app.UseSession();
// Middleware de débogage des RouteValues (doit être après UseRouting)
app.Use(async (context, next) =>
{
    Console.WriteLine("RouteValues:");
    foreach (var routeValue in context.Request.RouteValues)
    {
        Console.WriteLine($"Key: {routeValue.Key}, Value: {routeValue.Value}");
    }
    await next();
});

// Middleware pour valider les cultures (doit être après UseRouting)
app.Use(async (context, next) =>
{
    var defaultCulture = app.Services.GetRequiredService<IOptions<RequestLocalizationOptions>>()
            .Value.DefaultRequestCulture.Culture.TwoLetterISOLanguageName;
    var sessionCulture = context.Session.GetString("Culture");
    var culture = context.Request.RouteValues["culture"]?.ToString() ?? sessionCulture ?? defaultCulture; // Défaut à "fr"
    var exist = supportedCultures.Any(x => x.TwoLetterISOLanguageName
                                             .Equals(culture, StringComparison.OrdinalIgnoreCase));

    if (!exist)
    {
        culture = defaultCulture;
    }

    if (!string.IsNullOrEmpty(culture))
    {
        var cultureInfo = new CultureInfo(culture);
        CultureInfo.CurrentCulture = cultureInfo;
        CultureInfo.CurrentUICulture = cultureInfo;
        // Stocker la culture dans la session
        context.Session.SetString("Culture", culture);
    }
    else
    {

        culture = sessionCulture ?? defaultCulture;
        context.Response.Redirect($"/{culture}{context.Request.Path}{context.Request.QueryString}");
        return;
    }

    await next();
});

app.UseAuthorization();

// Définir les routes
app.MapControllerRoute(
    name: "default",
    pattern: "{culture?}/{controller=Home}/{action=Index}/{id?}");

app.MapGet("/", (HttpContext context) =>
{
    var defaultCulture = app.Services.GetRequiredService<IOptions<RequestLocalizationOptions>>()
               .Value.DefaultRequestCulture.Culture.TwoLetterISOLanguageName;
    var currentCulture = context.Session.GetString("Culture");
    var culture = currentCulture ?? defaultCulture;
    return Results.Redirect($"/{culture}");
});

app.Run();
