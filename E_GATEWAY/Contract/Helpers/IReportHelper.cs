using System.Data;

namespace E_GATEWAY.Contract
{
    public interface IReportHelper
    {
        string DataTableToJSON(DataTable table);
        //static string FileName(string format, string file_report) => throw new NotImplementedException();
        //byte[] Render(string reportName, Dictionary<string, DataTable> source, Dictionary<string, string> reportParameters, string format);
    }
}
