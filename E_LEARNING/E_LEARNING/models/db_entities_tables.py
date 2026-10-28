
from datetime import datetime, date
from decimal import Decimal, ROUND_HALF_UP
from sqlalchemy import (
    BigInteger,
    VARCHAR,
    Index,
    Column,
    Date,
    DECIMAL,
    DateTime,
    ForeignKey,
    Integer,
    SmallInteger,
    String,
    Table,
    Unicode,
    text,
    Text,
    JSON,
    Enum,
    Boolean,
    UniqueConstraint,
    event,
    and_,
    not_,
)
from sqlalchemy.orm import relationship, raiseload, noload, lazyload, selectinload
from sqlalchemy.schema import FetchedValue
from sqlalchemy.dialects.mysql import BIT, BLOB, MEDIUMBLOB, MEDIUMTEXT
from sqlalchemy.ext.declarative import declarative_base
from .db_context import Base, EntitySerializer, AbstractConcreteBase, app, metadata
from sqlalchemy.ext.hybrid import hybrid_property
from flask_login import UserMixin, AnonymousUserMixin
from ..commun.database.db_enums import PAYMENT_STATUS

# ------------ LES TABLES ------------------------


class ContentType(Base, EntitySerializer):
    __tablename__ = "content_type"

    id = Column(Integer, primary_key=True)
    content_type = Column(String(20), nullable=False)


class Country(Base, EntitySerializer):
    __tablename__ = "country"

    id = Column(Integer, primary_key=True)
    country_fr = Column(String(100), nullable=False)
    country_en = Column(String(100), nullable=False)
    country_es = Column(String(100), nullable=False)
    country_ar = Column(String(100), nullable=True)


class CountryCity(Base, EntitySerializer):
    __tablename__ = "country_city"

    id = Column(Integer, primary_key=True)
    city = Column(String(40, "utf8mb4_0900_ai_ci"))
    region_id = Column(Integer, nullable=False)


class CountryRegion(Base, EntitySerializer):
    __tablename__ = "country_region"

    id = Column(Integer, primary_key=True)
    region = Column(String(40), nullable=False)


class Course(Base, EntitySerializer):
    __tablename__ = "course"

    id = Column(Integer, primary_key=True)
    course_title = Column(String(1000), nullable=False)
    course_brief = Column(String(4000), nullable=False)
    instructor_id = Column(ForeignKey("instructor.id"), nullable=False, index=True)
    num_of_chapters = Column(Integer, nullable=False)
    course_fee = Column(Integer, nullable=False)
    language_id = Column(ForeignKey("language.id"), nullable=False, index=True)
    school_subject_id = Column(
        ForeignKey("school_subject.id"), nullable=False, index=True
    )
    is_visible = Column(BIT(1), nullable=False)
    date_creation = Column(DateTime, nullable=False)
    date_update = Column(DateTime, nullable=False)
    date_start_course = Column(DateTime, nullable=False,default=datetime.utcnow)
    date_end_course = Column(DateTime, nullable=True)

    instructor = relationship(
        "Instructor",
        primaryjoin="Course.instructor_id == Instructor.id",
        backref="courses",
    )
    language = relationship(
        "Language", primaryjoin="Course.language_id == Language.id", backref="courses"
    )
    school_subject = relationship(
        "SchoolSubject",
        primaryjoin="Course.school_subject_id == SchoolSubject.id",
        backref="courses",
    )


class CourseChapter(Base, EntitySerializer):
    __tablename__ = "course_chapter"

    id = Column(Integer, primary_key=True)
    course_id = Column(ForeignKey("course.id"), nullable=False, index=True)
    chapter_title = Column(String(1000), nullable=False)
    chapter_description = Column(String(4000), nullable=True)
    num_of_reading = Column(Integer, nullable=False)
    num_of_contents = Column(Integer, nullable=False)
    is_visible = Column(BIT(1), nullable=False)
    sequence = Column(Integer, nullable=False)
    date_chapter_creation = Column(DateTime, nullable=True, default=datetime.utcnow)
    date_chapter_update = Column(DateTime, nullable=True,default=datetime.utcnow)

    course = relationship(
        "Course",
        primaryjoin="CourseChapter.course_id == Course.id",
        backref="course_chapters",
    )


