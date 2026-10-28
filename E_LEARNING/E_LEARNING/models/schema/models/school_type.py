# coding: utf-8
from . import db, BaseModel


class SchoolType(db.Model):
    __tablename__ = 'school_type'

    id = db.Column(db.Integer, primary_key=True)
    label_fr = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    label_en = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    label_es = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
