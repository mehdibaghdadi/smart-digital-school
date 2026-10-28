# coding: utf-8
from . import db, BaseModel

from .qualification import Qualification
from .school import School




class SchoolQualification(db.Model):
    __tablename__ = 'school_qualification'
    __table_args__ = (
        db.Index('uc_school_qualification', 'qualification_id', 'school_id'),
    )

    id = db.Column(db.Integer, primary_key=True)
    qualification_id = db.Column(db.ForeignKey('qualification.id'), nullable=False, index=True)
    school_id = db.Column(db.ForeignKey('school.id', ondelete='RESTRICT', onupdate='RESTRICT'), nullable=False, index=True)
    nbr_class = db.Column(db.Integer, nullable=False, server_default=db.FetchedValue())
    classrooms_names = db.Column(db.String(500), nullable=False, server_default=db.FetchedValue())

    qualification = db.relationship('Qualification', primaryjoin='SchoolQualification.qualification_id == Qualification.id', backref='school_qualifications')
    school = db.relationship('School', primaryjoin='SchoolQualification.school_id == School.id', backref='school_qualifications')
