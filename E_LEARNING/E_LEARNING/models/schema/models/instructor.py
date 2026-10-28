# coding: utf-8
from . import db, BaseModel

from .school import School




class Instructor(db.Model):
    __tablename__ = 'instructor'

    id = db.Column(db.Integer, primary_key=True)
    school_id = db.Column(db.ForeignKey('school.id', ondelete='RESTRICT', onupdate='RESTRICT'), nullable=False, index=True)
    first_name = db.Column(db.String(50), nullable=False)
    last_name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    password = db.Column(db.String(255), nullable=False)
    address = db.Column(db.String(1000))
    phone_primary = db.Column(db.String(45), nullable=False)
    phone_secondary = db.Column(db.String(45))
    registration_date = db.Column(db.Date, nullable=False)
    introduction_brief = db.Column(db.String(1000))
    image = db.Column(db.MEDIUMBLOB)
    num_of_published_courses = db.Column(db.Integer)
    num_of_enrolled_students = db.Column(db.Integer)
    average_review_rating = db.Column(db.Integer)
    num_of_reviews = db.Column(db.Integer)
    active_account = db.Column(db.BIT(1))
    country_city_id = db.Column(db.Integer)
    country_id = db.Column(db.Integer)

    school = db.relationship('School', primaryjoin='Instructor.school_id == School.id', backref='instructors')
