from ...imports import *


# ---------------view
class QualificationSchoolView(Api):
    route_prefix = ""
    route_base = "/school/qualification/"

    @login_required
    @role_required(role=ROLES.School.value)
    @route("", methods=Api.GET)
    def index(self):
        from ..commun.school_type_qualification_controller import (
            SchoolTypeQualificationManager as STQM,
        )

        school_id = current_user.id
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        q_api = QualificationSchoolManager()

        qualification = q_api.getListPredefined(school_id)
        status_qualification = qualification.json["status"] == 200
        listSchoolTypeQualification = (
            (STQM()).getList() if not status_qualification else notFound
        )

        qualification_db = (
            q_api.getList(school_id) if status_qualification else notFound
        )
        listClassroomsOccupied = (
            q_api.getListClassroomsOccupied(school_id)
            if status_qualification
            else notFound
        )

        url_save_update = url_for(
            "QualificationSchoolManager:save_update", school_id=school_id
        )
        url_edit_class_label = url_for(
            "QualificationSchoolManager:edit_class", school_id=school_id
        )

        url_edit_level_label = url_for(
            "QualificationSchoolManager:edit_level", school_id=school_id
        )
        url_delete_level = url_for(
            "QualificationSchoolManager:delete_level", school_id=school_id
        )

        url_edit_education_label = url_for(
            "QualificationSchoolManager:edit_education", school_id=school_id
        )
        url_delete_education = url_for(
            "QualificationSchoolManager:delete_education", school_id=school_id
        )

        url_init_type_qualification = url_for(
            "QualificationSchoolManager:init_type_qualification", school_id=school_id
        )

        return render_template(
            "/schools/qualification.html",
            status_qualification=status_qualification,
            url_edit_class_label=url_edit_class_label,
            url_edit_level_label=url_edit_level_label,
            url_delete_level=url_delete_level,
            url_edit_education_label=url_edit_education_label,
            url_delete_education=url_delete_education,
            url_save_update=url_save_update,
            url_init_type_qualification=url_init_type_qualification,
            qualification=qualification,
            qualification_db=qualification_db,
            listClassroomsOccupied=listClassroomsOccupied,
            listSchoolTypeQualification=listSchoolTypeQualification,
        )


