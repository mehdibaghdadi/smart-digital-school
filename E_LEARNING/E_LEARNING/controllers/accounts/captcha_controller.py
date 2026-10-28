from ...imports import *
from flask import Flask, render_template, request, session, send_file
from io import BytesIO
from PIL import Image, ImageDraw, ImageFont
import random
import string


# ---------------API
class CaptchaManager(Api):
    route_base = "/captcha-manager/"

    # Generate a random string for challenge
    @classmethod
    def generate_challenge(self, length=5):
        characters = list(string.ascii_letters + string.digits)
        return "".join(random.choice(characters) for _ in range(length))

    # Generate a random image with challenge
    @classmethod
    def generate_Image_captcha(self, text):
        color = (0, 0, 0)
        background_color = (255, 255, 230)
        width, height = 160, 58
        font_size = 42

        img = Image.new("RGB", (width, height), background_color)
        
        try:
            font = ImageFont.truetype("arial.ttf", font_size)
        except IOError:
            font = ImageFont.load_default( font_size)
            
        draw = ImageDraw.Draw(img)
        # Draw dashed lines on the image
        for y in range(0, height, 8):
            # draw.line([(0, y-cc), (width, y+cc)], fill=(5, 58+cc, 160), width=2, joint="curve")
            start_point = (random.randint(0, width), random.randint(0, height))
            end_point = (random.randint(0, width), random.randint(0, height))
            line_color = (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255),128)
            draw.line([start_point, end_point], fill=line_color, width=2)


        _, _, text_width, text_height = draw.textbbox((0, 0), text=text, font=font)
        position = ((width - text_width) / 2, (height - text_height) / 2)
        draw.text(position, text, color, font=font)
        
        return img

    # Generate CAPTCHA challenge
    @classmethod
    def generate_captcha(self):
        try:
            # Generate a new CAPTCHA challenge
            challenge = self.generate_challenge()
            challenge = challenge.upper()
            session["captcha_challenge"] = challenge

            # Generate the image for the CAPTCHA
            image = self.generate_Image_captcha(challenge)
            image_io = BytesIO()
            image.save(image_io, "PNG")
            image_io.seek(0)

            return send_file(image_io, mimetype="image/png")
        except Exception as inst:
            return Api.json_exception(inst)      

    @route("/captcha", methods=Api.GET_POST)
    @limiter.limit(limit.medium, error_message=limit.medium)
    def captcha(self):
        try:
            return self.generate_captcha()
        except Exception as inst:
            return Api.json_exception(inst)