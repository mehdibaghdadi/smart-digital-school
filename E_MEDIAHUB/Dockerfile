FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
# On repasse temporairement en root pour créer les dossiers et gérer les droits
USER root

# Créer le dossier de destination des médias
RUN mkdir -p /var/www/SMART_DIGITAL_SCHOOL/E_DBFILES && \
    chown -R $APP_UID:$APP_UID /var/www/SMART_DIGITAL_SCHOOL/E_DBFILES

WORKDIR /app

# Copier les binaires pré-compilés
COPY E_MEDIAHUB/publish/ .

# Revenir à l'utilisateur non-privilégié pour la sécurité
USER $APP_UID

EXPOSE 8080
ENTRYPOINT ["dotnet", "E_MEDIAHUB.dll"]