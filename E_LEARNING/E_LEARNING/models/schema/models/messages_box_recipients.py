# coding: utf-8
from . import db, BaseModel

from .messages_box import MessagesBox




class MessagesBoxRecipient(db.Model):
    __tablename__ = 'messages_box_recipients'
    __table_args__ = (
        db.Index('user_recipient_id', 'user_recipient_id', 'user_recipient_role', 'message_box_id'),
    )

    id = db.Column(db.BigInteger, primary_key=True)
    user_recipient_id = db.Column(db.Integer, nullable=False)
    user_recipient_role = db.Column(db.String(10), nullable=False)
    message_box_id = db.Column(db.ForeignKey('messages_box.id', ondelete='CASCADE'), nullable=False, index=True)
    is_read = db.Column(db.BIT(1), nullable=False)

    message_box = db.relationship('MessagesBox', primaryjoin='MessagesBoxRecipient.message_box_id == MessagesBox.id', backref='messages_box_recipients')
