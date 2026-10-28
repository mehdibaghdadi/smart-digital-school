# coding: utf-8
from . import db, BaseModel


t_dashboard_school_course_view = db.Table(
    'dashboard_school_course_view',
    db.Column('row_id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('school_id', db.Integer),
    db.Column('is_visible', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('count', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('max_date_creation', db.DateTime),
    db.Column('max_date_update', db.DateTime)
)
