namespace E_GATEWAY.Models
{
    public class ApiResponse<T>
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public T Data { get; set; }  // Données dynamiques basées sur le type générique
    }
}
