# coding: utf-8
from . import db, BaseModel


t_dashboard_student_course_view = db.Table(
    'dashboard_student_course_view',
    db.Column('row_id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('student_id', db.Integer, server_default=db.FetchedValue()),
    db.Column('nbr_course', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('max_course_date_update', db.DateTime),
    db.Column('nbr_instructor', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('nbr_subject', db.BigInteger, server_default=db.FetchedValue())
)
