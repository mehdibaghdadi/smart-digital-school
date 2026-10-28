using System.Data;

namespace E_SIGNALR.Contract
{
    public interface IReportHelper
    {
        string DataTableToJSON(DataTable table);
    }
}
