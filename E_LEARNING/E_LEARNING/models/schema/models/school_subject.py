# coding: utf-8
from . import db, BaseModel

from .qualification import Qualification
from .subject import Subject
from .school import School




class SchoolSubject(db.Model):
    __tablename__ = 'school_subject'
    __table_args__ = (
        db.Index('uc_school_subject', 'subject_id', 'qualification_id', 'school_id'),
    )

    id = db.Column(db.Integer, primary_key=True, nullable=False)
    subject_id = db.Column(db.ForeignKey('subject.id'), nullable=False, index=True)
    qualification_id = db.Column(db.ForeignKey('qualification.id'), nullable=False, index=True)
    school_id = db.Column(db.ForeignKey('school.id'), primary_key=True, nullable=False, index=True)

    qualification = db.relationship('Qualification', primaryjoin='SchoolSubject.qualification_id == Qualification.id', backref='school_subjects')
    school = db.relationship('School', primaryjoin='SchoolSubject.school_id == School.id', backref='school_subjects')
    subject = db.relationship('Subject', primaryjoin='SchoolSubject.subject_id == Subject.id', backref='school_subjects')