class CourseChapterContent(Base, EntitySerializer):
    __tablename__ = "course_chapter_content"

    id = Column(Integer, primary_key=True)
    course_chapter_id = Column(
        ForeignKey("course_chapter.id"), nullable=False, index=True
    )
    content_type_id = Column(ForeignKey("content_type.id"), nullable=False, index=True)
    is_important = Column(BIT(1), nullable=False)
    time_required_in_sec = Column(Integer)
    is_open_for_free = Column(String(1), nullable=False)
    is_visible = Column(BIT(1), nullable=False)
    content_url = Column(String(2000))
    content_text = Column(MEDIUMTEXT)
    content_brief = Column(String(4000))
    date_creation = Column(DateTime, nullable=False)
    date_update = Column(DateTime, nullable=False)
    sequence = Column(Integer, nullable=False)
    content_cover_url = Column(String(2000))
    file_size_in_bytes = Column(Integer)

    content_type = relationship(
        "ContentType",
        primaryjoin="CourseChapterContent.content_type_id == ContentType.id",
        backref="course_chapter_contents",
    )
    course_chapter = relationship(
        "CourseChapter",
        primaryjoin="CourseChapterContent.course_chapter_id == CourseChapter.id",
        backref="course_chapter_contents",
    )


class Enrollment(Base, EntitySerializer):
    __tablename__ = "enrollment"

    id = Column(Integer, primary_key=True)
    student_id = Column(ForeignKey("student.id"), nullable=False, index=True)
    course_id = Column(ForeignKey("course.id"), nullable=False, index=True)
    enrollment_date = Column(Date, nullable=False)
    is_paid_subscription = Column(String(1), nullable=False)
    last_activity = Column(DateTime, nullable=False)

    course = relationship(
        "Course", primaryjoin="Enrollment.course_id == Course.id", backref="enrollments"
    )
    student = relationship(
        "Student",
        primaryjoin="Enrollment.student_id == Student.id",
        backref="enrollments",
    )


class EventCalendar(Base, EntitySerializer):
    __tablename__ = "event_calendar"

    id = Column(Integer, primary_key=True)
    event_calendar_fr = Column(String(45), nullable=False)
    event_calendar_en = Column(String(45), nullable=False)
    event_calendar_es = Column(String(45), nullable=False)


class Feedback(Base, EntitySerializer):
    __tablename__ = "feedback"

    id = Column(Integer, primary_key=True)
    enrollment_id = Column(ForeignKey("enrollment.id", ondelete="CASCADE"), nullable=False, index=True)
    rating_score = Column(Integer, nullable=False)
    feedback_text = Column(String(4000))
    submission_date = Column(Date, nullable=False)

    enrollment = relationship(
        "Enrollment",
        primaryjoin="Feedback.enrollment_id == Enrollment.id",
        backref="feedbacks",
    )


class Instructor(Base, UserMixin, EntitySerializer):
    __tablename__ = "instructor"

    id = Column(Integer, primary_key=True)
    school_id = Column(
        ForeignKey("school.id", ondelete="RESTRICT", onupdate="RESTRICT"),
        nullable=False,
        index=True,
    )
    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=False)
    email = Column(String(50), nullable=False)
    password = Column(String(255), nullable=False)
    date_birth = Column(Date)
    address = Column(String(1000))
    phone_primary = Column(String(45), nullable=False)
    phone_secondary = Column(String(45))
    registration_date = Column(Date, nullable=False)
    introduction_brief = Column(String(1000))
    image = Column(String(2000))
    num_of_published_courses = Column(Integer)
    num_of_enrolled_students = Column(Integer)
    average_review_rating = Column(Integer)
    num_of_reviews = Column(Integer)
    active_account = Column(BIT(1))
    country_city_id = Column(Integer)
    country_id = Column(Integer)

    school = relationship(
        "School", primaryjoin="Instructor.school_id == School.id", backref="instructors"
    )


