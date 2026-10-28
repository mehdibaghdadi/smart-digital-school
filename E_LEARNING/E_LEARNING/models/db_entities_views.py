from .db_entities_tables import *
from sqlalchemy.orm import column_property,aliased
from sqlalchemy import cast


# ------------ LES VUES------------------------

class CourseProgressView(Base, EntitySerializer):
    __table__ = Table('course_progress_view',metadata,
    Column('enrollment_id', Integer,  primary_key=True),
    Column('student_id', Integer),
    Column('course_id', Integer),
    Column('course_completion_percentage', DECIMAL(27, 0))
)
    
class CourseCapterProgressView(Base, EntitySerializer):
    __table__ = Table('course_chapter_progress_view',metadata,
    Column('enrollment_id', Integer,  primary_key=True),
    Column('student_id', Integer),
    Column('course_id', Integer),
    Column('course_chapter_id', Integer),
    Column('total_chapter', BigInteger),
    Column('chapter_completion_percentage', DECIMAL(27, 0)),
    Column('course_completion_percentage', DECIMAL(27, 0))
)


class LearningProgressView(Base, EntitySerializer):
    __table__ = Table(
        "learning_progress_view",
        metadata,
        Column("row_id", Integer, primary_key=True),
        Column("id", Integer),
        Column("enrollment_id", Integer),
        Column("student_id", Integer),
        Column("course_id", Integer),
        Column("school_subject_id", Integer),
        Column("course_chapter_id", Integer),
        Column("course_chapter_content_id", Integer),
        Column("begin_timestamp", DateTime),
        Column("completion_timestamp", DateTime),
        Column("status", String(1)),
        Column("enrollment_date", Date),
        Column("last_activity", DateTime)
    )


