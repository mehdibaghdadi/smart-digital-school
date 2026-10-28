
from ...imports import *


# ---------------view
class InstructorSchoolView(Api):
    route_prefix = ""
    route_base = "/school/instructor/"
    top_list = 10

    @login_required
    @role_required(role=ROLES.School.value)
    @route("", methods=Api.GET)
    def index(self):
        from ..commun.country_controller import CountryManager

        cities = (CountryManager()).getListCities()
        countries = (CountryManager()).getListCountries()
        instructor_list = (InstructorSchoolManager()).getList(current_user.id, 0)
        instructor_update_password_url = url_for(
            "InstructorSchoolManager:reset_password", school_id=current_user.id
        )
        instructor_active_user_url = url_for(
            "InstructorSchoolManager:active_user", school_id=current_user.id
        )
        instructor_update_profile_url = url_for(
            "InstructorSchoolManager:profile_update", school_id=current_user.id
        )
        instructor_delete_url = url_for(
            "InstructorSchoolManager:delete_user", school_id=current_user.id
        )
        instructor_edit_url = url_for("InstructorSchoolView:edit_1")
        instructor_add_url = url_for("InstructorSchoolView:add")
        return render_template(
            "/schools/instructor/instructor-list.html",
            instructor_list=instructor_list,
            instructor_add_url=instructor_add_url,
            instructor_update_password_url=instructor_update_password_url,
            instructor_active_user_url=instructor_active_user_url,
            instructor_update_profile_url=instructor_update_profile_url,
            instructor_delete_url=instructor_delete_url,
            cities=cities,
            countries=countries,
            instructor_edit_url=instructor_edit_url,
        )

    @login_required
    @role_required(role=ROLES.School.value)
    @route("/add", methods=Api.GET)
    def add(self):
        school_id = current_user.id
        from ..packages.package_controller import PackageManager

        pack = (PackageManager()).get(current_user.package_id)
        max_teachers = pack["max_teachers"]

        from ..commun.country_controller import CountryManager

        cities = (CountryManager()).getListCities()
        countries = (CountryManager()).getListCountries()

        from .subject_controller import SubjectSchoolManager

        s_api = SubjectSchoolManager()

        instructor_list = (InstructorSchoolManager()).getList(school_id, self.top_list)

        instructor_list_json = []
        if instructor_list.status_code == 200:
            jsonr = instructor_list.json
            instructor_list_json = (
                jsonr["response"] if (jsonr and jsonr["status"] == 200) else []
            )

        # Max exceed
        max_teachers_exceed = len(instructor_list_json) >= max_teachers

        instructor_add_url = url_for(
            "InstructorSchoolManager:add_edit_0", school_id=school_id
        )
        instructor_edit_url = url_for("InstructorSchoolView:edit_1")

        subject = s_api.getListSubjectPredefined(school_id)
        subject_db = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        instructor = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        instructor_add_new_url = url_for("InstructorSchoolView:add")
        instructor_list_url = url_for("InstructorSchoolView:index")

        return render_template(
            "/schools/instructor/instructor-edit.html",
            mode_edit=0,
            instructor=instructor,
            instructor_list=instructor_list,
            instructor_add_url=instructor_add_url,
            instructor_edit_url=instructor_edit_url,
            instructor_add_new_url=instructor_add_new_url,
            instructor_list_url=instructor_list_url,
            top_list=self.top_list,
            url_save_update="-",
            subject=subject,
            subject_db=subject_db,
            cities=cities,
            countries=countries,
            max_teachers=max_teachers,
            max_teachers_exceed=max_teachers_exceed,
        )

    @login_required
    @role_required(role=ROLES.School.value)
    @route("/edit", defaults={"instructor_id": 0}, methods=Api.GET)
    @route("/edit/<instructor_id>", methods=Api.GET)
    def edit(self, instructor_id):
        school_id = current_user.id
        from ..packages.package_controller import PackageManager

        pack = (PackageManager()).get(current_user.package_id)
        max_teachers = pack["max_teachers"]

        from ..commun.country_controller import CountryManager

        cities = (CountryManager()).getListCities()
        countries = (CountryManager()).getListCountries()

        from .subject_controller import SubjectSchoolManager

        s_api = SubjectSchoolManager()
        in_api = InstructorSchoolManager()

        instructor = in_api.get(school_id, instructor_id)
        if instructor.status_code != 200:
            abort(404)

        subject_db = in_api.getListSubject(instructor_id)
        instructor_list = in_api.getList(school_id, self.top_list)

        instructor_list_json = []
        if instructor_list.status_code == 200:
            jsonr = instructor_list.json
            instructor_list_json = (
                jsonr["response"] if (jsonr and jsonr["status"] == 200) else []
            )

        # Max exceed
        max_teachers_exceed = len(instructor_list_json) >= max_teachers

        instructor_add_url = url_for(
            "InstructorSchoolManager:add_edit_1",
            school_id=school_id,
            instructor_id=instructor_id,
        )
        instructor_edit_url = url_for("InstructorSchoolView:edit_1")
        subject = s_api.getListSubjectPredefined(school_id)

        instructor_add_new_url = url_for("InstructorSchoolView:add")
        instructor_list_url = url_for("InstructorSchoolView:index")

        return render_template(
            "/schools/instructor/instructor-edit.html",
            mode_edit=1,
            instructor=instructor,
            instructor_list=instructor_list,
            instructor_add_url=instructor_add_url,
            instructor_edit_url=instructor_edit_url,
            instructor_add_new_url=instructor_add_new_url,
            instructor_list_url=instructor_list_url,
            top_list=self.top_list,
            url_save_update="-",
            subject=subject,
            subject_db=subject_db,
            cities=cities,
            countries=countries,
            max_teachers=max_teachers,
            max_teachers_exceed=False,
        )


