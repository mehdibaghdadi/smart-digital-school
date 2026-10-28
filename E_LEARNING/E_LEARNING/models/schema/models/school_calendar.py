# coding: utf-8
from . import db, BaseModel

from .school import School




class SchoolCalendar(db.Model):
    __tablename__ = 'school_calendar'

    id = db.Column(db.BigInteger, primary_key=True)
    school_id = db.Column(db.ForeignKey('school.id', ondelete='CASCADE'), nullable=False, index=True)
    title = db.Column(db.String(100), nullable=False)
    start = db.Column(db.DateTime, nullable=False)
    end = db.Column(db.DateTime)
    allDay = db.Column(db.BIT(1), nullable=False)
    backgroundColor = db.Column(db.String(10))

    school = db.relationship('School', primaryjoin='SchoolCalendar.school_id == School.id', backref='school_calendars')
