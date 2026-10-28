# coding: utf-8
from . import db, BaseModel

from .school_type_qualification import SchoolTypeQualification




class SchoolTypeSubject(db.Model):
    __tablename__ = 'school_type_subject'

    id = db.Column(db.Integer, primary_key=True)
    school_type_id = db.Column(db.ForeignKey('school_type_qualification.id'), nullable=False, index=True)
    label_fr = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    label_en = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    label_es = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)

    school_type = db.relationship('SchoolTypeQualification', primaryjoin='SchoolTypeSubject.school_type_id == SchoolTypeQualification.id', backref='school_type_subjects')
