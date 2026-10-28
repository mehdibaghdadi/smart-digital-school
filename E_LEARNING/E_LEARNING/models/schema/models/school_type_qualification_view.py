# coding: utf-8
from . import db, BaseModel


t_school_type_qualification_view = db.Table(
    'school_type_qualification_view',
    db.Column('id', db.Integer, server_default=db.FetchedValue()),
    db.Column('label_fr', db.String(200)),
    db.Column('label_en', db.String(200)),
    db.Column('label_es', db.String(200)),
    db.Column('level_fr', db.String(200)),
    db.Column('level_en', db.String(200)),
    db.Column('level_es', db.String(200)),
    db.Column('school_type_id', db.Integer),
    db.Column('school_type_fr', db.String(200)),
    db.Column('school_type_en', db.String(200)),
    db.Column('school_type_es', db.String(200))
)
