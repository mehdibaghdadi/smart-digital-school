# coding: utf-8
from . import db, BaseModel


class Package(db.Model):
    __tablename__ = 'package'

    id = db.Column(db.Integer, primary_key=True)
    name_fr = db.Column(db.String(50), nullable=False)
    name_en = db.Column(db.String(50), nullable=False)
    name_es = db.Column(db.String(50), nullable=False)
    price_per_student = db.Column(db.Numeric(10, 2), nullable=False)
    max_students = db.Column(db.Integer)
    max_teachers = db.Column(db.Integer)
    duration_days = db.Column(db.Integer)
    discount_percentage = db.Column(db.Numeric(5, 2), server_default=db.FetchedValue())
