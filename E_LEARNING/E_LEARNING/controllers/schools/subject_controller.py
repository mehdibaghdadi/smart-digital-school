from ...imports import *


# ---------------view
class SubjectSchoolView(Api):
    route_prefix = ""
    route_base = "/school/subject/"

    @login_required
    @role_required(role=ROLES.School.value)
    @route("", methods=Api.GET)
    def index(self):
        from ..commun.school_type_subject_controller import (
            SchoolTypeSubjectManager as STSM,
        )
        from .qualification_controller import QualificationSchoolManager

        school_id = current_user.id
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        qualification = (QualificationSchoolManager()).getListSaved(school_id)
        status_qualification = qualification.json["status"] == 200

        s_api = SubjectSchoolManager()
        subject = s_api.getListPredefined(school_id)

        status_subject = subject.json["status"] == 200
        listSchoolTypeSubject = (STSM()).getList() if not status_subject else notFound

        subject_db = s_api.getListSubject(school_id) if status_subject else notFound
        subject_qualifications_db = (
            s_api.getListSubjectQualification(school_id) if status_subject else notFound
        )

        url_save_update = url_for(
            "SubjectSchoolManager:save_update", school_id=school_id
        )
        url_init_type_subject = url_for(
            "SubjectSchoolManager:init_type_subject", school_id=school_id
        )

        url_add_subject = url_for(
            "SubjectSchoolManager:add_subject", school_id=school_id
        )
        url_edit_subject = url_for(
            "SubjectSchoolManager:edit_subject", school_id=school_id
        )
        url_delete_subject= url_for(
            "SubjectSchoolManager:delete_subject", school_id=school_id
        )

        return render_template(
            "/schools/subject.html",
            status_subject=status_subject,
            status_qualification=status_qualification,
            url_init_type_subject=url_init_type_subject,
            url_add_subject=url_add_subject,
            url_edit_subject=url_edit_subject,
            url_delete_subject=url_delete_subject,
            url_save_update=url_save_update,
            subject=subject,
            subject_db=subject_db,
            qualification=qualification,
            subject_qualifications_db=subject_qualifications_db,
            listSchoolTypeSubject=listSchoolTypeSubject,
        )