class EnrollmentCourseView(Base, EntitySerializer):
    __table__ = Table(
        "enrollment_course_view",
        metadata,
        Column("enrollment_id", primary_key=True),
        Column("id", Integer, server_default=FetchedValue()),
        Column("course_id", Integer, server_default=FetchedValue()),
        Column("course_title", String(1000)),
        Column("course_brief", String(4000)),
        Column("instructor_id", Integer),
        Column("num_of_chapters", Integer),
        Column("course_fee", Integer),
        Column("language_id", Integer),
        Column("school_subject_id", Integer),
        Column("is_visible", BIT(1), server_default=FetchedValue()),
        Column("date_creation", DateTime),
        Column("date_update", DateTime),
        Column("language_name", String(50)),
        Column("school_id", Integer),
        Column("label_subject", String(200)),
        Column("code_qualification", String(45)),
        Column("education", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
        Column("enrollment_date", Date),
        Column("last_activity", DateTime),
        Column("student_id", Integer),
        Column("student_first_name", String(100)),
        Column("student_last_name", String(100)),
        Column("classroom", String(45)),
    )


class InstructorSubjectClassroomView(Base, EntitySerializer):
    __table__ = Table(
        "instructor_subject_classroom_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("instructor_id", Integer),
        Column("school_subject_id", Integer),
        Column("school_qualification_id", Integer, server_default=FetchedValue()),
        Column("subject_price", Integer, server_default=FetchedValue()),
        Column("subject_id", Integer),
        Column("qualification_id", Integer),
        Column("school_id", Integer),
        Column("label_subject", String(200)),
        Column("code", String(45)),
        Column("label_qualification", String(200)),
        Column("level", String(45)),
        Column("education", String(45)),
        Column("classroom", String(50)),
    )


class InstructorSubjectView(Base, EntitySerializer):

    __table__ = Table(
        "instructor_subject_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("school_subject_id", Integer),
        Column("school_qualification_id", Integer),
        Column("instructor_id", Integer),
        Column("subject_id", Integer),
        Column("qualification_id", Integer),
        Column("school_id", Integer),
        Column("label_subject", String(200)),
        Column("code", String(45)),
        Column("label_qualification", String(200)),
        Column("level", String(45)),
        Column("education", String(45)),
        Column("classrooms_teaching", String(500)),
    )


class StudentInstructorCalendarAssistanceView(Base, EntitySerializer):
    __table__ = Table(
        "student_instructor_calendar_assistance_view",
        metadata,
        Column("id", BigInteger, primary_key=True),
        Column("instructor_calendar_id", BigInteger),
        Column("student_id", Integer),
        Column("course_id", Integer),
        Column("course_chapter_id", Integer),
        Column("course_chapter_content_id", Integer),
        Column("date_demand", DateTime),
        Column("description_demand", String(1000)),
        Column("accepted", BIT(1)),
        Column("acceptance_date", DateTime),
        Column("response_demand", MEDIUMTEXT),
        Column("response_demand_link", String(2000)),
        Column("course_title", String(1000)),
        Column("instructor_id", Integer),
        Column("chapter_title", String(1000)),
        Column("content_brief", String(4000)),
        Column("student_last_name", String(100)),
        Column("student_first_name", String(100)),
        Column("classroom", String(45)),
        Column("instructor_last_name", String(50)),
        Column("instructor_first_name", String(50)),
        Column("school_subject_id", Integer),
        Column("label_subject", String(200)),
        Column("education", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
        Column("event_calendar_id", Integer),
        Column("pl_title", String(100)),
        Column("pl_start", DateTime),
        Column("pl_end", DateTime),
        Column("pl_allday", BIT(1), server_default=FetchedValue()),
        Column("pl_event_description", String(1000)),
        Column("pl_backgroundColor", String(10)),
        Column("attachment_url", String(2000)),
    )


class InstructorCalendarAssistanceCountView(Base, EntitySerializer):
    __table__ = Table(
        "instructor_calendar_assistance_count_view",
        metadata,
        Column("id", BigInteger, primary_key=True),
        Column("instructor_id", Integer),
        Column("event_calendar_id", Integer),
        Column("title", String(100)),
        Column("start", DateTime),
        Column("end", DateTime),
        Column("allDay", BIT(1), server_default=FetchedValue()),
        Column("event_description", String(1000)),
        Column("backgroundColor", String(10)),
        Column("count_assistance", BigInteger, server_default=FetchedValue()),
        Column("list_instructor_calendar_assistance_ids", Text),
    )


class InstructorCalendarView(Base, EntitySerializer):
    __table__ = Table(
        "instructor_calendar_view",
        metadata,
        Column("id", BigInteger, primary_key=True),
        Column("instructor_id", Integer),
        Column("event_calendar_id", Integer),
        Column("title", String(100)),
        Column("start", DateTime),
        Column("end", DateTime),
        Column("allDay", BIT(1), server_default=FetchedValue()),
        Column("event_description", String(1000)),
        Column("backgroundColor", String(10)),
    )


class StudentCalendarAssistanceCountView(Base, EntitySerializer):
    __table__ = Table(
        "student_calendar_assistance_count_view",
        metadata,
        Column("id", BigInteger, primary_key=True),
        Column("instructor_id", Integer),
        Column("student_id", Integer),
        Column("event_calendar_id", Integer),
        Column("title", String(100)),
        Column("start", DateTime),
        Column("end", DateTime),
        Column("allDay", BIT(1), server_default=FetchedValue()),
        Column("event_description", String(1000)),
        Column("backgroundColor", String(10)),
        Column("count_assistance", BigInteger, server_default=FetchedValue()),
        Column("list_instructor_calendar_assistance_ids", Text),
    )


class DashboardInstructorCalendarAssistanceView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_instructor_calendar_assistance_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("instructor_id", Integer),
        Column("count", BigInteger, server_default=FetchedValue()),
        Column("min_date_demand", DateTime),
        Column("max_date_demand", DateTime),
    )


class DashboardStudentCalendarAssistanceView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_student_calendar_assistance_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("student_id", Integer),
        Column("count", BigInteger, server_default=FetchedValue()),
        Column("min_date_demand", DateTime),
        Column("max_date_demand", DateTime),
    )


class DashboardSchoolCalendarAssistanceView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_school_calendar_assistance_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("school_id", Integer),
        Column("count", BigInteger, server_default=FetchedValue()),
        Column("min_date_demand", DateTime),
        Column("max_date_demand", DateTime),
    )


