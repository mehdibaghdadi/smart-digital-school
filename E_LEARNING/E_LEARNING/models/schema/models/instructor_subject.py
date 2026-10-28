# coding: utf-8
from . import db, BaseModel

from .school_subject import SchoolSubject
from .instructor import Instructor




class InstructorSubject(db.Model):
    __tablename__ = 'instructor_subject'
    __table_args__ = (
        db.Index('uc_instructor_subject_qualification', 'instructor_id', 'school_subject_id'),
    )

    id = db.Column(db.Integer, primary_key=True)
    instructor_id = db.Column(db.ForeignKey('instructor.id'), nullable=False, index=True)
    school_subject_id = db.Column(db.ForeignKey('school_subject.id'), nullable=False, index=True)
    subject_price = db.Column(db.Integer, nullable=False, server_default=db.FetchedValue())
    classrooms_teaching = db.Column(db.String(500), nullable=False, server_default=db.FetchedValue())

    instructor = db.relationship('Instructor', primaryjoin='InstructorSubject.instructor_id == Instructor.id', backref='instructor_subjects')
    school_subject = db.relationship('SchoolSubject', primaryjoin='InstructorSubject.school_subject_id == SchoolSubject.id', backref='instructor_subjects')
