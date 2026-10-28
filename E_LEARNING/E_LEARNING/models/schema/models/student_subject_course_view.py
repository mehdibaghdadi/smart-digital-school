# coding: utf-8
from . import db, BaseModel


t_student_subject_course_view = db.Table(
    'student_subject_course_view',
    db.Column('student_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('school_id', db.Integer),
    db.Column('school_qualification_id', db.Integer),
    db.Column('school_subject_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('classroom', db.String(45)),
    db.Column('subject_id', db.Integer),
    db.Column('qualification_id', db.Integer),
    db.Column('label_subject', db.String(200)),
    db.Column('code', db.String(45)),
    db.Column('level', db.String(200)),
    db.Column('label_qualification', db.String(200)),
    db.Column('total_course', db.BigInteger, server_default=db.FetchedValue())
)
