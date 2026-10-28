@ECHO OFF

REM ------------------------------------------------------
REM Configuration : 
REM ------------------------------------------------------
SET MODE_DEBUG=1
SET VS_DEBUG=0
SET APP_VERSION=1-0-0-1
SET SERVER_HOST=127.0.0.1
SET SERVER_PORT=5005

REM Chemin vers l'environnement virtuel
SET ENV_PATH=D:\SMART_DIGITAL_SCHOOL\E_LEARNING\E_AI_COURSE\env\Scripts

REM Chemin vers le projet
CD /D D:\SMART_DIGITAL_SCHOOL\E_LEARNING\E_AI_COURSE

REM ------------------------------------------------------
REM Lancer Waitress
REM ------------------------------------------------------
"%ENV_PATH%\uvicorn.exe" ^
    --port=%SERVER_PORT% ^
    --reload ^
    runserver:app


REM ------------------------------------------------------
REM Executer d'abord une fois : ollama run llama3.1
REM ---- Production --------------------------------------
REM gunicorn runserver:app -k uvicorn.workers.UvicornWorker -w 4 --bind 0.0.0.0:5005