class InstructorCalendar(Base, UserMixin, EntitySerializer):
    __tablename__ = "instructor_calendar"

    id = Column(BigInteger, primary_key=True)
    instructor_id = Column(
        ForeignKey("instructor.id", ondelete="CASCADE"), nullable=False, index=True
    )
    event_calendar_id = Column(
        ForeignKey("event_calendar.id"), nullable=False, index=True
    )
    title = Column(String(100), nullable=False)
    start = Column(DateTime, nullable=False)
    end = Column(DateTime)
    allDay = Column(BIT(1), nullable=False)
    backgroundColor = Column(String(10))
    event_description = Column(String(1000))

    event_calendar = relationship(
        "EventCalendar",
        primaryjoin="InstructorCalendar.event_calendar_id == EventCalendar.id",
        backref="instructor_calendars",
    )
    instructor = relationship(
        "Instructor",
        primaryjoin="InstructorCalendar.instructor_id == Instructor.id",
        backref="instructor_calendars",
    )


class InstructorCalendarAssistance(Base, UserMixin, EntitySerializer):
    __tablename__ = "instructor_calendar_assistance"

    id = Column(BigInteger, primary_key=True)
    instructor_calendar_id = Column(
        ForeignKey("instructor_calendar.id", ondelete="CASCADE"), index=True
    )
    student_id = Column(Integer, nullable=False)
    course_id = Column(Integer)
    course_chapter_id = Column(Integer)
    course_chapter_content_id = Column(Integer)
    date_demand = Column(DateTime, nullable=False)
    description_demand = Column(String(1000))
    accepted = Column(BIT(1))
    acceptance_date = Column(DateTime)
    response_demand = Column(MEDIUMTEXT)
    response_demand_link = Column(String(2000))
    attachment_url = Column(String(2000))

    instructor_calendar = relationship(
        "InstructorCalendar",
        primaryjoin="InstructorCalendarAssistance.instructor_calendar_id == InstructorCalendar.id",
        backref="instructor_calendar_assistances",
    )


class InstructorSubject(Base, EntitySerializer):
    __tablename__ = "instructor_subject"

    id = Column(Integer, primary_key=True)
    instructor_id = Column(ForeignKey("instructor.id"), nullable=False, index=True)
    school_subject_id = Column(
        ForeignKey("school_subject.id"), nullable=False, index=True
    )
    subject_price = Column(Integer, nullable=False, server_default=FetchedValue())
    classrooms_teaching = Column(
        String(500), nullable=False, server_default=FetchedValue()
    )

    instructor = relationship(
        "Instructor",
        primaryjoin="InstructorSubject.instructor_id == Instructor.id",
        backref="instructor_subjects",
    )
    school_subject = relationship(
        "SchoolSubject",
        primaryjoin="InstructorSubject.school_subject_id == SchoolSubject.id",
        backref="instructor_subjects",
    )


class Language(Base, EntitySerializer):
    __tablename__ = "language"

    id = Column(Integer, primary_key=True)
    language_name = Column(String(50), nullable=False)
    language_code = Column(String(2), nullable=False)


