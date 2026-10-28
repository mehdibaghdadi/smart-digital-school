# E_PAYMENT/Dockerfile (version binaires)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
USER $APP_UID
WORKDIR /app

# Copier les binaires pré-compilés
COPY E_PAYMENT/publish/ .

EXPOSE 8080
EXPOSE 8081

ENTRYPOINT ["dotnet", "E_PAYMENT.dll"]