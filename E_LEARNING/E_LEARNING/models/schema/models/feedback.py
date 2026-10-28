# coding: utf-8
from . import db, BaseModel

from .enrollment import Enrollment




class Feedback(db.Model):
    __tablename__ = 'feedback'

    id = db.Column(db.Integer, primary_key=True)
    enrollment_id = db.Column(db.ForeignKey('enrollment.id'), nullable=False, index=True)
    rating_score = db.Column(db.Integer, nullable=False)
    feedback_text = db.Column(db.String(4000))
    submission_date = db.Column(db.Date, nullable=False)

    enrollment = db.relationship('Enrollment', primaryjoin='Feedback.enrollment_id == Enrollment.id', backref='feedbacks')
