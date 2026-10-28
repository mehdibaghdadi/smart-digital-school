using E_GATEWAY.ReportService;
using E_GATEWAY.Contract;
using E_GATEWAY.Repositories;
using E_GATEWAY.Helpers;
using Serilog;
using E_GATEWAY.Contracts;
using E_GATEWAY.Models;
using E_GATEWAY.Services;
using System.Net;
using E_GATEWAY.Extensions;




var builder = WebApplication.CreateBuilder(args);

builder.Services.AddResponseCaching(options =>
{
    options.MaximumBodySize = 1024;
    options.UseCaseSensitivePaths = true;
});
builder.Services.AddMemoryCache();

// Logger Serilog
builder.Host.UseSerilog((ctx, lc) => lc
    .Filter.ByExcluding("SourceContext = 'Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware'")
    .ReadFrom.Configuration(ctx.Configuration));

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Register application services
builder.Services.AddApplicationServices();

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

// Email
builder.Services.Configure<MailSettings>(builder.Configuration.GetSection(nameof(MailSettings)));
builder.Services.AddTransient<IMailService, MailService>();

builder.Services.AddDistributedMemoryCache();

builder.Services.AddSession(options =>
{
    options.Cookie.SameSite = SameSiteMode.None;
    options.Cookie.Name = ".Egateway.Session";
    options.IdleTimeout = TimeSpan.FromMinutes(30); // Temps d'expiration de la session
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true; // Requis pour le RGPD si utilisé
});


// App
var app = builder.Build();


// MiddleWare Exception
var logger = app.Logger;
app.ConfigureExceptionHandler(logger);

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI();

// HTTPS Redirection and HSTS
if (!app.Environment.IsDevelopment())
{
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseRouting();
app.UseCors("AllowSpecificOrigins");


// Use the custom cache control middleware
app.UseMiddleware<CacheMiddleware>();
app.UseStaticFiles();
// Enable response caching
app.UseResponseCaching();
app.UseAuthorization();

app.UseSession();

app.MapControllerRoute(name: "default", pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