# ---------------Api
class SubjectSchoolManager(Api):
    route_base = "/school-subject-manager/"

    @route("/list-subject/<school_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListSubject(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = (
                dbSession.query(SchoolSubject.subject_id, SchoolSubject.school_id)
                .distinct()
                .options(noload("*"))
                .filter_by(school_id=school_id)
                .all()
            )
            if not qList:
                return notFound

            qList = [
                {"subject_id": i.subject_id, "school_id": i.school_id} for i in qList
            ]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-predefined/<school_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListPredefined(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:

            qList = (
                Subject.query.options(noload("*"))
                .filter_by(school_id=school_id)
                .order_by(Subject.label)
                .all()
            )
            if not qList:
                return notFound

            qList = [i.serialize() for i in qList]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-subject-predefined/<school_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListSubjectPredefined(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = (
                SchoolSubjectView.query.options(noload("*"))
                .filter_by(school_id=school_id)
                .order_by(
                    SchoolSubjectView.label_subject,
                    SchoolSubjectView.education,
                    SchoolSubjectView.code,
                )
                .all()
            )
            if not qList:
                return notFound

            qList = [i.serialize() for i in qList]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-subject-qualification/<school_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListSubjectQualification(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = (
                SchoolSubject.query.options(noload("*"))
                .filter_by(school_id=school_id)
                .all()
            )
            if not qList:
                return notFound

            qList = [i.serialize() for i in qList]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/save-update/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def save_update(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        cantDelete = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_subjects_prof_canceled
        )

        subject = json.loads(request.data)

        if not school_id or not subject:
            return notFound

        school_id = int(school_id)

        selected = [
            SchoolSubject(
                subject_id=x["subject_id"],
                qualification_id=x["qualification_id"],
                school_id=school_id,
            )
            for x in subject
            if x["selected"] == True
        ]

        unselected = [
            (x["subject_id"], x["qualification_id"], school_id)
            for x in subject
            if x["selected"] == False
        ]

        try:

            sb_db = (
                SchoolSubject.query.options(noload("*"))
                .filter_by(school_id=school_id)
                .all()
            )

            if sb_db:
                exist_insert = [
                    (sub.subject_id, sub.qualification_id, sub.school_id)
                    for sub in sb_db
                ]
                selected = [
                    i
                    for i in selected
                    if (i.subject_id, i.qualification_id, i.school_id)
                    not in exist_insert
                ]

                # delete
                if len(unselected) > 0:
                    exist_remove = [
                        (rm.id, rm.subject_id, rm.qualification_id, rm.school_id)
                        for rm in sb_db
                    ]
                    unselected = [
                        i[0] for i in exist_remove if (i[1], i[2], i[3]) in unselected
                    ]

                    if len(unselected) > 0:
                        try:
                            dbSession.query(SchoolSubject).filter(
                                SchoolSubject.id.in_(unselected),
                                SchoolSubject.school_id == school_id,
                            ).delete(synchronize_session=False)
                            dbSession.commit()
                        except Exception as e:
                            Api.json_exception(e)
                            return cantDelete

            # insert
            if len(selected) > 0:
                dbSession.add_all(selected)
                dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"school_id": school_id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/add-subject/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def add_subject(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)

        subject_new_list = json.loads(request.data)

        if not school_id or not subject_new_list:
            return notFound

        new_selection = [
            Subject(
                label=x["label"],
                school_id=school_id,
            )
            for x in subject_new_list
        ]
        try:
            # insert
            if len(new_selection) > 0:
                dbSession.add_all(new_selection)
            else:
                return notFound

            dbSession.commit()

            qList = [i.serialize() for i in new_selection]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/edit-subject/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def edit_subject(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)

        subject_edit = json.loads(request.data)

        if not school_id or not subject_edit:
            return notFound

        edit_selection = [
            Subject(
                id=x["id"],
                label=x["label"],
                school_id=school_id,
            )
            for x in subject_edit
        ]
        try:
            # insert
            if len(edit_selection) > 0:
                for c in edit_selection:
                    c.query.filter_by(id=c.id, school_id=c.school_id).update(
                        {Subject.label: c.label}
                    )
            else:
                return notFound

            dbSession.commit()

            qList = [i.serialize() for i in edit_selection]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/delete-subject/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def delete_subject(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        cantDelete = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_subjects_prof_canceled
        )
        subject_remove = json.loads(request.data)

        if not school_id or not subject_remove:
            return notFound

        delete_selection = [x["id"] for x in subject_remove]
        try:
            dbSession.query(SchoolSubject).filter(
                SchoolSubject.subject_id.in_(delete_selection),
                SchoolSubject.school_id == school_id,
            ).delete(synchronize_session=False)
            
            dbSession.query(Subject).filter(
                Subject.id.in_(delete_selection),
                Subject.school_id == school_id,
            ).delete(synchronize_session=False)
            
            dbSession.commit()
            
            return Api.json_response(HTTPStatus.OK, {"school_id": school_id})
            
        except Exception as e:
            Api.json_exception(e)
            return cantDelete

    @route("/init-type-subject/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def init_type_subject(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        cantDelete = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_subjects_prof_canceled
        )

        type_subject = json.loads(request.data)

        if not school_id or not type_subject:
            return notFound

        new_selection = [
            Subject(
                label=x["label"],
                school_id=school_id,
            )
            for x in type_subject
        ]
        try:
            commit_exists = False
            # insert
            if len(new_selection) > 0:
                dbSession.add_all(new_selection)
                commit_exists = True  # force commit

            # commit
            if commit_exists:
                dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"school_id": school_id})
        except Exception as inst:
            return Api.json_exception(inst)