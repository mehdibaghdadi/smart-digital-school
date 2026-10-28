from .db_context import _dbCxt
from .db_entities_tables import *
from..utilities.database.stored_procedure import call_stored_procedure


#------------ LES LISTENS-----------------------------------

@event.listens_for(CourseChapterContent.date_update, 'set')
def receive_attribute_change(target, value, oldvalue, initiator):
    if target.course_chapter:
        if target.course_chapter.course:
            target.course_chapter.course.date_update = value

#------------ LES PROCEDURES STOCKEES------------------------

def DashboardInstructorCourseChapterContentSP(instructor_id,date_start,date_end):
    params = [instructor_id,date_start,date_end]
    return call_stored_procedure(_dbCxt,"dashboard_instructor_course_chapter_content_sp",params)

def DashboardStudentCourseChapterContentSP(student_id,date_start,date_end):
    params = [student_id,date_start,date_end]
    return call_stored_procedure(_dbCxt,"dashboard_student_course_chapter_content_sp",params)

def DashboardSchoolCourseChapterContentSP(school_id,date_start,date_end):
    params = [school_id,date_start,date_end]
    return call_stored_procedure(_dbCxt,"dashboard_school_course_chapter_content_sp",params)

def MessagesBoxInboxSP(email,message_id):
    params = [email,message_id]
    return call_stored_procedure(_dbCxt,"messages_box_inbox_sp",params)

def MessagesBoxSP(id,email):
    params = [id,email]
    return call_stored_procedure(_dbCxt,"messages_box_sp",params)

def InstructorListStudent(user_id,allInfos):
    params = [user_id,allInfos]
    return call_stored_procedure(_dbCxt,"instructor_list_student",params)

def StudentListInstructor(user_id,allInfos):
    params = [user_id,allInfos]
    return call_stored_procedure(_dbCxt,"student_list_instructor",params)

 
def StudentCourseInstructorList(student_id,school_subject_id,instructor_id ):
    params = [student_id,school_subject_id,instructor_id]
    return call_stored_procedure(_dbCxt,"student_course_instructor_list",params)


def SchoolListStudent(user_id,allInfos):
    params = [user_id,allInfos]
    return call_stored_procedure(_dbCxt,"school_list_student",params)


def SchoolListInstructor(user_id,allInfos):
    params = [user_id,allInfos]
    return call_stored_procedure(_dbCxt,"school_list_instructor",params)


def SchoolInfosCommun(user_id,allInfos):
    params = [user_id,allInfos]
    return call_stored_procedure(_dbCxt,"school_infos_commun",params)

def schoolListClassroomsOccupied(user_id):
    params = [user_id]
    return call_stored_procedure(_dbCxt,"school_list_classrooms_occupied",params)


def MessageBoxCountRead(user_id,role,is_read):
    params = [user_id,role,is_read]
    return call_stored_procedure(_dbCxt,"message_box_count_read",params)