class LearningProgress(Base, EntitySerializer):
    __tablename__ = "learning_progress"

    id = Column(Integer, primary_key=True)
    enrollment_id = Column(ForeignKey("enrollment.id"), nullable=False, index=True)
    course_chapter_content_id = Column(
        ForeignKey("course_chapter_content.id"), nullable=False, index=True
    )
    begin_timestamp = Column(DateTime, nullable=False)
    completion_timestamp = Column(DateTime)
    status = Column(String(1), nullable=False)

    course_chapter_content = relationship(
        "CourseChapterContent",
        primaryjoin="LearningProgress.course_chapter_content_id == CourseChapterContent.id",
        backref="learning_progress",
    )
    enrollment = relationship(
        "Enrollment",
        primaryjoin="LearningProgress.enrollment_id == Enrollment.id",
        backref="learning_progress",
    )


class Qualification(Base, EntitySerializer):
    __tablename__ = "qualification"

    id = Column(Integer, primary_key=True)
    code = Column(String(45), nullable=False)
    label = Column(String(200), nullable=False)
    level = Column(String(45), nullable=False)
    education = Column(String(45))
    school_id = Column(ForeignKey("school.id"), nullable=False, index=True)

    school = relationship(
        "School",
        primaryjoin="Qualification.school_id == School.id",
        backref="qualifications",
    )


class SchoolQualification(Base, EntitySerializer):
    __tablename__ = "school_qualification"

    id = Column(Integer, primary_key=True)
    qualification_id = Column(
        ForeignKey("qualification.id"), nullable=False, index=True
    )
    school_id = Column(
        ForeignKey("school.id", ondelete="RESTRICT", onupdate="RESTRICT"),
        nullable=False,
        index=True,
    )
    nbr_class = Column(Integer, nullable=False, server_default=FetchedValue())
    classrooms_names = Column(
        String(500), nullable=False, server_default=FetchedValue()
    )

    qualification = relationship(
        "Qualification",
        primaryjoin="SchoolQualification.qualification_id == Qualification.id",
        backref="school_qualifications",
    )
    school = relationship(
        "School",
        primaryjoin="SchoolQualification.school_id == School.id",
        backref="school_qualifications",
    )


class SchoolType(Base, EntitySerializer):
    __tablename__ = "school_type"

    id = Column(Integer, primary_key=True)
    label_fr = Column(String(200), nullable=False)
    label_en = Column(String(200), nullable=False)
    label_es = Column(String(200), nullable=False)


class SchoolTypeQualification(Base, EntitySerializer):
    __tablename__ = "school_type_qualification"

    id = Column(Integer, primary_key=True)
    label_fr = Column(String(200), nullable=False)
    label_en = Column(String(200), nullable=False)
    label_es = Column(String(200), nullable=False)
    level_fr = Column(String(200), nullable=False)
    level_en = Column(String(200), nullable=False)
    level_es = Column(String(200), nullable=False)
    school_type_id = Column(ForeignKey("school_type.id"), index=True)

    school_type = relationship(
        "SchoolType",
        primaryjoin="SchoolTypeQualification.school_type_id == SchoolType.id",
        backref="school_type_qualifications",
    )


class SchoolTypeSubject(Base, EntitySerializer):
    __tablename__ = "school_type_subject"

    id = Column(Integer, primary_key=True)
    school_type_id = Column(
        ForeignKey("school_type_qualification.id"), nullable=False, index=True
    )
    label_fr = Column(String(200), nullable=False)
    label_en = Column(String(200), nullable=False)
    label_es = Column(String(200), nullable=False)

    school_type = relationship(
        "SchoolTypeQualification",
        primaryjoin="SchoolTypeSubject.school_type_id == SchoolTypeQualification.id",
        backref="school_type_subjects",
    )


class SchoolSubject(Base, EntitySerializer):
    __tablename__ = "school_subject"

    id = Column(Integer, primary_key=True, nullable=False)
    subject_id = Column(ForeignKey("subject.id"), nullable=False, index=True)
    qualification_id = Column(
        ForeignKey("qualification.id"), nullable=False, index=True
    )
    school_id = Column(
        ForeignKey("school.id"), primary_key=True, nullable=False, index=True
    )

    qualification = relationship(
        "Qualification",
        primaryjoin="SchoolSubject.qualification_id == Qualification.id",
        backref="school_subjects",
    )
    school = relationship(
        "School",
        primaryjoin="SchoolSubject.school_id == School.id",
        backref="school_subjects",
    )
    subject = relationship(
        "Subject",
        primaryjoin="SchoolSubject.subject_id == Subject.id",
        backref="school_subjects",
    )


