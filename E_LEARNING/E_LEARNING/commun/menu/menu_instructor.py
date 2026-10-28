
from ...utilities.flask.flask_menu import FlaskMenu, is_visible
from flask import current_app as app

c = app.config["MENU_RESOURCES"]  # from resources/menuConfig.py

app_menu_instructor = FlaskMenu(
    children=[  # Begin menu
        dict(
            menu_id="home",
            title=c.title_dashboard,
            title_header=c.title_dashboard_header,
            icon="fa fa-ew-bars text-yellow",
            endpoint="IndexInstructorView:index",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="calendar_event_top",
            title=c.title_calendar_top,
            title_header=c.title_calendar_header,
            icon="fa fa-calendar-days text-purple",
            endpoint="CalendarEventInstructorView:index",
            is_visible=lambda menu_instance: False,
        ),
        
        dict(
            menu_id="message",
            title=c.title_mail,
            title_header=c.title_mail_header,
            icon="fa fa-envelopes-bulk text-green",
            endpoint="MessagingView:index",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="profile",
            title=c.title_profil,
            title_header=c.title_profil_header,
            endpoint="ProfileInstructorView:index",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="password",
            title=c.title_pwd,
            title_header=c.title_pwd_header,
            endpoint="AccountView:change_password",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="course-edit-1",
            title=c.title_edit_course,
            title_header=c.title_edit_course_header,
            icon="fa fa-ew-book",
            endpoint="CourseInstructorView:edit_0",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="monitoring_id",
            title=c.title_monitoring_center,
            title_header=c.title_monitoring_center,
            icon="fa fa-compass text-red",
            endpoint="ReportingView:MonitoringStudentView_0",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="courseBySubjectView360",
            title=c.title_courses,
            title_header="",
            icon="fa fa-ew-book",
            endpoint="CourseInstructorView:courseBySubjectView360_0",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="courseBySubject_0",
            title=c.title_courses,
            title_header="",
            icon="fa fa-ew-book",
            endpoint="CourseView:courseBySubject_0",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="chapter-edit-1",
            title=c.title_edit_chapter,
            title_header=c.title_edit_chapter_header,
            icon="fa fa-ew-notebook text-green",
            endpoint="ChapterInstructorView:edit_0",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="quiz-edit-1",
            title=c.title_edit_quiz,
            title_header=c.title_edit_quiz_header,
            icon="fa fa-ew-quiz",
            endpoint="QuizInstructorView:edit_1",
            is_visible=lambda menu_instance: False,
        ),
         dict(
            menu_id="quiz-form-1",
            title=c.title_quiz_form,
            title_header=c.title_quiz_form,
            icon="fa fa-ew-quiz",
            endpoint="QuizFormView:form_0",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="calendar_assistance_all_by_ids",
            title=c.title_demands,
            title_header=c.title_demands_header,
            icon="fa fa-ew-sos text-info",
            endpoint="CalendarAssistanceInstructorView_all_by_ids",
            is_visible=lambda menu_instance: False,
        ), 
        dict(
            menu_id="ThemeViewindex",
            title=c.title_visual_theme,
            title_header=c.title_visual_theme,
            icon="fa fa-palette text-purple",
            endpoint="ThemeView:index",
            is_visible=lambda menu_instance: False,
        ),
        # Controls
        dict(
            menu_id="controls",
            title=c.title_controls,
            is_visible=lambda menu_instance: False,
            children=[
                dict(
                    menu_id="params",
                    title=c.title_info,
                    icon="fa fa-info",
                    endpoint=None,
                    children=[
                        dict(
                            menu_id="profile2",
                            title=c.title_my_profil,
                            icon="fa fa-user text-success",
                            endpoint="ProfileInstructorView:index",
                        ),
                        dict(
                            menu_id="password2",
                            title=c.title_pwd,
                            icon="fa fa-lock text-red",
                            endpoint="AccountView:change_password",
                        ),
                        dict(
                            menu_id="contact",
                            title=c.title_contacts,
                            icon="fa fa-phone-square  text-info",
                            endpoint="IndexInstructorView:contact",
                        ),
                        dict(
                            menu_id="subject_instructor",
                            title=c.title_subjects_classes,
                            title_header=c.title_subjects_classes_header,
                            icon="fa fa-microscope text-orange",
                            endpoint="SubjectInstructorView:index",
                        ),
                        # Child controls
                    ],
                )
            ],
        ),
        # Left Menu
        dict(
            menu_id="dashboard_id",
            title=c.title_dashboard,
            title_header=c.title_dashboard_header,
            icon="fa fa-ew-bars text-red",
            endpoint="DashboardInstructorView:index",
            is_visible=lambda menu_instance: True,
        ),
        dict(
            menu_id="course",
            title=c.title_create_course,
            title_header=c.title_create_course_header,
            icon="fa fa-ew-newcourse text-warning ",
            endpoint="CourseInstructorView:course_start",
            is_visible=lambda menu_instance: True,
        ),
        dict(
            menu_id="list_course",
            title=c.title_courses_list,
            title_header=c.title_courses_list_header,
            icon="fa fa-ew-book",
            endpoint="CourseInstructorView:index",
            is_visible=lambda menu_instance: True,
        ),
        dict(
            menu_id="calendar_assistance",
            title=c.title_demands_assist,
            icon="fa fa-ew-sos text-blue",
            children=[
                dict(
                    menu_id="calendar_assistance_new",
                    title=c.title_demands_new,
                    title_header=c.title_demands_new_header,
                    icon="fa fa-headset text-yellow",
                    endpoint="CalendarAssistanceInstructorView_ongoing",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="calendar_assistance_accepted",
                    title=c.title_demands_accept,
                    title_header=c.title_demands_accept_header,
                    icon="fa fa-ew-sos-new text-green",
                    endpoint="CalendarAssistanceInstructorView_accepted",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="calendar_assistance_done",
                    title=c.title_demands_ended,
                    title_header=c.title_demands_ended_header,
                    icon="far fa-calendar-check text-muted",
                    endpoint="CalendarAssistanceInstructorView_done",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="calendar_assistance_cancelled",
                    title=c.title_demands_cancel,
                    title_header=c.title_demands_cancel_header,
                    icon="far fa-calendar-xmark text-red",
                    endpoint="CalendarAssistanceInstructorView_canceled",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="calendar_assistance_all",
                    title=c.title_demands_all,
                    title_header=c.title_demands_all_header,
                    icon="fa fa-ew-sos text-info",
                    endpoint="CalendarAssistanceInstructorView_all",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
        dict(
            menu_id="calendar_event",
            title=c.title_calendar,
            title_header=c.title_calendar_header,
            icon="fa fa-calendar-days text-info",
            endpoint="CalendarEventInstructorView:index",
            is_visible=lambda menu_instance: True,
        ),
        dict(
            menu_id="message-2",
            title=c.title_mail_2,
            title_header=c.title_mail_2_header,
            icon="fa fa-envelopes-bulk text-green",
            endpoint="MessagingView:index",
            is_visible=lambda menu_instance: True,
        ),
        dict(
            menu_id="chalkboard-teacher-id",
            title=c.title_learn_courses,
            icon="fa fa-computer text-purple",
            children=[               
                dict(
                    menu_id="Cours-Online",
                    title=c.title_course_online,
                    title_header=c.title_course_online_header,
                    icon="fa fa-eye text-green",
                    endpoint="CourseInstructorView:visibility_2",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="Cours-Offline",
                    title=c.title_course_offline,
                    title_header=c.title_course_offline_header,
                    icon="fa fa-eye-slash text-gray",
                    endpoint="CourseInstructorView:visibility_1",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
        dict(
            menu_id="reporting-id",
            title=c.title_my_reports,
            icon="fa fa-chart-column text-yellow",
            children=[
                dict(
                    menu_id="rpt-my-students",
                    title=c.title_monitoring_center_my_students ,
                    title_header=c.title_monitoring_center_my_students_header ,
                    icon="fa fa-ew-student text-red",
                    endpoint="ReportingInstructorView:reportMyStudents",
                    is_visible=lambda menu_instance: True,
                ),
                 dict(
                    menu_id="rpt-enrollement_course",
                    title=c.title_courses_cheched_progress,
                    title_header=c.title_courses_cheched_progress_header,
                    icon="fa fa-chart-pie text-orange",
                    endpoint="ReportingInstructorView:reportEnrollmentCourses",
                    is_visible=lambda menu_instance: True,
                ),

                 dict(
                    menu_id="rpt-quiz_course",
                    title=c.title_quizzes_progress,
                    title_header=c.title_quizzes_progress_header,
                    icon="fa fa-ew-quiz",
                    endpoint="ReportingInstructorView:reportQuizCourses",
                    is_visible=lambda menu_instance: True,
                ),


                dict(
                    menu_id="rpt-feedback-courses",
                    title=c.title_courses_rated,
                    title_header=c.title_courses_rated_header,
                    icon="fa fa-ranking-star text-warning",
                    endpoint="ReportingInstructorView:reportFeedbackCourses",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
        # End menu
    ]
)
