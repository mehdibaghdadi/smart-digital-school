@ECHO OFF

set ASPNETCORE_ENVIRONMENT=Development
cd /d D:\SMART_DIGITAL_SCHOOL\E_LEARNING\E_GATEWAY\bin\Debug\net9.0
dotnet E_GATEWAY.dll --urls=http://localhost:5002
