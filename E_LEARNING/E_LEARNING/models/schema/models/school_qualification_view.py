# coding: utf-8
from . import db, BaseModel


t_school_qualification_view = db.Table(
    'school_qualification_view',
    db.Column('id', db.Integer, server_default=db.FetchedValue()),
    db.Column('code', db.String(45)),
    db.Column('label', db.String(200)),
    db.Column('level', db.String(200)),
    db.Column('education', db.String(200)),
    db.Column('nbr_class', db.Integer, server_default=db.FetchedValue()),
    db.Column('classrooms_names', db.String(500)),
    db.Column('school_qualification_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('qualification_id', db.Integer),
    db.Column('school_id', db.Integer)
)
