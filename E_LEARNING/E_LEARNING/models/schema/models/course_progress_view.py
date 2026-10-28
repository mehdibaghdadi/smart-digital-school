# coding: utf-8
from . import db, BaseModel


t_course_progress_view = db.Table(
    'course_progress_view',
    db.Column('enrollment_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('student_id', db.Integer),
    db.Column('course_id', db.Integer),
    db.Column('course_completion_percentage', db.Numeric(27, 0))
)
