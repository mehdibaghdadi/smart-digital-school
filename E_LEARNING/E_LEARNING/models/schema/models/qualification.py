# coding: utf-8
from . import db, BaseModel

from .school import School




class Qualification(db.Model):
    __tablename__ = 'qualification'

    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(45), nullable=False)
    label = db.Column(db.String(200), nullable=False)
    level = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'), nullable=False)
    education = db.Column(db.String(200, 'utf8mb4_0900_ai_ci'))
    school_id = db.Column(db.ForeignKey('school.id'), nullable=False, index=True)

    school = db.relationship('School', primaryjoin='Qualification.school_id == School.id', backref='qualifications')
