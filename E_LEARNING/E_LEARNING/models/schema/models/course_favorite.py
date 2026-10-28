# coding: utf-8
from . import db, BaseModel


class CourseFavorite(db.Model):
    __tablename__ = 'course_favorite'

    id = db.Column(db.Integer, primary_key=True)
    course_id = db.Column(db.Integer)
    student_id = db.Column(db.Integer)
