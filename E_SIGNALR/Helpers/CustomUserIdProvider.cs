using Microsoft.AspNetCore.SignalR;

public class CustomUserIdProvider : IUserIdProvider
{
    public string GetUserId(HubConnectionContext connection)
    {
        var clientId = connection.GetHttpContext()?.Request.Query["clientId"].ToString();

        if (string.IsNullOrWhiteSpace(clientId))
        {
            // Générer un identifiant unique côté serveur si nécessaire
            clientId = GenerateServerClientId();
        }

        return clientId;
    }

    private string GenerateServerClientId()
    {
        return Guid.NewGuid().ToString();
    }
}
