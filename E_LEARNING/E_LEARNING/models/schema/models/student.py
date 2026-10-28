# coding: utf-8
from . import db, BaseModel

from .school_qualification import SchoolQualification
from .school import School




class Student(db.Model):
    __tablename__ = 'student'

    id = db.Column(db.Integer, primary_key=True)
    school_id = db.Column(db.ForeignKey('school.id'), nullable=False, index=True)
    school_qualification_id = db.Column(db.ForeignKey('school_qualification.id', ondelete='RESTRICT', onupdate='RESTRICT'), nullable=False, index=True)
    classroom = db.Column(db.String(45), nullable=False, server_default=db.FetchedValue())
    first_name = db.Column(db.String(100))
    last_name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(255), nullable=False)
    password = db.Column(db.String(255), nullable=False)
    address = db.Column(db.String(1000))
    phone_primary = db.Column(db.String(45), nullable=False)
    phone_secondary = db.Column(db.String(45))
    registration_date = db.Column(db.Date, nullable=False)
    image = db.Column(db.MEDIUMBLOB)
    num_of_courses_enrolled = db.Column(db.Integer)
    num_of_courses_completed = db.Column(db.Integer)
    active_account = db.Column(db.BIT(1))
    country_city_id = db.Column(db.Integer)
    country_id = db.Column(db.Integer)

    school = db.relationship('School', primaryjoin='Student.school_id == School.id', backref='students')
    school_qualification = db.relationship('SchoolQualification', primaryjoin='Student.school_qualification_id == SchoolQualification.id', backref='students')
