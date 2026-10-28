# coding: utf-8
from . import db, BaseModel

from .instructor_calendar import InstructorCalendar




class InstructorCalendarAssistance(db.Model):
    __tablename__ = 'instructor_calendar_assistance'

    id = db.Column(db.BigInteger, primary_key=True)
    instructor_calendar_id = db.Column(db.ForeignKey('instructor_calendar.id', ondelete='CASCADE'), index=True)
    student_id = db.Column(db.Integer, nullable=False)
    course_id = db.Column(db.Integer, nullable=False)
    course_chapter_id = db.Column(db.Integer, nullable=False)
    course_chapter_content_id = db.Column(db.Integer, nullable=False)
    date_demand = db.Column(db.DateTime, nullable=False)
    description_demand = db.Column(db.String(1000))
    accepted = db.Column(db.BIT(1))
    acceptance_date = db.Column(db.DateTime)
    response_demand = db.Column(db.String)
    attachment_url = db.Column(db.String(2000))

    instructor_calendar = db.relationship('InstructorCalendar', primaryjoin='InstructorCalendarAssistance.instructor_calendar_id == InstructorCalendar.id', backref='instructor_calendar_assistances')