class SchoolCalendar(Base, UserMixin, EntitySerializer):
    __tablename__ = "school_calendar"

    id = Column(BigInteger, primary_key=True)
    school_id = Column(
        ForeignKey("school.id", ondelete="CASCADE"), nullable=False, index=True
    )
    title = Column(String(100), nullable=False)
    start = Column(DateTime, nullable=False)
    end = Column(DateTime)
    allDay = Column(BIT(1), nullable=False)
    backgroundColor = Column(String(10))

    school = relationship(
        "School",
        primaryjoin="SchoolCalendar.school_id == School.id",
        backref="school_calendars",
    )


class Student(Base, UserMixin, EntitySerializer):
    __tablename__ = "student"

    id = Column(Integer, primary_key=True)
    school_id = Column(ForeignKey("school.id"), nullable=False, index=True)
    school_qualification_id = Column(
        ForeignKey("school_qualification.id", ondelete="RESTRICT", onupdate="RESTRICT"),
        nullable=False,
        index=True,
    )
    classroom = Column(String(45))
    first_name = Column(String(100))
    last_name = Column(String(100), nullable=False)
    email = Column(String(255), nullable=False)
    password = Column(String(255), nullable=False)
    date_birth = Column(Date)
    address = Column(String(1000))
    phone_primary = Column(String(45), nullable=False)
    phone_secondary = Column(String(45))
    registration_date = Column(Date, nullable=False)
    image = Column(String(2000))
    num_of_courses_enrolled = Column(Integer)
    num_of_courses_completed = Column(Integer)
    active_account = Column(BIT(1))
    country_city_id = Column(Integer)
    country_id = Column(Integer)

    school = relationship(
        "School", primaryjoin="Student.school_id == School.id", backref="students"
    )
    school_qualification = relationship(
        "SchoolQualification",
        primaryjoin="Student.school_qualification_id == SchoolQualification.id",
        backref="students",
    )


class Subject(Base, EntitySerializer):
    __tablename__ = "subject"

    id = Column(Integer, primary_key=True)
    label = Column(String(200), nullable=False)
    school_id = Column(ForeignKey("school.id"), nullable=False, index=True)

    school = relationship(
        "School", primaryjoin="Subject.school_id == School.id", backref="subjects"
    )


class CourseFavorite(Base, EntitySerializer):
    __tablename__ = "course_favorite"

    id = Column(Integer, primary_key=True)
    course_id = Column(Integer)
    student_id = Column(Integer)


class MessagesBoxRecipient(Base, EntitySerializer):
    __tablename__ = "messages_box_recipients"
    __table_args__ = (
        Index(
            "user_recipient_id",
            "user_recipient_id",
            "user_recipient_role",
            "message_box_id",
        ),
    )

    id = Column(BigInteger, primary_key=True)
    user_recipient_id = Column(Integer, nullable=False)
    user_recipient_role = Column(String(10), nullable=False)
    message_box_id = Column(
        ForeignKey("messages_box.id", ondelete="CASCADE"), nullable=False, index=True
    )
    is_read = Column(BIT(1), nullable=False)

    message_box = relationship(
        "MessagesBox",
        primaryjoin="MessagesBoxRecipient.message_box_id == MessagesBox.id",
        backref="messages_box_recipients",
        cascade="all, delete",
    )


