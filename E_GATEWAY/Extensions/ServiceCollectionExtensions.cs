using E_GATEWAY.Contract;
using E_GATEWAY.ReportService;
using E_GATEWAY.Repositories;
using E_GATEWAY.Services;
using Microsoft.Extensions.DependencyInjection;

namespace E_GATEWAY.Extensions
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            // Modules
            services.AddScoped<IReportHelper, ReportHelper>();
            services.AddScoped<IPriceService, PriceService>();
            services.AddScoped<IInstructorReportService, InstructorReportService>();
            services.AddScoped<ISchoolReportService, SchoolReportService>();
            services.AddScoped<ISubscriptionClientService, SubscriptionClientService>();

            // Repositories
            services.AddScoped<IDbContext, DbContext>();
            services.AddScoped<IPriceRepository, PriceRepository>();
            services.AddScoped<IInstructorRepository, InstructorRepository>();
            services.AddScoped<ISchoolRepository, SchoolRepository>();
            services.AddScoped<ISubscriptionClientRepository, SubscriptionClientRepository>();

            return services;
        }
    }
}
