from ...imports import *


# ---------------view
class ProfileStudentView(Api):
    route_prefix = ""
    route_base = "/student/"

    @login_required
    @role_required(role=ROLES.Student.value)
    @route("/profile", methods=Api.GET)
    def index(self):
        user = (ProfileStudentManager()).get(current_user.id)
        from ..commun.country_controller import CountryManager

        cities = (CountryManager()).getListCities()
        countries = (CountryManager()).getListCountries()

        return render_template(
            "/accounts/profile/profile.html",
                               user = user,
                               cities = cities,
                               countries = countries,
                               roles=ROLES.Student.value,
                               profile_update_url=url_for("ProfileStudentManager:profile_update"))


# ---------------Api
class ProfileStudentManager(Api):
    route_base = "/student-profile-manager/"

    @route("/profile/<id>", methods=Api.GET)
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    def get(self, id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        if not id:
            return notFound
        try:
            user = StudentProfile.query.options(noload("*")).filter_by(id=id).first()
            if not user:
                return notFound

            img = getImage(user.image)
            setattr(user, "image", img)

            return Api.json_response(HTTPStatus.OK, user.serialize())
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/profile-update", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def profile_update(self):
        # time.sleep(5)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        data = json.loads(request.data)
        id = data["id"]
        email = data["email"]
        first_name = data["first_name"]
        last_name = data["last_name"]
        phone_primary = data["phone_primary"]
        phone_secondary = data["phone_secondary"] if "phone_secondary" in data else None
        address = data["address"] if "address" in data else None
        country_city_id = data["country_city_id"] if "country_city_id" in data else None
        country_id = data["country_id"] if "country_id" in data else None
        image = None
        image_path = None
        user=None

        if not id :
            return notFound

        try:
            user = Student.query.options(noload('*')).filter_by(id=id).first()
            if 'image' in data:
              image_path  = uploadImage(data['image'],'profils',email,user.image)
        except Exception as inst:
            image_path=None
            Api.json_exception(inst)
            pass

        try:

            if user is None:
                user = Student.query.options(noload("*")).filter_by(id=id).first()
            if user:
                user.first_name = first_name
                user.last_name = last_name
                user.phone_primary = phone_primary
                user.phone_secondary = phone_secondary
                user.address = address
                user.image = image_path if image_path else user.image 
                user.country_city_id = country_city_id
                user.country_id = country_id
                dbSession.commit()
            else:
                return notFound

            loginSession.reset_user_data()
            return Api.json_response(HTTPStatus.OK, {"id": user.id})
        except Exception as inst:
            return Api.json_exception(inst)