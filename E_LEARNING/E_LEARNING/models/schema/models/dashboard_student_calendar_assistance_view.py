# coding: utf-8
from . import db, BaseModel


t_dashboard_student_calendar_assistance_view = db.Table(
    'dashboard_student_calendar_assistance_view',
    db.Column('row_id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('student_id', db.Integer),
    db.Column('count', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('min_date_demand', db.DateTime),
    db.Column('max_date_demand', db.DateTime)
)
