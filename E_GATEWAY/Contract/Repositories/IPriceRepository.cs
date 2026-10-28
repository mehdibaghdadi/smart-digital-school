using System.Data;

namespace E_GATEWAY.Contract
{
    public interface IPriceRepository
    {
        Task<DataTable> Packages();

    }
}
