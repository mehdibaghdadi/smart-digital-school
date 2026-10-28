# coding: utf-8
from . import db, BaseModel

from .school import School




class Subject(db.Model):
    __tablename__ = 'subject'

    id = db.Column(db.Integer, primary_key=True)
    label = db.Column(db.String(200), nullable=False)
    school_id = db.Column(db.ForeignKey('school.id'), nullable=False, index=True)

    school = db.relationship('School', primaryjoin='Subject.school_id == School.id', backref='subjects')
