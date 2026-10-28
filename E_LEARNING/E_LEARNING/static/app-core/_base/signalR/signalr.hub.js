(function (window) {
    class SignalRService {
        constructor() {
            this.hubCn = null;
        }

        init(url) {
            if (!this.hubCn) {
                // Générer ou récupérer un clientId unique
                let clientId = localStorage.getItem('clientId');
                if (!clientId) {
                    clientId = this.generateClientId();
                    localStorage.setItem('clientId', clientId);
                }

                // Vérifier que clientId est défini
                if (!clientId) {
                    console.warn('clientId est indéfini ou vide.');
                }

                // Inclure clientId dans l'URL de connexion
                const connectionUrl = `${url}?clientId=${encodeURIComponent(clientId)}`;

                this.hubCn = new signalR.HubConnectionBuilder()
                    .withUrl(connectionUrl, {
                        withCredentials: true // Inclure les informations d'identification si nécessaire
                    })
                    .configureLogging(signalR.LogLevel.None) // Désactiver la journalisation
                    .build();
                Object.defineProperty(WebSocket, 'OPEN', { value: 1, });

                this.hubCn.onclose(async () => {
                    console.log("SignalR fermé.");
                    await startConnection(this.hubCn);
                });

                const startConnection = async (hubCn) => {
                    console.log("Connexion en cours...", connectionUrl);
                    try {
                        await hubCn.start();
                        console.log("SignalR connecté."); 
                    } catch (err) {
                        console.log(err);
                        setTimeout(() => startConnection(hubCn), 5000);
                    }
                };

                startConnection(this.hubCn);
            }
            return Promise.resolve(this.hubCn);
        }

        // Fonction pour générer un identifiant de client unique
        generateClientId() {
            // Exemple simple de génération d'un UUID
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
                const r = Math.random() * 16 | 0;
                const v = c === 'x' ? r : (r & 0x3 | 0x8);
                return v.toString(16);
            });
        }
    }

    window.signalRService = new SignalRService();

})(window);
