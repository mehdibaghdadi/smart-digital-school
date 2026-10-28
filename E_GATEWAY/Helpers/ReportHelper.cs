using System.Data;
using System.Text;
using E_GATEWAY.Contract;
using Newtonsoft.Json;

public class ReportHelper : IReportHelper
{
    private IWebHostEnvironment _environment; 
    public ReportHelper(IWebHostEnvironment environment)
    {        _environment = environment;        
    }

    public  string DataTableToJSON(DataTable table)
    {
        try
        {
            return JsonConvert.SerializeObject(table);
        }
        catch (Exception)
        {
            return string.Empty;
        }
    }

}
