# E_LEARNING

Core platform and REST API of Smart Digital School (Python / Flask, SQLAlchemy, MySQL).

## Run locally

```bash
cd E_LEARNING
python -m venv env
env\Scripts\activate          # Windows (source env/bin/activate on Linux/macOS)
pip install -r requirements.txt
copy .env.example .env        # then fill in every CHANGE_ME value
python runserver.py
```

## Configuration

All secrets are read from environment variables (see `.env.example`): database, `SECRET_KEY`, `TOKEN_API`, SMTP and PayPal credentials. Never commit your `.env`.

`deploy_centos.sh` documents a production setup on CentOS 8.
