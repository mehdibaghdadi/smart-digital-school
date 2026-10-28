# On utilise une image légère pour servir du contenu statique
FROM nginx:stable-alpine AS base

# Dossier standard où Nginx cherche les fichiers
WORKDIR /usr/share/nginx/html

# On supprime le contenu par défaut de Nginx
RUN rm -rf ./*

# On copie le build local (le "publish" du monde React)
# Remplacez 'dist' par 'build' selon votre configuration (Vite ou CRA)
COPY E_WEBSITE_UI/dist/ .

# Si vous avez besoin d'une config Nginx spécifique (ex: port 8080 ou gestion du routing)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Nginx démarre par défaut, pas besoin d'ENTRYPOINT complexe
CMD ["nginx", "-g", "daemon off;"]