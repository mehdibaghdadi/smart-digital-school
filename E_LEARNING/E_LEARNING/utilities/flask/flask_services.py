import requests  
from .encoder import EncoderImage,EncoderToken
from flask import current_app as app,json
from flask_mail import Message
from E_LEARNING import mail
import base64
import re
from urllib.parse import quote_plus
from threading import Thread


def SendMail(title, html, recipients):
    try:
        msg = Message(
            subject=title,
            sender=app.config["MAIL_DEFAULT_SENDER"],
            recipients=[recipients],
        )
        msg.html = html
        send = mail.send(msg)
    except:
        return False

    return True


def is_base64_image(data):
    """Check if the input is a base64-encoded image."""
    if isinstance(data, str) and data.startswith("data:image/"):
        try:
            # Extract and validate base64 part
            base64_data = data.split(",")[1]
            base64.b64decode(base64_data, validate=True)
            return True
        except (IndexError, ValueError):
            return False
    return False


def is_url(data):
    """Check if the input is a valid URL."""
    url_regex = re.compile(
        r"^(?:http|ftp)s?://"  # http:// or https://
        r"(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+(?:[A-Z]{2,6}\.?|[A-Z0-9-]{2,}\.?)|"  # domain...
        r"localhost|"  # localhost...
        r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}|"  # ...or ipv4
        r"\[?[A-F0-9]*:[A-F0-9:]+\]?)"  # ...or ipv6
        r"(?::\d+)?"  # optional port
        r"(?:/?|[/?]\S+)$",
        re.IGNORECASE,
    )
    return re.match(url_regex, data) is not None


def uploadImage(imageb64, directory, filename, old_file):
    image_path = None

    directory=quote_plus(directory)
    filename=quote_plus(filename)


    if imageb64 != app.config["DEFAULT_PICTURE_PROFILE"]:
        # Check if imageb64 is base64 or a link
        if is_base64_image(imageb64):
            # Handle base64-encoded image
            ext = EncoderImage.get_image_extension(imageb64)
            base64_data = imageb64.split(",")[1]
            image_data = base64.b64decode(base64_data)

            # Proceed with uploading the base64 image
            url_api = app.config["E_FILE_MANAGER_API"]
            filename = "{0}.{1}".format(filename, ext)
            file_path = app.config["CONTENT_UPLOAD_FILE_URL"].format(
                directory, filename
            )

            if old_file:
                old_file=quote_plus(old_file)

                file_path = app.config["CONTENT_UPDATE_UPLOAD_FILE_URL"].format(
                    directory, filename, old_file
                )

            upload_url = f"{url_api}{file_path}"
            token_base64 = EncoderToken.create_token()
            headers = {
                "Authorization": f"Bearer {token_base64}",
                "Content-Type": "application/octet-stream",
            }
            response = requests.post(
                upload_url, data=image_data, headers=headers, timeout=60, verify=False
            )

            if response.status_code == 200:
                jsn = json.loads(response.text)
                image_path = jsn["file"]

        elif is_url(imageb64):
            # Handle URL (possibly just return the URL or perform other actions)
            image_path = old_file if old_file in imageb64 else imageb64

    return image_path


def getImage(image_url):
    img = (
        "{}{}/{}".format(
            app.config["E_FILE_MANAGER_API"],
            app.config["CONTENT_GET_IMAGE_URL"],
            image_url,
        )
        if image_url 
        else app.config["DEFAULT_PICTURE_PROFILE"]
    )
    return img


def delete_file(content_url) -> bool:
    if not content_url:
        return False

    url_api = app.config["E_FILE_MANAGER_API"]
    url_api_delete = app.config["CONTENT_DELETE_FILE_URL"]
    delete_url = f"{url_api}{url_api_delete}"

    token_base64 = EncoderToken.create_token()

    headers = {
        "Authorization": f"Bearer {token_base64}",
        "Content-Type": "application/json"
    }

    payload = {
        "content_url": content_url
    }

    try:
        resp = requests.post(
            delete_url,
            json=payload,      # POINT CRITIQUE
            headers=headers,
            timeout=5,
            verify=False
        )

        return resp.status_code == 200

    except Exception as inst:
        return False


def delete_file_async( content_url):
    from flask import current_app
    app = current_app._get_current_object()

    def runner(url):
        with app.app_context():
            delete_file(url)

    Thread(
        target=runner,
        args=(content_url,),
        daemon=True
    ).start()