class InstructorCalendarAssistanceView(Base, EntitySerializer):
    __table__ = Table(
        "instructor_calendar_assistance_view",
        metadata,
        Column("id", BigInteger, primary_key=True),
        Column("instructor_calendar_id", BigInteger),
        Column("student_id", Integer),
        Column("course_id", Integer),
        Column("course_chapter_id", Integer),
        Column("course_chapter_content_id", Integer),
        Column("date_demand", DateTime),
        Column("description_demand", String(1000)),
        Column("accepted", BIT(1)),
        Column("acceptance_date", DateTime),
        Column("response_demand", MEDIUMTEXT),
        Column("response_demand_link", String(2000)),
        Column("course_title", String(1000)),
        Column("instructor_id", Integer),
        Column("chapter_title", String(1000)),
        Column("content_brief", String(4000)),
        Column("student_last_name", String(100)),
        Column("student_first_name", String(100)),
        Column("instructor_last_name", String(50)),
        Column("instructor_first_name", String(50)),
        Column("school_subject_id", Integer),
        Column("label_subject", String(200)),
        Column("education", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
        Column("classroom", String(45)),
        Column("attachment_url", String(2000)),
    )


class CourseInstructorEnrollmentView(Base, EntitySerializer):
    __table__ = Table(
        "course_instructor_enrollment_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("course_title", String(1000)),
        Column("course_brief", String(4000)),
        Column("instructor_id", Integer),
        Column("num_of_chapters", Integer),
        Column("course_fee", Integer),
        Column("language_id", Integer),
        Column("school_subject_id", Integer),
        Column("is_visible", BIT(1), server_default=FetchedValue()),
        Column("date_creation", DateTime),
        Column("date_update", DateTime),
        Column("date_start_course", DateTime),
        Column("date_end_course", DateTime),
        Column("language_name", String(50)),
        Column("school_id", Integer),
        Column("label_subject", String(200)),
        Column("code_qualification", String(45)),
        Column("education", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
        Column("first_name", String(50)),
        Column("last_name", String(50)),
        Column("active_account", BIT(1), server_default=FetchedValue()),
        Column("email", String(50)),
        Column("num_of_published_courses", Integer),
        Column("enrollment_id", Integer),
        Column("student_id", Integer),
        Column("enrollment_date", Date),
        Column("last_activity", DateTime),
    )


class DashboardStudentCourseView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_student_course_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("student_id", Integer),
        Column("nbr_course", BigInteger, server_default=FetchedValue()),
        Column("max_course_date_update", DateTime),
        Column("nbr_instructor", BigInteger, server_default=FetchedValue()),
        Column("nbr_subject", BigInteger, server_default=FetchedValue()),
    )


class DashboardSchoolCourseView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_school_course_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("school_id", Integer),
        Column("is_visible", BIT(1), server_default=FetchedValue()),
        Column("count", BigInteger, server_default=FetchedValue()),
        Column("max_date_creation", DateTime),
        Column("max_date_update", DateTime),
    )


class DashboardInstructorCourseView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_instructor_course_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("instructor_id", Integer),
        Column("is_visible", BIT(1), server_default=FetchedValue()),
        Column("count", BigInteger, server_default=FetchedValue()),
        Column("max_date_creation", DateTime),
        Column("max_date_update", DateTime),
    )


class DashboardSchoolEnrollementView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_school_enrollment_course_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("school_id", Integer),
        Column("count", BigInteger, server_default=FetchedValue()),
        Column("count_courses", BigInteger, server_default=FetchedValue()),
        Column("min_enrollment_date", Date),
        Column("max_enrollment_date", Date),
    )


class DashboardInstructorEnrollementView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_instructor_enrollment_course_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("instructor_id", Integer),
        Column("count", BigInteger, server_default=FetchedValue()),
        Column("count_courses", BigInteger, server_default=FetchedValue()),
        Column("min_enrollment_date", Date),
        Column("max_enrollment_date", Date),
    )


