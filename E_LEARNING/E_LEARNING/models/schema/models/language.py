# coding: utf-8
from . import db, BaseModel


class Language(db.Model):
    __tablename__ = 'language'

    id = db.Column(db.Integer, primary_key=True)
    language_name = db.Column(db.String(50), nullable=False)
    language_code = db.Column(db.String(2), nullable=False)
