
using System.Data;
using E_GATEWAY.Contract;
using E_GATEWAY.Repositories;
namespace E_GATEWAY.Services
{
    public class PriceService : IPriceService
    {
        private readonly IReportHelper _reportHelper;
        private readonly IPriceRepository _pack;

        public PriceService(IReportHelper reportHelper, IPriceRepository pack)
        {
            _reportHelper = reportHelper;
            _pack = pack;
        }
        public async Task<string> GetPackagesService()
        {
            var dataTable = await _pack.Packages();

            var file = _reportHelper.DataTableToJSON(dataTable);
            return file;
        }
    }
}
