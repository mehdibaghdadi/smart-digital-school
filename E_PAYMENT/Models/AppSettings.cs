public class AppSettings
{
    public string TermsConditionsURL { get; set; } = "";
    public string Email { get; set; } = "";
    public string Phone { get; set; } = "";
    public BankAcountSettings BankAcount { get; set; } = new();
    public string ReturnUrl { get; set; } = "";
    public string E_GATEWAY_BASE_URL { get; set; } = "";
    public string E_GATEWAY_SUBSCRIBE_URL { get; set; } = "";
    public string E_GATEWAY_CAPTCHA_GENERATE_URL { get; set; } = "";
    public string E_GATEWAY_CAPTCHA_VALIDATION_URL { get; set; } = "";
    public string E_GATEWAY_MAIL_URL { get; set; } = "";
    
}
public class BankAcountSettings
{
    public string Holder { get; set; } = "";
    public string RIB { get; set; } = "";
    public string IBAN { get; set; } = "";
    public string SWIFT { get; set; } = "";
    public string BANK { get; set; } = "";
}