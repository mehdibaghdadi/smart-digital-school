# coding: utf-8
from . import db, BaseModel


class Country(db.Model):
    __tablename__ = 'country'

    id = db.Column(db.Integer, primary_key=True)
    country_fr = db.Column(db.String(100), nullable=False)
    country_en = db.Column(db.String(100), nullable=False)
    country_es = db.Column(db.String(100), nullable=False)
