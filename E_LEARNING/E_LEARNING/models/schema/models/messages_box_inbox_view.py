# coding: utf-8
from . import db, BaseModel


t_messages_box_inbox_view = db.Table(
    'messages_box_inbox_view',
    db.Column('id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('user_sender_id', db.Integer),
    db.Column('user_sender_role', db.String(10)),
    db.Column('subject', db.String(255)),
    db.Column('date_update', db.DateTime, server_default=db.FetchedValue()),
    db.Column('to_trash', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('message_box_recipient_id', db.BigInteger, server_default=db.FetchedValue()),
    db.Column('user_recipient_id', db.Integer),
    db.Column('user_recipient_role', db.String(10)),
    db.Column('is_read', db.BIT(1), server_default=db.FetchedValue()),
    db.Column('user_sender_full_name', db.String(201)),
    db.Column('user_sender_email', db.String(255)),
    db.Column('user_recipient_full_name', db.String(201)),
    db.Column('user_recipient_email', db.String(255))
)
