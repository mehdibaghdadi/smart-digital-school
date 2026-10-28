# coding: utf-8
from . import db, BaseModel


class CountryCity(db.Model):
    __tablename__ = 'country_city'

    id = db.Column(db.Integer, primary_key=True)
    city = db.Column(db.String(40, 'utf8mb4_0900_ai_ci'))
    region_id = db.Column(db.Integer, nullable=False)
