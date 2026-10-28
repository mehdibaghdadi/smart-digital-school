# coding: utf-8
from . import db, BaseModel


t_course_chapter_progress_view = db.Table(
    'course_chapter_progress_view',
    db.Column('enrollment_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('student_id', db.Integer),
    db.Column('course_id', db.Integer),
    db.Column('course_chapter_id', db.Integer),
    db.Column('total_chapter', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('chapter_completion_percentage', db.Numeric(27, 0)),
    db.Column('course_completion_percentage', db.Numeric(27, 0))
)
