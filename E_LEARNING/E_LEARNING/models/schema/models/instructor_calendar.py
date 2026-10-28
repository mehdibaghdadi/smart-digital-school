# coding: utf-8
from . import db, BaseModel

from .event_calendar import EventCalendar
from .instructor import Instructor




class InstructorCalendar(db.Model):
    __tablename__ = 'instructor_calendar'

    id = db.Column(db.BigInteger, primary_key=True)
    instructor_id = db.Column(db.ForeignKey('instructor.id', ondelete='CASCADE'), nullable=False, index=True)
    event_calendar_id = db.Column(db.ForeignKey('event_calendar.id'), nullable=False, index=True)
    title = db.Column(db.String(100), nullable=False)
    start = db.Column(db.DateTime, nullable=False)
    end = db.Column(db.DateTime)
    allDay = db.Column(db.BIT(1), nullable=False)
    backgroundColor = db.Column(db.String(10))

    event_calendar = db.relationship('EventCalendar', primaryjoin='InstructorCalendar.event_calendar_id == EventCalendar.id', backref='instructor_calendars')
    instructor = db.relationship('Instructor', primaryjoin='InstructorCalendar.instructor_id == Instructor.id', backref='instructor_calendars')