# ---------------Api
class InstructorSchoolManager(Api):
    route_base = "/school-instructor-manager/"

    @route("/get/<school_id>/<instructor_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def get(self, school_id, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            user = (
                Instructor.query.options(noload("*"))
                .filter_by(id=instructor_id, school_id=school_id)
                .one_or_none()
            )

            if not user:
                return notFound

            img = getImage(user.image)
            setattr(user, "image", img)

            dbSession.expunge(user)

            return Api.json_response(HTTPStatus.OK, user.serialize())
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list/<school_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getList(self, school_id, top):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = self.__getInstructorTopList(school_id, top)
            if not qList:
                return notFound

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @classmethod
    def __getInstructorTopList(self, school_id, top):
        try:
            query = Instructor.query.options(noload("*")).filter_by(school_id=school_id)
            qList = (
                query.order_by(Instructor.id.desc()).limit(top)
                if top > 0
                else query.order_by(Instructor.id.desc()).all()
            )

            if not qList:
                return None

            for u in qList:
                img = getImage(u.image)
                setattr(u, "image", img)

            qList = [i.serialize() for i in qList]
            return qList
        except Exception as inst:
            Api.json_exception(inst)
            return None

    @route("/edit/<school_id>/<instructor_id>", methods=Api.POST)
    @route("/add/<school_id>", defaults={"instructor_id": 0}, methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def add_edit(self, school_id, instructor_id):
        notFound = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.registration_canceled_data_incorrect
        )
        dataSbError = Api.json_response(
            HTTPStatus.BAD_REQUEST, ARS.account_ok_classes_incorrect
        )
        duplicateLogin = Api.json_response(HTTPStatus.CONFLICT, ARS.login_conflict)
        from ..instructors.subject_controller import SubjectInstructorManager

        s_api = SubjectInstructorManager()

        try:

            all_data = json.loads(request.data)
            user = None

            instructor = all_data[0]
            instructorSubjectData = all_data[1]

            id = instructor["id"]
            is_new = True if (id == instructor_id and instructor_id <= 0) else False

            email = instructor["email"]
            password = instructor["password"]
            last_name = instructor["last_name"]
            first_name = instructor["first_name"]
            phone_primary = instructor["phone_primary"]
            phone_secondary = (
                instructor["phone_secondary"]
                if "phone_secondary" in instructor
                else None
            )
            date_birth = instructor["date_birth"] if "date_birth" in instructor else None
            address = instructor["address"] if "address" in instructor else None
            introduction_brief = (
                instructor["introduction_brief"]
                if "introduction_brief" in instructor
                else None
            )
            country_city_id = (
                instructor["country_city_id"]
                if "country_city_id" in instructor
                else None
            )
            country_id = (
                instructor["country_id"] if "country_id" in instructor else None
            )

            active_account = (
                instructor["active_account"] if "active_account" in instructor else 1
            )

            if not school_id or not instructor or not instructorSubjectData:
                return notFound

            if is_new:
                exists = (
                    dbSession.query(UserApp.id).filter_by(email=email).first()
                    is not None
                )
                if exists == True:
                    return duplicateLogin

                user = Instructor(
                    school_id=school_id,
                    email=email,
                    password=password,
                    last_name=last_name,
                    first_name=first_name,
                    phone_primary=phone_primary,
                    phone_secondary=phone_secondary,
                    date_birth=date_birth,
                    address=address,
                    introduction_brief=introduction_brief,
                    country_city_id=country_city_id,
                    country_id=country_id,
                    registration_date=datetime.today(),
                    active_account=active_account,
                    image=None,
                )
                dbSession.add(user)
            else:
                user = (
                    Instructor.query.options(noload("*"))
                    .filter_by(id=instructor_id)
                    .first()
                )
                if user:
                    user.first_name = first_name
                    user.last_name = last_name
                    user.password = password
                    user.phone_primary = phone_primary
                    user.phone_secondary = phone_secondary
                    user.date_birth = date_birth
                    user.address = address
                    user.introduction_brief = introduction_brief
                    user.country_city_id = country_city_id
                    user.country_id = country_id
                    user.active_account = active_account
                else:
                    return notFound

            # insert update
            dbSession.commit()

            # update list classroom
            rslt_subject = s_api.save_update_internal(user.id, instructorSubjectData)
            if rslt_subject.status_code != 200:
                return dataSbError

            instructor_list = (InstructorSchoolManager()).__getInstructorTopList(
                school_id, InstructorSchoolView.top_list
            )
            return Api.json_response(
                HTTPStatus.OK,
                {"instructor_id": user.id, "instructor_list": instructor_list},
            )
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/profile-update/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def profile_update(self, school_id):
        # time.sleep(3)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        data = json.loads(request.data)
        id = data["id"]
        email = data["email"]
        password = data["password"]
        first_name = data["first_name"]
        last_name = data["last_name"]
        phone_primary = data["phone_primary"]
        phone_secondary = data["phone_secondary"] if "phone_secondary" in data else None
        date_birth = data["date_birth"] if "date_birth" in data else None
        address = data["address"] if "address" in data else None
        introduction_brief = (
            data["introduction_brief"] if "introduction_brief" in data else None
        )
        country_city_id = data["country_city_id"] if "country_city_id" in data else None
        country_id = data["country_id"] if "country_id" in data else None

        if not id:
            return notFound
        try:

            user = Instructor.query.options(noload("*")).filter_by(id=id).first()
            if user:
                user.password = password
                user.first_name = first_name
                user.last_name = last_name
                user.phone_primary = phone_primary
                user.phone_secondary = phone_secondary
                user.date_birth = date_birth
                user.address = address
                user.introduction_brief = introduction_brief
                user.country_city_id = country_city_id
                user.country_id = country_id
                dbSession.commit()
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": user.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/reset-password/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def reset_password(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        instructor = request.form
        id = instructor["id"]
        email = instructor["email"]
        password = instructor["password"]

        if not school_id or not id or not instructor:
            return notFound

        try:
            user = (
                Instructor.query.options(noload("*"))
                .filter_by(id=id, email=email, school_id=school_id)
                .first()
            )
            if user:
                user.password = password
                dbSession.commit()
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": user.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/active-user/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def active_user(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        instructor = json.loads(request.data)
        id = instructor["id"]
        email = instructor["email"]
        active_account = instructor["active_account"]

        if not school_id or not id or not instructor:
            return notFound

        try:
            user = (
                Instructor.query.options(noload("*"))
                .filter_by(id=id, email=email, school_id=school_id)
                .first()
            )
            if user:
                user.active_account = active_account
                dbSession.commit()
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": user.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/delete-user/<school_id>", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def delete_user(self, school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.registration_canceled)
        instructor = json.loads(request.data)
        id = instructor["id"]
        email = instructor["email"]

        if not school_id or not id or not instructor:
            return notFound

        try:
            user = (
                Instructor.query.options(noload("*"))
                .filter_by(id=id, email=email, school_id=school_id)
                .first()
            )
            if user:
                try:
                    dbSession.query(InstructorSubject).filter_by(
                        instructor_id=user.id
                    ).delete(synchronize_session=False)
                    dbSession.delete(user)
                    dbSession.commit()
                except SQLAlchemyError as e:
                    return Api.json_response(
                        HTTPStatus.BAD_REQUEST, ARS.deletion_prof_canceled
                    )
            else:
                return notFound

            return Api.json_response(HTTPStatus.OK, {"id": user.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list-subject/<instructor_id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def getListSubject(self, instructor_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = (
                InstructorSubject.query.options(noload("*"))
                .filter_by(instructor_id=instructor_id)
                .all()
            )

            if not qList:
                return notFound

            qList = [i.serialize() for i in qList]

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)