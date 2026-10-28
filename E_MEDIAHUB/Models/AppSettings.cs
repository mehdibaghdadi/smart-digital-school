namespace E_MEDIAHUB.Models
{
    public class AppSettings
    {
        public string AppTitle { get; set; }
        public int MaxContentLength { get; set; }
        public int BufferSizeDownload { get; set; }
        public double PreviewPercent { get; set; }
        public string SecretKey { get; set; }
        public string TokenApi { get; set; }
        public string SessionProtection { get; set; }
        public string E_DbFilesRoot { get; set; }
        public string[] AcceptDomains { get; set; }
    }

}
