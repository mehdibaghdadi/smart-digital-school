var sds_url_api = {
    e_fm_url_api: JSR["e_fm_api"],
    e_rpt_url_api: JSR["e_rpt_api"],
    e_signalr_api: JSR["e_signalr_api"],
}

var sds_app_external_apis = {
    //Account
    reset_user_data_url: '/api/account-manager/reset-user-data',
    //reporting
    reporting_course_view_url: '/reporting/course-view',
    reporting_monitoring_student_view_url: '/reporting/monitoring-student-view',
    reporting_quiz_student_view_url: '/quiz/form',

    //FILE MANAGER APP SETTINGS
    max_size_upload: (500) * 1024 * 1024, // 202 Mo
    timeout_file_post: 120 * (60 * 1000), // 120 mn = 2h    
    content_upload_file_url: sds_url_api.e_fm_url_api + JSR["content_upload_file_url"],
    content_delete_file_url: sds_url_api.e_fm_url_api + JSR["content_delete_file_url"],
    content_update_upload_file_url: sds_url_api.e_fm_url_api + JSR["content_update_upload_file_url"],
    content_download_media_url: sds_url_api.e_fm_url_api + JSR["content_download_media_url"] + "{0}",
    content_download_file_url: sds_url_api.e_fm_url_api + JSR["content_download_file_url"],
    content_get_image_url: sds_url_api.e_fm_url_api + JSR["content_get_image_url"]+"/",

    //HUB Notification
    notification_hub_url: sds_url_api.e_signalr_api + "notification-hub",

    //Notification users
    notification_user_data_change_url: sds_url_api.e_signalr_api + "notification/user-data-change/{0}/{1}",

    //Assistance users
    assistance_unread_count_url: sds_url_api.e_signalr_api + "notification/unread-assistance-count",


    //Notification Message Box users
    messagebox_sendmsg_url: sds_url_api.e_signalr_api + "notification/send-message-box",
    messagebox_readmsg_url: sds_url_api.e_signalr_api + "notification/read-message-box",
    messagebox_deletemsg_url: sds_url_api.e_signalr_api + "notification/delete-message-box",
    messagebox_unreadmsg_count_url: sds_url_api.e_signalr_api + "notification/unread-message-box-count",

    //REPORTING MANAGER APP SETTINGS

    //--------instructor------------
    instructor_feedback_course_report_url: sds_url_api.e_rpt_url_api + "instructor-report/feedback-course",
    instructor_my_students_report_url: sds_url_api.e_rpt_url_api + "instructor-report/my-students",

    //--------school & instructor------------

    instructor_enrollment_courses_report_url: sds_url_api.e_rpt_url_api + "school-report/instructor-enrollment-courses",
    instructor_quiz_courses_report_url: sds_url_api.e_rpt_url_api + "school-report/instructor-quiz-courses",
    instructor_courses_report_url: sds_url_api.e_rpt_url_api + "school-report/instructor-courses",
    instructor_feedback_courses_report_url: sds_url_api.e_rpt_url_api + "school-report/instructor-feedback-courses",

    //--------school------------
    school_my_students_report_url: sds_url_api.e_rpt_url_api + "school-report/my-students",
    school_my_instructors_report_url: sds_url_api.e_rpt_url_api + "school-report/my-instructors",
    school_subjects_report_url: sds_url_api.e_rpt_url_api + "school-report/school-subjects",
    school_qualifications_report_url: sds_url_api.e_rpt_url_api + "school-report/school-qualifications",
    school_courses_assistance_report_url: sds_url_api.e_rpt_url_api + "school-report/courses-assistance",
    
}