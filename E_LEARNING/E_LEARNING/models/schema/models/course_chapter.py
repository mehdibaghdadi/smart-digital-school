# coding: utf-8
from . import db, BaseModel

from .course import Course




class CourseChapter(db.Model):
    __tablename__ = 'course_chapter'

    id = db.Column(db.Integer, primary_key=True)
    course_id = db.Column(db.ForeignKey('course.id'), nullable=False, index=True)
    chapter_title = db.Column(db.String(1000), nullable=False)
    num_of_reading = db.Column(db.Integer, nullable=False)
    num_of_contents = db.Column(db.Integer, nullable=False)
    is_visible = db.Column(db.BIT(1), nullable=False)
    sequence = db.Column(db.Integer, nullable=False)

    course = db.relationship('Course', primaryjoin='CourseChapter.course_id == Course.id', backref='course_chapters')
