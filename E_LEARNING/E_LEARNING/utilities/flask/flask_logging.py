from datetime import datetime
from flask import request
import logging
import threading
from user_agents import parse as parse_ua

_log_format = f"%(asctime)s - [%(levelname)s] - %(message)s"

# This module provides logging utilities for the Flask application.
def get_file_handler(file_name):
    file_handler = logging.FileHandler(file_name)
    file_handler.setLevel(logging.WARNING)
    file_handler.setFormatter(logging.Formatter(_log_format))
    return file_handler

def get_stream_handler():
    stream_handler = logging.StreamHandler()
    stream_handler.setLevel(logging.INFO)
    stream_handler.setFormatter(logging.Formatter(_log_format))
    return stream_handler

def get_logger(name,file_name):
    logger = logging.getLogger(name)
    logger.setLevel(logging.INFO)
    logger.addHandler(get_file_handler(file_name))
    logger.addHandler(get_stream_handler())
    return logger


# This module provides a function to log user connections asynchronously.
def log_user_connection(user_id, role, ip_address, user_agent_raw, dbSession):
    from ...models.db_entities_tables import UserConnectionLog
    os_name = browser_name = device_name = "Inconnu"

    try:
        parsed = parse_ua(user_agent_raw)
        os_name = f"{parsed.os.family} {parsed.os.version_string}"
        browser_name = f"{parsed.browser.family} {parsed.browser.version_string}"

        device_name = parsed.device.family
        if device_name.lower() == "other":
            device_name = "Desktop"
    except Exception as e:
        print(f"[UA PARSE ERROR] {e}")

    log = UserConnectionLog(
        user_id=user_id,
        role=role,
        ip_address=ip_address,
        user_agent=user_agent_raw,
        os_name=os_name,
        browser_name=browser_name,
        device_name=device_name,
        timestamp=datetime.utcnow()
    )

    dbSession.add(log)
    dbSession.commit()


def log_user_connection_async(user_id, role, dbSession):
    from flask import request

    # Capture du contexte AVANT de lancer le thread
    ip_address = request.headers.get('X-Forwarded-For', request.remote_addr)
    user_agent_raw = request.headers.get("User-Agent")    

    def task():
        try:
            log_user_connection(
                user_id=user_id,
                role=role,
                ip_address=ip_address,
                user_agent_raw=user_agent_raw,
                dbSession=dbSession
            )
        except Exception as e:
            print(f"[LOG ERROR] {e}")

    threading.Thread(target=task).start()
