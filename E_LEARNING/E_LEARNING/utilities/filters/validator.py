from flask import current_app as app
import requests


# Custom Jinja2 filter for URL fallback
@app.template_filter('src_fallback')
def src_fallback(remote_url, local_path):
    try:
        response = requests.head(remote_url, timeout=7)
        return remote_url if response.status_code == 200 else local_path
    except Exception as e:
        return local_path