class MessagesBox(Base, EntitySerializer):
    __tablename__ = "messages_box"

    id = Column(BigInteger, primary_key=True)
    user_sender_id = Column(Integer, nullable=False)
    user_sender_role = Column(String(10), nullable=False)
    subject = Column(String(255), nullable=False)
    body = Column(String, nullable=False)
    date_update = Column(DateTime, nullable=False, server_default=FetchedValue())
    to_trash = Column(BIT(1), nullable=False)


class School(Base, UserMixin, EntitySerializer):
    __tablename__ = "school"

    id = Column(Integer, primary_key=True)
    name = Column(String(50), nullable=False)
    email = Column(String(50), nullable=False)
    password = Column(String(255), nullable=False)
    address = Column(String(1000))
    phone_primary = Column(String(45), nullable=False)
    phone_secondary = Column(String(45))
    registration_date = Column(DateTime, nullable=False)
    introduction_brief = Column(String(1000))
    image = Column(String(2000))
    active_account = Column(BIT(1))
    country_city_id = Column(Integer)
    country_id = Column(Integer)
    school_type_id = Column(ForeignKey("school_type.id"), nullable=False, index=True)
    package_id = Column(ForeignKey("package.id"), nullable=True, index=True)
    renewal_date = Column(DateTime, nullable=True)

    package = relationship(
        "Package", primaryjoin="School.package_id == Package.id", backref="schools"
    )
    school_type = relationship(
        "SchoolType",
        primaryjoin="School.school_type_id == SchoolType.id",
        backref="schools",
    )


class Package(Base, EntitySerializer):
    __tablename__ = "package"

    id = Column(Integer, primary_key=True)
    name = Column(String(50), nullable=False)
    price_per_student = Column(DECIMAL(10, 2), nullable=False)
    min_students = Column(Integer, nullable=True)
    max_students = Column(Integer, nullable=True)
    max_teachers = Column(Integer, nullable=True)
    max_courses_per_prof = Column(Integer, nullable=True)
    duration_days = Column(Integer, nullable=True)
    discount_percentage = Column(DECIMAL(5, 2), default=0)
    discount_start_month = Column(Integer, default=0)
    featured = Column(BIT(1))
    support = Column(BIT(1))


class Payment(Base, EntitySerializer):
    __tablename__ = "payment"

    id = Column(Integer, primary_key=True)
    school_id = Column(ForeignKey("school.id"), nullable=False, index=True)
    package_id = Column(ForeignKey("package.id"), nullable=False, index=True)

    number_of_students = Column(Integer, nullable=False)
    number_of_months = Column(Integer, nullable=False)
    payment_method = Column(String(20), nullable=False)
    amount_paid_reel = Column(DECIMAL(10, 2), nullable=False, default=0)
    amount_paid_global = Column(DECIMAL(10, 2), nullable=False, default=0)
    discount_percentage = Column(Integer, nullable=True)
    payment_date = Column(DateTime, nullable=True)
    renewal_date = Column(DateTime, nullable=True)
    date_insert = Column(DateTime, nullable=False)

    payment_status = Column(String(2), nullable=False)
    transaction_reference = Column(String(255), nullable=True)

    package = relationship(
        "Package", primaryjoin="Payment.package_id == Package.id", backref="payments"
    )
    school = relationship(
        "School", primaryjoin="Payment.school_id == School.id", backref="payments"
    )

    @property
    def unused_days(self):
        try:
            finished = PAYMENT_STATUS.finished.id == self.payment_status
            today = date.today()

            if not self.renewal_date:
                return 0

            if isinstance(self.payment_date, datetime):
                payment_date = self.payment_date.date()
            else:
                payment_date = self.payment_date

            if isinstance(self.renewal_date, datetime):
                renewal_date = self.renewal_date.date()
            else:
                renewal_date = self.renewal_date

            remaining_days = (
                (renewal_date - today).days
                if finished
                else (renewal_date - payment_date).days
            )

            return remaining_days if remaining_days > 0 else 0

        except Exception as e:
            print(f"Error calculating unused_days: {e}")
            return 0

    @property
    def unused_amount(self):
        try:
            finished = PAYMENT_STATUS.finished.id == self.payment_status
            today = date.today()

            if not self.payment_date or not self.renewal_date:
                return Decimal("0.00")

            if isinstance(self.payment_date, datetime):
                payment_date = self.payment_date.date()
            else:
                payment_date = self.payment_date

            if isinstance(self.renewal_date, datetime):
                renewal_date = self.renewal_date.date()
            else:
                renewal_date = self.renewal_date

            remaining_days = (
                (renewal_date - today).days
                if finished
                else (renewal_date - payment_date).days
            )

            if remaining_days <= 0:
                return Decimal("0.00")

            total_days = (renewal_date - payment_date).days

            if total_days <= 0:
                return Decimal("0.00")

            daily_cost = Decimal(self.amount_paid_global) / Decimal(total_days)

            unused_value = daily_cost * Decimal(remaining_days)

            unused_value = unused_value.quantize(
                Decimal("0.00"), rounding=ROUND_HALF_UP
            )

            return round(unused_value)
        except Exception as e:
            print(f"Error calcul unused_amount : {e}")
            return Decimal("0.00")


