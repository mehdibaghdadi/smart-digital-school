# coding: utf-8
from . import db, BaseModel


t_course_chapter_content_view = db.Table(
    'course_chapter_content_view',
    db.Column('chapter_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('course_id', db.Integer),
    db.Column('chapter_title', db.String(1000)),
    db.Column('num_of_reading', db.Integer),
    db.Column('num_of_contents', db.Integer),
    db.Column('chapter_is_visible', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('chapter_sequence', db.Integer),
    db.Column('content_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('content_type_id', db.Integer),
    db.Column('is_important', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('time_required_in_sec', db.Integer),
    db.Column('is_open_for_free', db.String(1)),
    db.Column('content_is_visible', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('content_url', db.String(2000)),
    db.Column('content_text', db.String),
    db.Column('content_brief', db.String(4000)),
    db.Column('date_creation', db.DateTime),
    db.Column('date_update', db.DateTime),
    db.Column('content_sequence', db.Integer),
    db.Column('content_type', db.String(20))
)