# ---------------Api
class QualificationSchoolManager(Api):
    route_base = "/school-qualification-manager/"

    @route("/list/<school_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getList(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = (
                SchoolQualification.query.options(noload("*"))
                .filter_by(school_id=school_id)
                .all()
            )
            if not qList:
                return notFound

            qList = [i.serialize() for i in qList]

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
                Qualification.query.options(noload("*"))
                .filter_by(school_id=school_id)
                .order_by(cast(Qualification.code, Integer).asc())
                .all()
            )
            if not qList:
                return notFound

            qList = [i.serialize() for i in qList]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-saved/<school_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListSaved(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = (
                SchoolQualificationView.query.options(noload("*"))
                .filter_by(school_id=school_id)
                .order_by(cast(SchoolQualificationView.code, Integer).asc())
                .all()
            )
            if not qList:
                return notFound

            qList = [i.serialize() for i in qList]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-classrooms-occupied/<int:id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListClassroomsOccupied(self, id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:

            qList = schoolListClassroomsOccupied(id)
            if not qList:
                return notFound

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
            HTTPStatus.BAD_REQUEST, ARS.deletion_classes_prof_canceled
        )

        qualification = json.loads(request.data)

        if not school_id or not qualification:
            return notFound

        selected = [
            SchoolQualification(
                id=x["school_qualification_id"],
                qualification_id=x["id"],
                nbr_class=x["nbr_class"],
                classrooms_names=",".join(x["classrooms_names"]),
                school_id=school_id,
            )
            for x in qualification
            if x["selected"] == True
        ]

        unselected = [x["id"] for x in qualification if x["selected"] == False]

        try:
            exist_q = []
            commit_exists = False
            ql_db = (
                SchoolQualification.query.options(noload("*"))
                .filter_by(school_id=school_id)
                .all()
            )

            if ql_db:
                exist_q = [sub.qualification_id for sub in ql_db]  # ids
                for item in ql_db:  # update records
                    sc = [
                        x
                        for x in selected
                        if x.qualification_id == item.qualification_id
                    ]
                    if sc:
                        item.nbr_class = sc[0].nbr_class
                        item.classrooms_names = sc[0].classrooms_names
                        commit_exists = True

                # delete
                if len(unselected) > 0:
                    try:
                        dbSession.query(SchoolQualification).filter(
                            SchoolQualification.qualification_id.in_(unselected),
                            SchoolQualification.school_id == school_id,
                        ).delete(synchronize_session=False)
                        dbSession.commit()
                    except Exception as e:
                        Api.json_exception(e)
                        return cantDelete

            # new records
            new_selection = [i for i in selected if i.qualification_id not in exist_q]

            # update
            if commit_exists:
                dbSession.add_all(ql_db)

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

    @route("/edit-class/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def edit_class(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)

        label_edit = json.loads(request.data)

        if not school_id or not label_edit:
            return notFound

        edit_selection = [
            Qualification(
                id=x["id"],
                code=x["code"] if "code" in x else "000",
                label=x["label"] if "label" in x else "new class",
                level=x["level"] if "level" in x else "new level",
                education=x["education"] if "education" in x else "new education",
                school_id=school_id,
            )
            for x in label_edit
        ]
        try:
            if len(edit_selection) > 0:
                for c in edit_selection:
                    if c.id:  # update
                        c.query.filter_by(id=c.id, school_id=c.school_id).update(
                            {Qualification.label: c.label}
                        )
                    else:  # insert
                        c.id = None
                        dbSession.add(c)
            else:
                return notFound

            dbSession.commit()

            qList = [i.serialize() for i in edit_selection]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/edit-level/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def edit_level(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)

        level_edit = json.loads(request.data)

        if not school_id or not level_edit:
            return notFound

        updated_selection = []
        edit_selection = [
            {
                "code": c["code"] if "code" in x else "000",
                "label": x["label"] if "label" in x else "new label",
                "new_level": x["new_level"] if "new_level" in x else None,
                "level": x["level"] if "level" in x else "new level",
                "education": x["education"] if "education" in x else "new education",
                "school_id": school_id,
            }
            for x in level_edit
        ]
        try:
            if len(edit_selection) > 0:
                for c in edit_selection:
                    if c["new_level"]:  # update

                        list_q = Qualification.query.filter_by(
                            level=c["level"],
                            education=c["education"],
                            school_id=c["school_id"],
                        ).all()

                        for q in list_q:
                            q.level = c["new_level"]
                            updated_selection.append(q)
                    else:  # insert
                        nq = Qualification(
                            code=c["code"],
                            label=c["label"],
                            level=c["level"],
                            education=c["education"],
                            school_id=school_id,
                        )
                        dbSession.add(nq)
                        updated_selection.append(nq)
            else:
                return notFound

            dbSession.commit()

            qList = [i.serialize() for i in updated_selection]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/delete-level/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def delete_level(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        cantDelete = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_classes_prof_canceled
        )
        class_remove = json.loads(request.data)

        if not school_id or not class_remove:
            return notFound

        delete_selection = [x["id"] for x in class_remove]
        try:
            dbSession.query(SchoolSubject).filter(
                SchoolSubject.qualification_id.in_(delete_selection),
                SchoolSubject.school_id == school_id,
            ).delete(synchronize_session=False)

            dbSession.query(SchoolQualification).filter(
                SchoolQualification.qualification_id.in_(delete_selection),
                SchoolQualification.school_id == school_id,
            ).delete(synchronize_session=False)

            dbSession.query(Qualification).filter(
                Qualification.id.in_(delete_selection),
                Qualification.school_id == school_id,
            ).delete(synchronize_session=False)

            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"school_id": school_id})

        except Exception as e:
            Api.json_exception(e)
            return cantDelete

    @route("/edit-education/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def edit_education(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)

        level_edit = json.loads(request.data)

        if not school_id or not level_edit:
            return notFound

        updated_selection = []
        edit_selection = [
            {
                "code": c["code"] if "code" in x else "000",
                "label": x["label"] if "label" in x else "new label",
                "level": x["level"] if "level" in x else "new level",
                "new_education": x["new_education"] if "new_education" in x else None,
                "education": x["education"] if "education" in x else "new education",
                "school_id": school_id,
            }
            for x in level_edit
        ]
        try:
            if len(edit_selection) > 0:
                for c in edit_selection:
                    if c["new_education"]:  # update

                        list_q = Qualification.query.filter_by(
                            education=c["education"],
                            school_id=c["school_id"],
                        ).all()

                        for q in list_q:
                            q.education = c["new_education"]
                            updated_selection.append(q)
                    else:  # insert
                        nq = Qualification(
                            code=c["code"],
                            label=c["label"],
                            level=c["level"],
                            education=c["education"],
                            school_id=school_id,
                        )
                        dbSession.add(nq)
                        updated_selection.append(nq)
            else:
                return notFound

            dbSession.commit()

            qList = [i.serialize() for i in updated_selection]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/delete-education/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def delete_education(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        cantDelete = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_classes_prof_canceled
        )
        class_remove = json.loads(request.data)

        if not school_id or not class_remove:
            return notFound

        delete_selection = [x["id"] for x in class_remove]
        try:
            dbSession.query(SchoolSubject).filter(
                SchoolSubject.qualification_id.in_(delete_selection),
                SchoolSubject.school_id == school_id,
            ).delete(synchronize_session=False)

            dbSession.query(SchoolQualification).filter(
                SchoolQualification.qualification_id.in_(delete_selection),
                SchoolQualification.school_id == school_id,
            ).delete(synchronize_session=False)

            dbSession.query(Qualification).filter(
                Qualification.id.in_(delete_selection),
                Qualification.school_id == school_id,
            ).delete(synchronize_session=False)

            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"school_id": school_id})

        except Exception as e:
            Api.json_exception(e)
            return cantDelete

    @route("/init-type-qualification/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def init_type_qualification(self, school_id):
        # time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        cantDelete = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.deletion_classes_prof_canceled
        )

        type_qualification = json.loads(request.data)

        if not school_id or not type_qualification:
            return notFound

        new_selection = [
            Qualification(
                code=x["id"],
                label=x["label"],
                level=x["level"],
                education=x["education"],
                school_id=school_id,
            )
            for x in type_qualification
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
