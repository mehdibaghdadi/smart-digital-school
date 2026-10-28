# coding: utf-8
from . import db, BaseModel


class CountryRegion(db.Model):
    __tablename__ = 'country_region'

    id = db.Column(db.Integer, primary_key=True)
    region = db.Column(db.String(40), nullable=False)
