# coding: utf-8
from . import db, BaseModel

from .course_chapter import CourseChapter
from .content_type import ContentType




class CourseChapterContent(db.Model):
    __tablename__ = 'course_chapter_content'

    id = db.Column(db.Integer, primary_key=True)
    course_chapter_id = db.Column(db.ForeignKey('course_chapter.id'), nullable=False, index=True)
    content_type_id = db.Column(db.ForeignKey('content_type.id'), nullable=False, index=True)
    is_important = db.Column(db.BIT(1), nullable=False)
    time_required_in_sec = db.Column(db.Integer, nullable=False)
    is_open_for_free = db.Column(db.String(1), nullable=False)
    is_visible = db.Column(db.BIT(1), nullable=False)
    content_url = db.Column(db.String(2000))
    content_text = db.Column(db.String)
    content_brief = db.Column(db.String(4000))
    date_creation = db.Column(db.DateTime, nullable=False)
    date_update = db.Column(db.DateTime, nullable=False)
    sequence = db.Column(db.Integer, nullable=False)

    content_type = db.relationship('ContentType', primaryjoin='CourseChapterContent.content_type_id == ContentType.id', backref='course_chapter_contents')
    course_chapter = db.relationship('CourseChapter', primaryjoin='CourseChapterContent.course_chapter_id == CourseChapter.id', backref='course_chapter_contents')
