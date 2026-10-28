# coding: utf-8
from . import db, BaseModel


t_country_region_city = db.Table(
    'country_region_city',
    db.Column('region', db.String(40)),
    db.Column('id', db.Integer, server_default=db.FetchedValue()),
    db.Column('city', db.String(40)),
    db.Column('region_id', db.Integer)
)
