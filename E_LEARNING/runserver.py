import os
from pathlib import Path

if __name__ == "__main__":
    
    from E_LEARNING import app,MODE_DEBUG
    if MODE_DEBUG:
        PORT = 7100
        HOST = "127.0.0.1"
    
        print("="*50)
        print("🔧 MODE DÉBOGAGE - Flask Werkzeug")
        print("="*50)
        print(f"📡 Serveur: http://{HOST}:{PORT}")
        print("🔄 Rechargement automatique: ACTIVÉ")
        print("="*50)
    
        app.run(host=HOST, port=PORT, debug=True)