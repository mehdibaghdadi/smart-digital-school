using E_SIGNALR.Contract;
using E_SIGNALR.Contract.Services;
using E_SIGNALR.Helpers;
using E_SIGNALR.Hubs;
using E_SIGNALR.Repositories;
using E_SIGNALR.Services;
using Serilog;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Options;
using System.Net;
using System.Linq;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddResponseCaching(options =>
{
    options.MaximumBodySize = 1024;
    options.UseCaseSensitivePaths = true;
});

// Logger Serilog
builder.Host.UseSerilog((ctx, lc) => lc
    .WriteTo.Console()
    .Filter.ByExcluding("SourceContext = 'Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware'")
    .ReadFrom.Configuration(ctx.Configuration));


// Modules
builder.Services.AddScoped<IReportHelper, ReportHelper>();
builder.Services.AddScoped<INotificationService, NotificationService>();
builder.Services.AddSingleton<IUserIdProvider, CustomUserIdProvider>();

// Repositories
builder.Services.AddScoped<IDbContext, DbContext>();
builder.Services.AddScoped<IMessageBoxRepository, MessageBoxRepository>();
builder.Services.AddScoped<IAssistanceRepository, AssistanceRepository>();

// Configuration CORS pour plusieurs origines
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


// Add services to the container.

builder.Services.AddControllers();
// SignalR
builder.Services.AddSignalR(o =>
{
    o.EnableDetailedErrors = true;
});


var app = builder.Build();


// MiddleWare Exception
var logger = app.Logger;
app.ConfigureExceptionHandler(logger);

// Configure the HTTP request pipeline.


// HTTPS Redirection and HSTS
if (!app.Environment.IsDevelopment())
{
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseRouting();
app.UseCors("AllowSpecificOrigins");
app.UseStaticFiles();
app.UseAuthorization();


app.MapHub<NotificationHub>("/notification-hub"); // Mappez le hub SignalR

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
