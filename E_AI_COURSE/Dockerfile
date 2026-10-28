FROM python:3.11-slim

WORKDIR /app

COPY E_AI_COURSE/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Code
COPY E_AI_COURSE/E_AI_COURSE/ ./E_AI_COURSE
COPY E_AI_COURSE/runserver.py .
COPY E_AI_COURSE/.env.production .env


ENV PYTHONUNBUFFERED=1

EXPOSE 8080

CMD ["gunicorn", "runserver:app", "--workers", "2", "-k", "uvicorn.workers.UvicornWorker", "--bind", "0.0.0.0:8080", "--timeout", "600"]
