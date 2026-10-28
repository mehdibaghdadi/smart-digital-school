
from ...utilities.flask.flask_menu import FlaskMenu, is_visible
from flask import current_app as app

c = app.config["MENU_RESOURCES"]  # from resources/menuConfig.py

app_menu_school = FlaskMenu(
    children=[  # Begin menu
        dict(
            menu_id="home",
            title=c.title_dashboard,
            title_header=c.title_dashboard_header,
            icon="fa fa-ew-bars text-yellow",
            endpoint="IndexSchoolView:index",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="contact",
            title=c.title_contacts,
            title_header=c.title_contacts_header,
            icon="fa fa-phone-square  text-red",
            endpoint="IndexSchoolView:contact",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="calendar_event_top",
            title=c.title_calendar_top,
            title_header=c.title_calendar_header,
            icon="fa fa-calendar-days text-purple",
            endpoint="CalendarEventSchoolView:index",
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
            endpoint="ProfileSchoolView:index",
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
            menu_id="instructor-edit-all",
            title=c.title_edit_account_prof,
            title_header=c.title_edit_account_prof_header,
            icon="fa fa-user-edit text-teal ",
            endpoint="InstructorSchoolView:edit_0",
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
            menu_id="ThemeViewindex",
            title=c.title_visual_theme,
            title_header=c.title_visual_theme,
            icon="fa fa-palette text-purple",
            endpoint="ThemeView:index",
            is_visible=lambda menu_instance: False,
        ),
        dict(
            menu_id="subscription_packages",
            title=c.title_change_packages,
            title_header=c.title_change_packages_header,
            icon="fa fa-arrow-up-from-ground-water text-pink",
            endpoint="PackageView:subscription_0",
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
                    icon="fa fa-cogs",
                    endpoint=None,
                    children=[
                        dict(
                            menu_id="profile2",
                            title=c.title_my_profil,
                            icon="fa fa-user text-success",
                            endpoint="ProfileSchoolView:index",
                        ),
                        dict(
                            menu_id="password2",
                            title=c.title_pwd,
                            icon="fa fa-lock text-red",
                            endpoint="AccountView:change_password",
                        ),
                        # Child controls
                    ],
                ),
            ],
        ),
        # Left Menu
        dict(
            menu_id="dashboard_id",
            title=c.title_dashboard,
            title_header=c.title_dashboard_header,
            icon="fa fa-ew-bars text-green",
            endpoint="DashboardSchoolView:index",
            is_visible=lambda menu_instance: True,
        ),
        dict(
            menu_id="calendar_event",
            title=c.title_calendar,
            title_header=c.title_calendar_header,
            icon="fa fa-calendar-days text-yellow",
            endpoint="CalendarEventSchoolView:index",
            is_visible=lambda menu_instance: True,
        ),
        dict(
            menu_id="message-2",
            title=c.title_mail_2,
            title_header=c.title_mail_2_header,
            icon="fa fa-envelopes-bulk text-purple",
            endpoint="MessagingView:index",
            is_visible=lambda menu_instance: True,
        ),
        dict(
            menu_id="chalkboard-teacher-id",
            title=c.title_instructors,
            icon="fa fa-chalkboard-teacher text-blue",
            children=[
                dict(
                    menu_id="instructor-create",
                    title=c.title_add_account,
                    title_header=c.title_add_account_prof_header,
                    icon="fa fa-user-plus text-green ",
                    endpoint="InstructorSchoolView:add",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="instructor-list",
                    title=c.title_edit_prof_list,
                    title_header=c.title_edit_prof_list_header,
                    icon="far fa-list-alt text-green ",
                    endpoint="InstructorSchoolView:index",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
        dict(
            menu_id="user-graduate-id",
            title=c.title_students,
            icon="fa fa-user-graduate text-green",
            children=[
                dict(
                    menu_id="student-create",
                    title=c.title_add_account,
                    title_header=c.title_add_account_student_header,
                    icon="fa fa-user-plus text-green",
                    endpoint="StudentSchoolView:add",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="student-list",
                    title=c.title_edit_student_list,
                    title_header=c.title_edit_prof_student_header,
                    icon="far fa-list-alt text-green",
                    endpoint="StudentSchoolView:index",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
        dict(
            menu_id="reporting-courses-id",
            title=c.title_learn_courses,
            icon="fa fa-ew-book text-info",
            children=[
                dict(
                    menu_id="rpt-instructor-enrollment-courses",
                    title=c.title_courses_cheched_progress,
                    title_header=c.title_courses_cheched_progress_header,
                    icon="fa fa-chart-pie text-orange",
                    endpoint="ReportingSchoolView:reportInstructorEnrollmentCourses",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="rpt-feedback-courses",
                    title=c.title_courses_rated,
                    title_header=c.title_courses_rated_header,
                    icon="fa fa-ranking-star text-warning",
                    endpoint="ReportingSchoolView:reportInstructorFeedbackCourses",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="courses-assistance-id",
                    title=c.title_demands_assist,
                    title_header=c.title_demands_assist,
                    icon="fa fa-ew-sos text-cyan",
                    endpoint="ReportingSchoolView:reportCoursesAssistance",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="rpt-instructor-courses",
                    title=c.title_courses_list,
                    title_header=c.title_courses_list,
                    icon="fa fa-computer text-cyan",
                    endpoint="ReportingSchoolView:reportInstructorCourses",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
        dict(
            menu_id="reporting-id",
            title=c.title_admin_reports,
            icon="fa fa-chart-column text-brown",
            children=[
                dict(
                    menu_id="rpt-my-students",
                    title=c.title_monitoring_center_my_students ,
                    title_header=c.title_monitoring_center_my_students_header ,
                    icon="fa fa-ew-student text-red",
                    endpoint="ReportingSchoolView:reportMyStudents",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="rpt-my-instructor",
                    title=c.title_my_prof,
                    title_header=c.title_my_prof,
                    icon="fa fa-ew-instructor text-info",
                    endpoint="ReportingSchoolView:reportMyInstructors",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="rpt-school-qualifications",
                    title=c.title_school_classes,
                    title_header=c.title_school_classes,
                    icon="fa fa-graduation-cap text-green",
                    endpoint="ReportingSchoolView:reportSchoolQualifications",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="rpt-school-subjects",
                    title=c.title_subjects_classes,
                    title_header=c.title_subjects_classes,
                    icon="fa fa-microscope text-green",
                    endpoint="ReportingSchoolView:reportSchoolSubjects",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
        # ----------//ADMINISTRATION (LAST MENU ITEM)
        dict(
            menu_id="subject_qualification",
            title=c.title_params_administration,
            icon="fa fa-gear text-red",
            children=[
                dict(
                    menu_id="qualification",
                    title=c.title_school_classes,
                    title_header=c.title_school_classes_header,
                    icon="fa fa-graduation-cap text-red ",
                    endpoint="QualificationSchoolView:index",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="subject",
                    title=c.title_subjects_school,
                    title_header=c.title_subjects_school_2_header,
                    icon="fa fa-microscope text-info ",
                    endpoint="SubjectSchoolView:index",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
        # End menu
        # ----------// PACKAGES
        dict(
            menu_id="packages-id",
            title=c.title_subscription_options,
            icon="fa fa-box text-pink",
            children=[
                dict(
                    menu_id="change_packages",
                    title=c.title_change_packages,
                    title_header=c.title_change_packages_header,
                    icon="fa fa-arrow-up-from-ground-water text-pink",
                    endpoint="PackageView:index",
                    is_visible=lambda menu_instance: True,
                ),
                dict(
                    menu_id="your_payments_list",
                    title=c.title_your_payments,
                    title_header=c.title_your_payments,
                    icon="fa fa-cart-shopping text-green fa-stack-1x",
                    endpoint="PaymentView:paymentsList",
                    is_visible=lambda menu_instance: True,
                ),
            ],
        ),
    ]
)