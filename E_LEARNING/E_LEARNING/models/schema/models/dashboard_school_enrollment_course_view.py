# coding: utf-8
from . import db, BaseModel


t_dashboard_school_enrollment_course_view = db.Table(
    'dashboard_school_enrollment_course_view',
    db.Column('row_id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('school_id', db.Integer),
    db.Column('count_courses', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('count', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('min_enrollment_date', db.Date),
    db.Column('max_enrollment_date', db.Date)
)
