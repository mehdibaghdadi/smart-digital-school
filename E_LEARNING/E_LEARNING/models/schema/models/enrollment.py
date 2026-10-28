# coding: utf-8
from . import db, BaseModel

from .course import Course
from .student import Student




class Enrollment(db.Model):
    __tablename__ = 'enrollment'

    id = db.Column(db.Integer, primary_key=True)
    student_id = db.Column(db.ForeignKey('student.id'), nullable=False, index=True)
    course_id = db.Column(db.ForeignKey('course.id', ondelete='CASCADE'), nullable=False, index=True)
    enrollment_date = db.Column(db.Date, nullable=False)
    is_paid_subscription = db.Column(db.String(1), nullable=False)
    last_activity = db.Column(db.DateTime)

    course = db.relationship('Course', primaryjoin='Enrollment.course_id == Course.id', backref='enrollments')
    student = db.relationship('Student', primaryjoin='Enrollment.student_id == Student.id', backref='enrollments')
