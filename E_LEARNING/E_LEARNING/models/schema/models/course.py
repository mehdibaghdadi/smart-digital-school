# coding: utf-8
from . import db, BaseModel

from .language import Language
from .school_subject import SchoolSubject
from .instructor import Instructor




class Course(db.Model):
    __tablename__ = 'course'

    id = db.Column(db.Integer, primary_key=True)
    course_title = db.Column(db.String(1000), nullable=False)
    course_brief = db.Column(db.String(4000), nullable=False)
    instructor_id = db.Column(db.ForeignKey('instructor.id'), nullable=False, index=True)
    num_of_chapters = db.Column(db.Integer, nullable=False)
    course_fee = db.Column(db.Integer, nullable=False)
    language_id = db.Column(db.ForeignKey('language.id'), nullable=False, index=True)
    school_subject_id = db.Column(db.ForeignKey('school_subject.id'), nullable=False, index=True)
    is_visible = db.Column(db.BIT(1), nullable=False)
    date_creation = db.Column(db.DateTime, nullable=False)
    date_update = db.Column(db.DateTime, nullable=False)

    instructor = db.relationship('Instructor', primaryjoin='Course.instructor_id == Instructor.id', backref='courses')
    language = db.relationship('Language', primaryjoin='Course.language_id == Language.id', backref='courses')
    school_subject = db.relationship('SchoolSubject', primaryjoin='Course.school_subject_id == SchoolSubject.id', backref='courses')