# ---------------------------------------------------------------------------
# Quiz and Question
# ---------------------------------------------------------------------------
class Quiz(Base, EntitySerializer):
    __tablename__ = "quizzes"
    id = Column(Integer, primary_key=True, autoincrement=True)

    quiz_name = Column(String(8000), nullable=False)
    scope = Column(
        Enum("course", "chapter", "content", name="quiz_scope"), nullable=False
    )
    scope_id = Column(Integer, nullable=False)
    time_limit = Column(Integer, nullable=True)
    date_creation = Column(DateTime, nullable=True)
    date_update = Column(DateTime, nullable=True)
    sequence = Column(Integer, nullable=False)
    is_visible = Column(BIT(1), nullable=False,default=True)


    questions = relationship(
        "Question", backref="quiz", cascade="all, delete-orphan", passive_deletes=True
    )
    __table_args__ = (Index("ix_quiz_scope_scopeid", "scope", "scope_id"),)

    def __repr__(self):
        return f"<Quiz id={self.id} scope={self.scope} scope_id={self.scope_id}>"

class Question(Base, EntitySerializer):
    __tablename__ = "questions"

    id = Column(Integer, primary_key=True, autoincrement=True)
    idx = Column(Integer)
    question_text = Column(String(8000), nullable=False)
    choices = Column(
        Text, nullable=False
    ) 
    correct_answer = Column(Integer, nullable=False)

    quiz_id = Column(Integer, ForeignKey("quizzes.id"), nullable=False)

class StudentAnswer(Base, EntitySerializer):
    __tablename__ = "student_answers"

    id = Column(Integer, primary_key=True, autoincrement=True)
    student_id = Column(Integer, ForeignKey("student.id"), nullable=False)
    quiz_id = Column(Integer, ForeignKey("quizzes.id"), nullable=False)
    question_id = Column(Integer, ForeignKey("questions.id"), nullable=False)
    selected_choice_index = Column(Integer, nullable=False)
    begin_timestamp = Column(DateTime, nullable=False)
    end_timestamp = Column(DateTime, nullable=False, default=datetime.utcnow)

    __table_args__ = (
        UniqueConstraint("student_id", "quiz_id", "question_id", name="uq_answer_once"),
    )

class UserConnectionLog(Base, EntitySerializer):
    __tablename__ = "user_connection_log"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, nullable=False)
    role = Column(String(20), nullable=False) 
    ip_address = Column(String(45))
    user_agent = Column(String(255))
    timestamp = Column(DateTime, default=datetime.utcnow, nullable=False)
    os_name = Column(String(100), nullable=True)
    browser_name = Column(String(100), nullable=True)
    device_name = Column(String(100), nullable=True)
