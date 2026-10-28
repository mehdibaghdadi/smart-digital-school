# coding: utf-8
from . import db, BaseModel


t_instructor_calendar_view = db.Table(
    'instructor_calendar_view',
    db.Column('id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('instructor_id', db.Integer),
    db.Column('event_calendar_id', db.Integer),
    db.Column('title', db.String(100)),
    db.Column('start', db.DateTime),
    db.Column('end', db.DateTime),
    db.Column('allDay', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('backgroundColor', db.String(10))
)
