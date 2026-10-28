# coding: utf-8
from . import db, BaseModel


t_instructor_calendar_assistance_view = db.Table(
    'instructor_calendar_assistance_view',
    db.Column('id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('instructor_calendar_id', db.BigInteger),
    db.Column('student_id', db.Integer),
    db.Column('course_id', db.Integer),
    db.Column('course_chapter_id', db.Integer),
    db.Column('course_chapter_content_id', db.Integer),
    db.Column('date_demand', db.DateTime),
    db.Column('description_demand', db.String(1000)),
    db.Column('accepted', db.BIT(1)),
    db.Column('acceptance_date', db.DateTime),
    db.Column('response_demand', db.String),
    db.Column('course_title', db.String(1000)),
    db.Column('instructor_id', db.Integer),
    db.Column('chapter_title', db.String(1000)),
    db.Column('content_brief', db.String(4000)),
    db.Column('student_last_name', db.String(100)),
    db.Column('student_first_name', db.String(100)),
    db.Column('instructor_last_name', db.String(50)),
    db.Column('instructor_first_name', db.String(50)),
    db.Column('school_id', db.Integer),
    db.Column('school_subject_id', db.Integer),
    db.Column('label_subject', db.String(200)),
    db.Column('education', db.String(200)),
    db.Column('level', db.String(200)),
    db.Column('label_qualification', db.String(200)),
    db.Column('classroom', db.String(45)),
    db.Column('attachment_url', db.String(2000))
)
