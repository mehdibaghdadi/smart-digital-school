@ECHO OFF

set ASPNETCORE_ENVIRONMENT=Development
cd /d D:\SMART_DIGITAL_SCHOOL\E_LEARNING\E_SIGNALR\bin\Debug\net9.0
dotnet E_SIGNALR.dll --urls=http://localhost:5004
