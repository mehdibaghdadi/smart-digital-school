# coding: utf-8
from . import db, BaseModel


class EventCalendar(db.Model):
    __tablename__ = 'event_calendar'

    id = db.Column(db.Integer, primary_key=True)
    event_calendar_fr = db.Column(db.String(45, 'utf8mb4_0900_ai_ci'), nullable=False)
    event_calendar_en = db.Column(db.String(45, 'utf8mb4_0900_ai_ci'), nullable=False)
    event_calendar_es = db.Column(db.String(45, 'utf8mb4_0900_ai_ci'), nullable=False)
