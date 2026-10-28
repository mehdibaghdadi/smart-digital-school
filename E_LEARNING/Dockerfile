FROM python:3.11-slim

WORKDIR /app
# Installer les dépendances système nécessaires pour WeasyPrint
RUN apt-get update && apt-get install -y \
    libpango-1.0-0 \
    libpangoft2-1.0-0 \
    libharfbuzz0b \
    libharfbuzz-subset0 \
    libgobject-2.0-0 \
    && rm -rf /var/lib/apt/lists/*
# Dépendances
COPY E_LEARNING/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Code
COPY E_LEARNING/E_LEARNING/ ./E_LEARNING
COPY E_LEARNING/logs/ ./logs
COPY E_LEARNING/runserver.py .
COPY E_LEARNING/wsgi.py .
COPY E_LEARNING/.env.production .env


ENV PYTHONUNBUFFERED=1

EXPOSE 8080

CMD ["gunicorn", "--worker-class", "gevent", "--bind", "0.0.0.0:8080", "--workers", "4", "--timeout", "60", "--keep-alive", "5", "wsgi:app"]