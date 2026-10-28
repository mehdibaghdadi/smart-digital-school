
using E_SIGNALR.Contract.Services;
using Microsoft.AspNetCore.SignalR;

namespace E_SIGNALR.Hubs
{
    public sealed class NotificationHub : Hub<INotificationClient>
    {
        private readonly IHubContext<NotificationHub, INotificationClient> _context;

        public NotificationHub(IHubContext<NotificationHub, INotificationClient> context)
        {
            _context = context;
        }

        public override async Task OnConnectedAsync()
        {
            var clientId = Context.UserIdentifier;

            // Vous pouvez maintenant utiliser Clients.User(clientId)
            await Clients.User(clientId).OnConnected(Context.ConnectionId);

            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            var clientId = Context.UserIdentifier;

            // Effectuer les opérations de nettoyage si nécessaire

            await base.OnDisconnectedAsync(exception);
        }

    }

}
