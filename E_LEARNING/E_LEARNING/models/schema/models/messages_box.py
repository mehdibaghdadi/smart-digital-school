# coding: utf-8
from . import db, BaseModel


class MessagesBox(db.Model):
    __tablename__ = 'messages_box'

    id = db.Column(db.BigInteger, primary_key=True)
    user_sender_id = db.Column(db.Integer, nullable=False)
    user_sender_role = db.Column(db.String(10), nullable=False)
    subject = db.Column(db.String(255), nullable=False)
    body = db.Column(db.String, nullable=False)
    date_update = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
    to_trash = db.Column(db.BIT(1), nullable=False)
