# coding: utf-8
from . import db, BaseModel


t_learning_progress_view = db.Table(
    'learning_progress_view',
    db.Column('row_id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('enrollment_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('student_id', db.Integer),
    db.Column('course_id', db.Integer),
    db.Column('course_chapter_id', db.Integer),
    db.Column('course_chapter_content_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('begin_timestamp', db.DateTime),
    db.Column('completion_timestamp', db.DateTime),
    db.Column('status', db.String(1)),
    db.Column('enrollment_date', db.Date),
    db.Column('last_activity', db.DateTime)
)
