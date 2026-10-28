# coding: utf-8
from . import db, BaseModel

from .school_type import SchoolType
from .package import Package




class School(db.Model):
    __tablename__ = 'school'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    password = db.Column(db.String(255), nullable=False)
    address = db.Column(db.String(1000))
    phone_primary = db.Column(db.String(45), nullable=False)
    phone_secondary = db.Column(db.String(45))
    registration_date = db.Column(db.Date, nullable=False)
    introduction_brief = db.Column(db.String(1000))
    image = db.Column(db.MEDIUMBLOB)
    active_account = db.Column(db.BIT(1))
    country_city_id = db.Column(db.Integer)
    country_id = db.Column(db.Integer)
    school_type_id = db.Column(db.ForeignKey('school_type.id'), nullable=False, index=True)
    package_id = db.Column(db.ForeignKey('package.id'), index=True)

    package = db.relationship('Package', primaryjoin='School.package_id == Package.id', backref='schools')
    school_type = db.relationship('SchoolType', primaryjoin='School.school_type_id == SchoolType.id', backref='schools')