class DashboardStudentEnrollementView(Base, EntitySerializer):
    __table__ = Table(
        "dashboard_student_enrollment_course_view",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("student_id", Integer),
        Column("count", BigInteger, server_default=FetchedValue()),
        Column("count_courses", BigInteger, server_default=FetchedValue()),
        Column("min_enrollment_date", Date),
        Column("max_enrollment_date", Date),
    )


class CountryRegionCityView(Base, EntitySerializer):
    __table__ = Table(
        "country_region_city",
        metadata,
        Column("region", String(40)),
        Column("id", Integer, primary_key=True),
        Column("city", String(40)),
        Column("region_id", Integer),
    )


class StudentSubjectView(Base, EntitySerializer):

    __table__ = Table(
        "student_subject_view",
        metadata,
        Column("student_id", Integer, server_default=FetchedValue()),
        Column("school_id", Integer),
        Column("school_qualification_id", Integer),
        Column("classroom", String(45)),
        Column("school_subject_id", Integer, primary_key=True),
        Column("subject_id", Integer),
        Column("qualification_id", Integer),
        Column("label_subject", String(200)),
        Column("code", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
    )


class StudentSubjectCourseView(Base, EntitySerializer):

    __table__ = Table(
        "student_subject_course_view",
        metadata,
        Column("student_id", Integer, server_default=FetchedValue()),
        Column("school_id", Integer),
        Column("school_qualification_id", Integer),
        Column("classroom", String(45)),
        Column("school_subject_id", Integer, primary_key=True),
        Column("subject_id", Integer),
        Column("qualification_id", Integer),
        Column("label_subject", String(200)),
        Column("code", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
        Column("total_course", BigInteger, server_default=FetchedValue()),
    )


class CourseChapterContentView(Base, EntitySerializer):

    __table__ = Table(
        "course_chapter_content_view",
        metadata,
        Column("chapter_id", Integer, server_default=FetchedValue()),
        Column("course_id", Integer),
        Column("chapter_title", String(1000)),
        Column("chapter_description", String(4000)),
        Column("num_of_reading", Integer),
        Column("num_of_contents", Integer),
        Column("chapter_is_visible", BIT(1), server_default=FetchedValue()),
        Column("chapter_sequence", Integer),
        Column("content_id", Integer, primary_key=True),
        Column("content_type_id", Integer),
        Column("is_important", BIT(1), server_default=FetchedValue()),
        Column("time_required_in_sec", Integer),
        Column("file_size_in_bytes", Integer),
        Column("is_open_for_free", String(1)),
        Column("content_is_visible", BIT(1), server_default=FetchedValue()),
        Column("content_url", String(2000)),
        Column("content_cover_url", String(2000)),
        Column("content_text", String),
        Column("content_brief", String(4000)),
        Column("date_creation", DateTime),
        Column("date_update", DateTime),
        Column("content_sequence", Integer),
        Column("content_type", String(20)),
    )


class CourseChapterView(Base, EntitySerializer):

    __table__ = Table(
        "course_chapter_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("course_id", Integer),
        Column("chapter_title", String(100)),
        Column("chapter_description", String(4000)),
        Column("num_of_reading", Integer),
        Column("num_of_contents", Integer),
        Column("is_visible", BIT(1), server_default=FetchedValue()),
        Column("sequence", Integer),
        Column("course_title", String(200)),
        Column("course_brief", String(4000)),
        Column("instructor_id", Integer),
        Column("num_of_chapters", Integer),
        Column("course_fee", Integer),
        Column("language_id", Integer),
        Column("school_subject_id", Integer),
        Column("is_course_visible", BIT(1), server_default=FetchedValue()),
        Column("date_creation", DateTime),
        Column("date_update", DateTime),
        Column("date_start_course", DateTime),
        Column("date_end_course", DateTime),
        Column("language_name", String(50)),
        Column("language_code", String(2)),
        Column("school_id", Integer),
        Column("label_subject", String(200)),
        Column("code_qualification", String(45)),
        Column("education", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
        Column("date_chapter_creation", DateTime),
        Column("date_chapter_update", DateTime),

    )


class CourseInstructorView(Base, EntitySerializer):

    __table__ = Table(
        "course_instructor_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("course_title", String(1000)),
        Column("course_brief", String(4000)),
        Column("instructor_id", Integer),
        Column("num_of_chapters", Integer),
        Column("course_fee", Integer),
        Column("language_id", Integer),
        Column("school_subject_id", Integer),
        Column("is_visible", BIT(1), server_default=FetchedValue()),
        Column("date_creation", DateTime),
        Column("date_update", DateTime),
        Column("date_start_course", DateTime),
        Column("date_end_course", DateTime),
        Column("language_name", String(50)),
        Column("language_code", String(2)),
        Column("school_id", Integer),
        Column("label_subject", String(200)),
        Column("code_qualification", String(45)),
        Column("education", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
        Column("first_name", String(50)),
        Column("last_name", String(50)),
        Column("active_account", BIT(1), server_default=FetchedValue()),
        Column("email", String(50)),
        Column("num_of_published_courses", Integer),
    )


class CourseView(Base, EntitySerializer):

    __table__ = Table(
        "course_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("course_title", String(200)),
        Column("course_brief", String(4000)),
        Column("instructor_id", Integer),
        Column("num_of_chapters", Integer),
        Column("num_of_quizzes", Integer),
        Column("course_fee", Integer),
        Column("language_id", Integer),
        Column("school_subject_id", Integer),
        Column("is_visible", BIT(1), server_default=FetchedValue()),
        Column("date_creation", DateTime),
        Column("date_update", DateTime),
        Column("date_start_course", DateTime),
        Column("date_end_course", DateTime),
        Column("language_name", String(50)),
        Column("language_code", String(2)),
        Column("school_id", Integer),
        Column("label_subject", String(200)),
        Column("code_qualification", String(45)),
        Column("education", String(45)),
        Column("level", String(45)),
        Column("label_qualification", String(200)),
    )


class InstructorProfile(Base, EntitySerializer):

    __table__ = Table(
        "instructor_profile",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("school_id", Integer),
        Column("first_name", String(50)),
        Column("last_name", String(50)),
        Column("email", String(50)),
        Column("password", String(255)),
        Column("address", String(1000)),
        Column("phone_primary", String(45)),
        Column("phone_secondary", String(45)),
        Column("date_birth", Date),
        Column("registration_date", Date),
        Column("introduction_brief", String(1000)),
        Column("image", String(2000)),
        Column("country_city_id", Integer),
        Column("country_id", Integer),
        Column("active_account", BIT(1)),
    )


class SchoolProfile(Base, EntitySerializer):

    __table__ = Table(
        "school_profile",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("name", String(50)),
        Column("email", String(50)),
        Column("password", String(255)),
        Column("address", String(1000)),
        Column("phone_primary", String(45)),
        Column("phone_secondary", String(45)),
        Column("registration_date", Date),
        Column("introduction_brief", String(1000)),
        Column("image", String(2000)),
        Column("country_city_id", Integer),
        Column("country_id", Integer),
        Column("active_account", BIT(1)),
    )


class SchoolQualificationView(Base, EntitySerializer):

    __table__ = Table(
        "school_qualification_view",
        metadata,
        Column("school_qualification_id", Integer, primary_key=True),
        Column("id", Integer),
        Column("code", String(45)),
        Column("label", String(200)),
        Column("level", String(45)),
        Column("education", String(45)),
        Column("qualification_id", Integer),
        Column("nbr_class", Integer),
        Column("classrooms_names", String(500)),
        Column("school_id", Integer),
    )


class SchoolSubjectView(Base, EntitySerializer):

    __table__ = Table(
        "school_subject_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("subject_id", Integer),
        Column("qualification_id", Integer),
        Column("school_id", Integer),
        Column("label_subject", String(200)),
        Column("code", String(45)),
        Column("label_qualification", String(200)),
        Column("level", String(45)),
        Column("education", String(45)),
        Column("classrooms_names", String(500)),
        Column("school_qualification_id", Integer),
        Column("school_subject_id", Integer),
    )


class StudentProfile(Base, EntitySerializer):

    __table__ = Table(
        "student_profile",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("school_id", Integer),
        Column("first_name", String(100)),
        Column("last_name", String(100)),
        Column("email", String(255)),
        Column("password", String(255)),
        Column("address", String(1000)),
        Column("phone_primary", String(45)),
        Column("phone_secondary", String(45)),
        Column("date_birth", Date),
        Column("registration_date", Date),
        Column("image", String(2000)),
        Column("country_city_id", Integer),
        Column("country_id", Integer),
        Column("school_qualification_id", Integer),
        Column("classroom", String(45)),
        Column("level", String(45)),
        Column("qualification", String(200)),
        Column("active_account", BIT(1)),
    )


class UserApp(Base, EntitySerializer):

    __table__ = Table(
        "users_app",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("email", String(255)),
        Column("password", String(255)),
        Column("phone_primary", String(45)),
        Column("active_account", BIT(1)),
        Column("role", String(45), primary_key=True),
        Column("school_type_id", Integer),
    )


class MessagesBoxInboxView(Base, EntitySerializer):

    __table__ = Table(
        "messages_box_inbox_view",
        metadata,
        Column("id", BigInteger, primary_key=True),
        Column("user_sender_id", Integer),
        Column("user_sender_role", String(10)),
        Column("subject", String(255)),
        Column("date_update", DateTime, server_default=FetchedValue()),
        Column("to_trash", BIT(1), server_default=FetchedValue()),
        Column("message_box_recipient_id", BigInteger, primary_key=True),
        Column("user_recipient_id", Integer),
        Column("user_recipient_role", String(10)),
        Column("is_read", BIT(1), server_default=FetchedValue()),
        Column("user_sender_full_name", String(201)),
        Column("user_recipient_full_name", String(201)),
        Column("user_sender_email", String(255)),
        Column("user_recipient_email", String(255)),
    )


class MessagesBoxView(Base, EntitySerializer):

    __table__ = Table(
        "messages_box_view",
        metadata,
        Column("id", BigInteger, primary_key=True),
        Column("user_sender_id", Integer),
        Column("user_sender_role", String(10)),
        Column("subject", String(255)),
        Column("body", String),
        Column("date_update", DateTime, server_default=FetchedValue()),
        Column("to_trash", BIT(1), server_default=FetchedValue()),
        Column("message_box_recipient_id", BigInteger, server_default=FetchedValue()),
        Column("user_recipient_id", Integer),
        Column("user_recipient_role", String(10)),
        Column("is_read", BIT(1), server_default=FetchedValue()),
        Column("user_sender_full_name", String(201)),
        Column("user_recipient_full_name", String(201)),
        Column("user_sender_email", String(255)),
        Column("user_recipient_email", String(255)),
    )


class SchoolTypeQualificationView(Base, EntitySerializer):

    __table__ = Table(
        "school_type_qualification_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("label_fr", String(200)),
        Column("label_en", String(200)),
        Column("label_es", String(200)),
        Column("level_fr", String(200)),
        Column("level_en", String(200)),
        Column("level_es", String(200)),
        Column("school_type_id", Integer),
        Column("school_type_fr", String(200)),
        Column("school_type_en", String(200)),
        Column("school_type_es", String(200)),
    )


class SchoolTypeSubjectView(Base, EntitySerializer):

    __table__ = Table(
        "school_type_subject_view",
        metadata,
        Column("id", Integer, primary_key=True),
        Column("label_fr", String(200)),
        Column("label_en", String(200)),
        Column("label_es", String(200)),
        Column("school_type_id", Integer),
        Column("school_type_fr", String(200)),
        Column("school_type_en", String(200)),
        Column("school_type_es", String(200)),
    )

class SchoolPaymentView(Base, EntitySerializer):
    __table__ = Table(
        "school_payment_view",
        metadata,
        Column("package_name", String(255), nullable=False),
        Column("id", Integer, primary_key=True),
        Column("school_id", Integer, nullable=False),
        Column("package_id", Integer, nullable=False),
        Column("number_of_students", Integer, nullable=False),
        Column("number_of_months", Integer, nullable=False),
        Column("amount_paid_reel", DECIMAL(10, 2), nullable=False),
        Column("amount_paid_global", DECIMAL(10, 2), nullable=False),
        Column("payment_method", String(50), nullable=False),
        Column("discount_percentage", DECIMAL(10, 2), nullable=True),
        Column("payment_date", DateTime, nullable=True),
        Column("renewal_date", DateTime, nullable=True),
        Column("payment_status", String(50), nullable=False),
        Column("transaction_reference", String(255), nullable=True),
        Column("date_insert", DateTime, nullable=False),
        Column("last_payment", DateTime, nullable=True)
    )

class SchoolPaymentInvoiceView(Base, EntitySerializer):
    __table__ = Table(
        "school_payment_invoice_view",
        metadata,
        Column("package_name", String(255), nullable=False),
        Column("price_per_student", DECIMAL(10, 2), nullable=True),
        Column("id", Integer, primary_key=True),
        Column("school_id", Integer, nullable=False),
        Column("package_id", Integer, nullable=False),
        Column("number_of_students", Integer, nullable=True),
        Column("number_of_months", Integer, nullable=True),
        Column("amount_paid_reel", DECIMAL(10, 2), nullable=True),
        Column("amount_paid_global", DECIMAL(10, 2), nullable=True),
        Column("payment_method", String(50), nullable=True),
        Column("discount_percentage", DECIMAL(10, 2), nullable=True),
        Column("payment_date", DateTime, nullable=True),
        Column("renewal_date", DateTime, nullable=True),
        Column("payment_status", String(50), nullable=True),
        Column("transaction_reference", String(255), nullable=True),
        Column("date_insert", DateTime, nullable=True),
        Column("complete_name", String(255), nullable=True),
        Column("user_email", String(255), nullable=True),
    )
class InstructorStudentSubjectQualificationView(Base, EntitySerializer):
    __table__ = Table(
        "instructor_student_subject_qualification_view",
        metadata,
        Column("view_id", primary_key=True),
        Column("student_id", Integer),
        Column("school_id", Integer),
        Column("school_qualification_id", Integer),
        Column("classroom", String(50)),
        Column("first_name", String(100)),
        Column("last_name", String(100)),
        Column("email", String(255)),
        Column("password", String(255)),
        Column("address", String(255)),
        Column("phone_primary", String(30)),
        Column("phone_secondary", String(30)),
        Column("registration_date", Date),
        Column("image", String(255)),
        Column("num_of_courses_enrolled", Integer),
        Column("num_of_courses_completed", Integer),
        Column("active_account", Boolean),
        Column("country_city_id", Integer),
        Column("country_id", Integer),

        Column("school_subject_id", Integer),
        Column("instructor_id", Integer),
        Column("subject_id", Integer),
        Column("qualification_id", Integer),
        Column("label_subject", String(255)),
        Column("code", String(100)),
        Column("label_qualification", String(255)),
        Column("level", String(50)),
        Column("education", String(50)),
    )

class StudentQuizResultView(Base, EntitySerializer):
    __table__ = Table(
        "student_quiz_results",
        metadata,
        Column("row_id", BigInteger, primary_key=True),
        Column("student_id", Integer),
        Column("quiz_id", Integer),
        Column("quiz_name", String(8000)),
        Column("scope", String(50)),  # Adapt type if using Enum mapping
        Column("scope_id", Integer),
        Column("time_limit", Integer),
        Column("total_questions", Integer),
        Column("correct_answers", Integer),
        Column("score", Integer),
        Column("first_timestamp", DateTime),
        Column("latest_timestamp", DateTime),
    )

class StudentActivityView(Base, EntitySerializer):
    __table__ = Table(
        "student_activity",
        metadata,
        Column("id", BigInteger, primary_key=True),
        Column("student_id", Integer),
        Column("course_id", Integer),
        Column("date_activity", DateTime),
        Column("activity", String(255))
    )

