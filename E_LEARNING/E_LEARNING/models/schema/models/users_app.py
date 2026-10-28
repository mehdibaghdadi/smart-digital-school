# coding: utf-8
from . import db, BaseModel


t_users_app = db.Table(
    'users_app',
    db.Column('id', db.Integer, server_default=db.FetchedValue()),
    db.Column('email', db.String(255)),
    db.Column('password', db.String(255)),
    db.Column('phone_primary', db.String(45)),
    db.Column('active_account', db.BIT(1)),
    db.Column('role', db.String(10)),
    db.Column('full_name', db.String(201)),
    db.Column('school_type_id', db.Integer, server_default=db.FetchedValue())
)
