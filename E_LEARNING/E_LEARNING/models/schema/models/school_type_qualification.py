# coding: utf-8
from . import db, BaseModel

from .school_type import SchoolType




class SchoolTypeQualification(db.Model):
    __tablename__ = 'school_type_qualification'

    id = db.Column(db.Integer, primary_key=True)
    label_fr = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    label_en = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    label_es = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    level_fr = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    level_en = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    level_es = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    school_type_id = db.Column(db.ForeignKey('school_type.id'), nullable=False, index=True)

    school_type = db.relationship('SchoolType', primaryjoin='SchoolTypeQualification.school_type_id == SchoolType.id', backref='school_type_qualifications')
