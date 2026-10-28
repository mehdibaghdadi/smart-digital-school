@ECHO OFF
REM ------------------------------------------------------
REM Configuration
REM ------------------------------------------------------
SET SERVER_PORT=5001

REM Chemin vers l'environnement virtuel
SET ENV_PATH=D:\SMART_DIGITAL_SCHOOL\E_LEARNING\E_LEARNING\env\Scripts

REM Chemin vers le projet
CD /D D:\SMART_DIGITAL_SCHOOL\E_LEARNING\E_LEARNING

REM ------------------------------------------------------
REM Lancer Waitress
REM ------------------------------------------------------
"%ENV_PATH%\waitress-serve.exe" ^
    --port=%SERVER_PORT% ^
    --url-scheme=https ^
    --threads=8 ^
    --max-request-body-size=209715200 ^
    wsgi:wsgifunc
