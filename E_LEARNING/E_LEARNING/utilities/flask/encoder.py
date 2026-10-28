import re
import base64
from flask import current_app as app 

class EncoderToken:
    @staticmethod
    def create_token():
        token = app.config['TOKEN_API']
        token_bytes = token.encode('utf-8')  # Convert string to bytes (binary)
        # Base64 encode the binary data to make it web-safe
        token_base64 = base64.b64encode(token_bytes).decode('utf-8')

        return token_base64

    @staticmethod
    def decode_token(token):
        # Decoding the base64 token back to the original bytes
        decoded_bytes = base64.b64decode(token)

        # Convert the bytes back to the original string (if needed)
        decoded_token = decoded_bytes.decode('utf-8')

        if decoded_token == app.config["TOKEN_API"]:
            return decoded_token
        else:
            return None



class EncoderImage:
    @staticmethod
    def blob_to_base64url(blob):
        if blob :
            if type(blob) != bytes:
                return blob
            return 'data:image/png;base64,{}'.format(base64.b64encode(blob).decode('utf-8')) 
        return None

    @staticmethod
    def base64url_to_blob(base64url):
        if  'base64,' in base64url:
            str= base64url.split("base64,")[1];
            image = base64.b64decode(str)
        return image

    def get_image_extension(data_url):
        # Regular expression to extract the mime type (e.g., image/png)
        match = re.match(r'^data:(image/[^;]+);base64,', data_url)
        if match:
            mime_type = match.group(1)  # e.g., image/png
            # Map the mime type to an extension
            extension = mime_type.split('/')[-1]  # Extract the extension, e.g., 'png'
            return extension
        else:
            return '.jpg'  # If the pattern doesn't match


