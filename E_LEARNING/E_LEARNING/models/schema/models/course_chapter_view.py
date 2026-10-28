# coding: utf-8
from . import db, BaseModel


t_course_chapter_view = db.Table(
    'course_chapter_view',
    db.Column('course_title', db.String(1000)),
    db.Column('course_brief', db.String(4000)),
    db.Column('instructor_id', db.Integer),
    db.Column('num_of_chapters', db.Integer),
    db.Column('course_fee', db.Integer),
    db.Column('language_id', db.Integer),
    db.Column('school_subject_id', db.Integer),
    db.Column('is_course_visible', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('date_creation', db.DateTime),
    db.Column('date_update', db.DateTime),
    db.Column('language_name', db.String(50)),
    db.Column('language_code', db.String(2)),
    db.Column('school_id', db.Integer),
    db.Column('label_subject', db.String(200)),
    db.Column('code_qualification', db.String(45)),
    db.Column('education', db.String(200)),
    db.Column('level', db.String(200)),
    db.Column('label_qualification', db.String(200)),
    db.Column('id', db.Integer, server_default=db.FetchedValue()),
    db.Column('course_id', db.Integer),
    db.Column('chapter_title', db.String(1000)),
    db.Column('num_of_reading', db.Integer),
    db.Column('num_of_contents', db.Integer),
    db.Column('is_visible', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('sequence', db.Integer)
)
