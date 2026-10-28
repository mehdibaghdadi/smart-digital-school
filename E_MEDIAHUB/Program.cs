using E_MEDIAHUB.Filters;
using E_MEDIAHUB.Helpers;
using E_MEDIAHUB.Models;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

builder.WebHost.ConfigureKestrel(options =>
{
    options.Limits.MaxRequestBodySize = null; // Pas de limite de taille pour le corps de la requête
});
// Logger Serilog
builder.Host.UseSerilog((ctx, lc) => lc
    .Filter.ByExcluding("SourceContext = 'Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware'")
    .ReadFrom.Configuration(ctx.Configuration));

builder.Services.Configure<AppSettings>(builder.Configuration.GetSection(nameof(AppSettings)));

// Add services to the container.
builder.Services.AddScoped<DownloadValidationFilter>();

// Configuration CORS pour plusieurs origines
//ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
var allowedOrigins = builder.Configuration.GetSection("AllowedOrigins").Get<string[]>() ?? new string[] { "*" };

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins",
        policy =>
        {
            policy.AllowAnyHeader()
                   .AllowAnyMethod()
                   .AllowCredentials()
                   .WithOrigins(allowedOrigins);

        });
});

builder.Services.AddControllers();

var app = builder.Build();

// MiddleWare Exception
var logger = app.Logger;
app.ConfigureExceptionHandler(logger);

// Configure the HTTP request pipeline.
app.UseHttpsRedirection();
app.UseRouting();
app.UseCors("AllowSpecificOrigins");
app.UseStaticFiles();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");


app.Run();
