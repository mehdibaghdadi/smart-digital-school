# coding: utf-8
from . import db, BaseModel


class ContentType(db.Model):
    __tablename__ = 'content_type'

    id = db.Column(db.Integer, primary_key=True)
    content_type = db.Column(db.String(20), nullable=False)
