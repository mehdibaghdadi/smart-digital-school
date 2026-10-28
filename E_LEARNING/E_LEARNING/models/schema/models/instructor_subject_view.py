# coding: utf-8
from . import db, BaseModel


t_instructor_subject_view = db.Table(
    'instructor_subject_view',
    db.Column('id', db.Integer, server_default=db.FetchedValue()),
    db.Column('school_subject_id', db.Integer),
    db.Column('school_qualification_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('instructor_id', db.Integer),
    db.Column('subject_id', db.Integer),
    db.Column('qualification_id', db.Integer),
    db.Column('school_id', db.Integer),
    db.Column('label_subject', db.String(200)),
    db.Column('code', db.String(45)),
    db.Column('label_qualification', db.String(200)),
    db.Column('level', db.String(200)),
    db.Column('education', db.String(200)),
    db.Column('classrooms_teaching', db.String(500))
)
