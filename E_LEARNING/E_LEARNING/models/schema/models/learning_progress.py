# coding: utf-8
from . import db, BaseModel

from .enrollment import Enrollment
from .course_chapter_content import CourseChapterContent




class LearningProgres(db.Model):
    __tablename__ = 'learning_progress'

    id = db.Column(db.Integer, primary_key=True)
    enrollment_id = db.Column(db.ForeignKey('enrollment.id', ondelete='CASCADE', onupdate='RESTRICT'), nullable=False, index=True)
    course_chapter_content_id = db.Column(db.ForeignKey('course_chapter_content.id'), nullable=False, index=True)
    begin_timestamp = db.Column(db.DateTime, nullable=False)
    completion_timestamp = db.Column(db.DateTime)
    status = db.Column(db.String(1), nullable=False)

    course_chapter_content = db.relationship('CourseChapterContent', primaryjoin='LearningProgres.course_chapter_content_id == CourseChapterContent.id', backref='learning_progress')
    enrollment = db.relationship('Enrollment', primaryjoin='LearningProgres.enrollment_id == Enrollment.id', backref='learning_progress')
