# coding: utf-8
from . import db, BaseModel


t_student_profile = db.Table(
    'student_profile',
    db.Column('id', db.Integer, server_default=db.FetchedValue()),
    db.Column('school_id', db.Integer),
    db.Column('first_name', db.String(100)),
    db.Column('last_name', db.String(100)),
    db.Column('email', db.String(255)),
    db.Column('password', db.String(255)),
    db.Column('address', db.String(1000)),
    db.Column('phone_primary', db.String(45)),
    db.Column('phone_secondary', db.String(45)),
    db.Column('registration_date', db.Date),
    db.Column('active_account', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('image', db.MEDIUMBLOB),
    db.Column('country_city_id', db.Integer),
    db.Column('country_id', db.Integer),
    db.Column('school_qualification_id', db.Integer),
    db.Column('education', db.String(200)),
    db.Column('classroom', db.String(45)),
    db.Column('level', db.String(200)),
    db.Column('qualification', db.String(200))
)
