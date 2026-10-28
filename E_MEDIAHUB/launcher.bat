@ECHO OFF

set ASPNETCORE_ENVIRONMENT=Development
cd /d D:\SMART_DIGITAL_SCHOOL\E_LEARNING\E_MEDIAHUB\bin\Debug\net9.0
dotnet E_MEDIAHUB.dll --urls=http://localhost:5003
