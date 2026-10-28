from ...imports import *
import string
from random import choice
import pickle
from ...utilities.flask.flask_logging import log_user_connection_async

# ---------------view
class AccountView(Api):
    route_prefix = ""
    route_base = "/account/"
    # @classmethod
    # def setRoleCookies(self,value):
    #     https://localhost:8443/

    @route("/login", methods=Api.GET)
    def login(self):
        # Check if the 'role' cookie exists
        role = request.cookies.get("role_login")

        if role:
            # If the role cookie exists, check its value and call the appropriate method
            if role == ROLES.Any.value:
                return self.login_user()
            else:
                return self.login_school()
        else:
            # If the role cookie doesn't exist, call login_user
            return self.login_user()

    @route("/login/user", methods=Api.GET)
    def login_user(self):
        # Set the 'role' cookie to ROLES.Any.value
        response = make_response(
            render_template(
                "/accounts/login.html",
                roles=ROLES.Any.value,
                sign_in_url=url_for("AccountManager:sign_in"),
            )
        )
        response.set_cookie(
            "role_login", ROLES.Any.value, max_age=60 * 60 * 24 * 365 * 10
        )
        return response

    @route("/login/school", methods=Api.GET)
    def login_school(self):
        # Set the 'role' cookie to ROLES.School.value
        response = make_response(
            render_template(
                "/accounts/login.html",
                roles=ROLES.School.value,
                sign_in_url=url_for("AccountManager:sign_in"),
            )
        )
        response.set_cookie(
            "role_login", ROLES.School.value, max_age=60 * 60 * 24 * 365 * 10
        )
        return response

    @route("/login-from-site/<lang>", methods=Api.GET)
    def loginFromSite(self, lang):
        session["lang"] = lang

        url_login = url_for("AccountView:login")
        return redirect(url_login)

    @route("/login-unauthorized", methods=Api.GET)
    def loginUnauthorized(self):
        return render_template("/accounts/login-unauthorized.html")

    @route("/logout", methods=Api.GET)
    def logout(self):
        url_login = url_for("AccountView:login")
        try:
            if current_user:
                url_login = (
                    url_for("AccountView:login")
                    if current_user.role != ROLES.School.value
                    else url_for("AccountView:login_school")
                )
                current_user.active_account = False
                logout_user()
                loginSession.delete_session()
                loginSession.reset_user_data()


            return redirect(url_login)
        except Exception as inst:
            Api.log_exception(inst)

        return redirect(url_login)

    @route("/forgot-password", methods=Api.GET)
    def forgot_password(self):
        return render_template(
            "/accounts/forgot-password.html",
            forgot_password_url=url_for("AccountManager:forgot_password"),
        )

    @route("/recover-password", methods=Api.POST)
    def recover_password(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        url_login = url_for("AccountView:login")
        try:
            id = int(request.form["id"])
            email = request.form["email"]
            role = request.form["role"]
            url_redirect = request.form["url_redirect"]
            mail_sent = request.form["mail_sent"]

            url_origin = url_for("AccountView:recover_password")
            if url_redirect != url_origin:
                redirect(url_login)

            return render_template(
                "/accounts/recover-password.html",
                id=id,
                email=email,
                role=role,
                reset_password_url=url_for("AccountManager:reset_password"),
            )

        except:
            pass
        redirect(url_login)

    @login_required
    @route("/change-password", methods=Api.GET)
    def change_password(self):
        user = {
            "id": current_user.id,
            "email": current_user.email,
            "role": current_user.role,
        }
        return render_template(
            "/accounts/change-password.html",
            user=user,
            change_password_url=url_for("AccountManager:change_password"),
        )

    @route("/register", methods=Api.GET_POST)
    def register_user(self):
        from ..commun.school_type_controller import SchoolTypeManager
        from ..commun.country_controller import CountryManager

        session["captcha_challenge"] = ""

        countries = (CountryManager()).getListCountries()
        schoolTypes = (SchoolTypeManager()).getList()
        captchaImgUrl = url_for("CaptchaManager:captcha")
        return render_template(
            "/accounts/register.html",
            register_url=url_for("AccountManager:register_school"),
            countries=countries,
            schoolTypes=schoolTypes,
            captchaImgUrl=captchaImgUrl,
        )

    @route("/register-from-site/<lang>", methods=Api.GET)
    def registerFromSite(self, lang):
        session["lang"] = lang

        url_login = url_for("AccountView:register_user")
        return redirect(url_login)

    @route("/register-completed", methods=Api.GET)
    def register_user_complete(self):
        url_login = url_for("AccountView:login_school")
        url_login_user = url_for("AccountView:login")

        captcha_challenge = session.get("captcha_challenge", "")
        if len(captcha_challenge) == 0:
            return redirect(url_login_user)

        session["captcha_challenge"] = ""
        return render_template("/accounts/register-completed.html", url_login=url_login)

    @route("/terms-conditions", methods=Api.GET_POST)
    def terms_conditions(self):
        return render_template("/accounts/terms-conditions.html")

    @route("/deletion", methods=Api.GET_POST)
    def deletion(self):
        return render_template("/accounts/account-deletion.html")


# ---------------API
class AccountManager(Api):
    route_base = "/account-manager/"

    @route("/sign-in", methods=Api.POST)
    @limiter.limit(
        limit.login,
        error_message=ARS.too_many_attempts,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def sign_in(self):
        # time.sleep(1)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            data = json.loads(request.data)
            role = data["type"]
            email = data["email"]
            password = data["password"]
            remember = data["remember"]
            remember_me = int(remember) == 1
            session.permanent = True
            duration = None

            loginSession.reset_user_data()
            loginSession.set_remember_me(remember_me)
            duration = self.get_duration_session(remember_me)

            user = self.build_login_session(0, email, password, role)
            if user is None:
                return Api.json_response(
                    HTTPStatus.BAD_REQUEST, ARS.login_password_incorrect
                )
            
            loginSession.set_user_data(user.to_dict())

            next_url = session.pop('next_url', None)

            if not user.active_account:
                user.url_index = url_for("AccountView:loginUnauthorized")
                next_url=None


            login_user(
                user,
                remember=remember_me,
                duration=duration,
                force=False,
                fresh=(remember_me == False),
            )
            url_index = next_url or user.url_index
            return Api.json_response(HTTPStatus.OK, url_index)
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/reset-password", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def reset_password(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            code_recovery = loginSession.get_code_recovery_pass()
            data = json.loads(request.data)
            id = int(data["id"])
            email = data["email"]
            password = data["password"]
            password_confirm = data["password_confirm"]
            role = data["role"]
            code_digit = data["code_digit"]
            option = noload("*")
            user = None

            if code_digit != code_recovery:
                return Api.json_response(
                    HTTPStatus.UPGRADE_REQUIRED, ARS.code_incorrect
                )  # 426

            if password != password_confirm:
                return Api.json_response(
                    HTTPStatus.BAD_REQUEST, ARS.passwords_not_identical
                )

            if id <= 0:
                return notFound

            if role == ROLES.Student.value:
                user = (
                    Student.query.options(option).filter_by(id=id, email=email).first()
                )
            elif role == ROLES.Instructor.value:
                user = (
                    Instructor.query.options(option)
                    .filter_by(id=id, email=email)
                    .first()
                )
            elif role == ROLES.School.value:
                user = (
                    School.query.options(option).filter_by(id=id, email=email).first()
                )

            if user is None:
                return Api.json_response(
                    HTTPStatus.BAD_REQUEST, ARS.login_password_incorrect
                )

            user.password = password
            dbSession.commit()

            url_redirect = url_for("AccountView:login")
            loginSession.set_code_recovery_pass("_-_-|-_-_")  # Anything

            return Api.json_response(
                HTTPStatus.OK, {"id": user.id, "url_redirect": url_redirect}
            )
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/forgot-password", methods=Api.POST)
    @limiter.limit(
        limit.login,
        error_message=ARS.too_many_attempts,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def forgot_password(self):

        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            data = json.loads(request.data)
            email = data["email"]
            phone_primary = data["phone_primary"]
            mail_sent = False
            user = None  # user build
            url_redirect = None  # first page after login

            user = UserApp.query.filter_by(
                email=email, phone_primary=phone_primary
            ).first()

            if user is None:
                return Api.json_response(
                    HTTPStatus.BAD_REQUEST, ARS.login_phone_incorrect
                )

            chars = string.digits
            code_recovery = "".join(choice(chars) for _ in range(4))

            msg_title = ARS.passwords_reset
            msg_html = ARS.passwords_reset_mail.format(user.email, code_recovery)
            msg_html += ARS.passwords_reset_mail_warning

            loginSession.set_code_recovery_pass(code_recovery)
            mail_sent = SendMail(msg_title, msg_html, email)

            url_redirect = url_for("AccountView:recover_password")
            data = {
                "id": user.id,
                "email": user.email,
                "role": user.role,
                "url_redirect": url_redirect,
                "mail_sent": mail_sent,
            }

            return Api.json_response(HTTPStatus.OK, data)
        except Exception as inst:
            return Api.json_exception(inst)
        return render_template("/accounts/forgot-password.html")

    @route("/change-password", methods=Api.POST)
    @limiter.limit(
        limit.slow,
        error_message=limit.slow,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def change_password(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            data = json.loads(request.data)
            role = data["role"]
            id = data["id"]
            email = data["email"]
            old_password = data["old_password"]
            password = data["password"]
            password_confirm = data["password_confirm"]
            option = noload("*")
            user = None

            if id <= 0:
                return notFound

            if password != password_confirm:
                return Api.json_response(
                    HTTPStatus.BAD_REQUEST, ARS.passwords_not_identical
                )
            if role == ROLES.Student.value:
                user = (
                    Student.query.options(option)
                    .filter_by(id=id, email=email, password=old_password)
                    .first()
                )
            elif role == ROLES.Instructor.value:
                user = (
                    Instructor.query.options(option)
                    .filter_by(id=id, email=email, password=old_password)
                    .first()
                )
            elif role == ROLES.School.value:
                user = (
                    School.query.options(option)
                    .filter_by(id=id, email=email, password=old_password)
                    .first()
                )

            if user is None:
                return Api.json_response(
                    HTTPStatus.BAD_REQUEST, ARS.login_password_incorrect
                )

            user.password = password
            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"id": user.id})
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/register-school", methods=Api.POST)
    @limiter.limit(limit.slow, error_message=ARS.too_many_attempts)
    @auth.login_required
    def register_school(self):
        
        from ..packages.package_controller import PackageManager
        login_conflict = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.login_conflict)

        try:
            captcha_challenge = session.get("captcha_challenge", "")
            captcha_incorrect = Api.json_response(
                HTTPStatus.BAD_REQUEST,
                ARS.captcha_incorrect + f" : {captcha_challenge}",
            )

            data = json.loads(request.data)

            captcha_answer = data["captcha_answer"]

            if captcha_answer != captcha_challenge:
                return captcha_incorrect

            email = data["email"]
            exist = dbSession.query(
                UserApp.query.filter_by(email=email).exists()
            ).scalar()

            if exist:
                return login_conflict

            full_name = data["full_name"]
            password = data["password"]
            phone_primary = data["phone_primary"]
            country_id = data["country_id"] if "country_id" in data else None
            school_type_id = (
                data["school_type_id"] if "school_type_id" in data else None
            )

            today = datetime.today()

            package_id = data.get("package_id", PACKAGE.Demo.id)

            renewal_date = data.get("renewal_date", None)

            if package_id == PACKAGE.Demo.id:
                pack=(PackageManager()).get(package_id)
                duration_days = int(pack["duration_days"])
                renewal_date = today + relativedelta(days=duration_days)

            new_user = School()
            new_user.name = full_name
            new_user.email = email
            new_user.phone_primary = phone_primary
            new_user.password = password
            new_user.registration_date = today
            new_user.country_id = country_id
            new_user.school_type_id = school_type_id
            new_user.active_account = True
            new_user.package_id = package_id
            new_user.renewal_date = renewal_date

            dbSession.add(new_user)
            dbSession.commit()

            return Api.json_response(
                HTTPStatus.OK, url_for("AccountView:register_user_complete")
            )
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/reset-user-data", methods=Api.POST)
    @limiter.limit(
        limit.fast,
        error_message=limit.fast,
        deduct_when=lambda response: response.status_code != 200,
    )
    @auth.login_required
    def reset_user_data(self):
        notMe = Api.json_response(HTTPStatus.OK, "Notkink to reset")

        data = json.loads(request.data)
        email_target = data["email_target"]
        email_sender = data["email_sender"]

        if email_target in [current_user.email, "ALL"] and email_sender in [
            current_user.email_school,
            "ADMIN",
        ]:
            loginSession.reset_user_data()
        else:
            return notMe

        return Api.json_response(
            HTTPStatus.OK,
            f"data user reset : target:{email_target}, sender: {email_sender}",
        )

    # --- PRIVATE ----
    @classmethod
    def build_login_session(self, id, email, password, role, do_log=True):

        u = None  # user
        user = None  # user build
        url_redirect = None  # first page after login
        option = noload("*")
        # Get from database
        if role == ROLES.Student.value:
            url_redirect = url_for("DashboardStudentView:index")
            if id > 0:
                u = Student.query.options(option).get(id)
            else:
                u = (
                    Student.query.options(option)
                    .filter_by(email=email, password=password)
                    .first()
                )

        elif role == ROLES.Instructor.value:
            url_redirect = url_for("DashboardInstructorView:index")
            if id > 0:
                u = Instructor.query.options(option).get(id)
            else:
                u = (
                    Instructor.query.options(option)
                    .filter_by(email=email, password=password)
                    .first()
                )

        elif role == ROLES.School.value:
            url_redirect = url_for("DashboardSchoolView:index")
            if id > 0:
                u = School.query.options(option).get(id)
            else:
                u = (
                    School.query.options(option)
                    .filter_by(email=email, password=password)
                    .first()
                )

        elif role == ROLES.Admin.value:
            url_redirect = url_for("IndexAdminView:index")
            if id > 0:
                u = School.query.options(option).get(id)
            else:
                u = (
                    School.query.options(option)
                    .filter_by(email=email, password=password, active_account=True)
                    .first()
                )

        else:
            return None

        # Build object user
        if u:
            # Set login session
            loginSession.set_role_session(role)

            # Log user connection  
            if do_log: 
                log_user_connection_async(user_id=u.id, role=role, dbSession=dbSession)

            from ..commun.school_type_controller import SchoolTypeManager
            if role != ROLES.School.value:
                sch = School.query.options(option).get(u.school_id)  # get school
                user = loginSession(
                    u.id,
                    role,
                    u.first_name,
                    u.last_name,
                    u.email,
                    sch.email,
                    u.image,
                    u.active_account,
                    url_redirect,
                    sch.image,
                    sch.name,
                    u.school_id,
                    sch.school_type_id,
                    "school_type",
                    sch.package_id if sch.package_id else PACKAGE.Demo.id,
                    sch.renewal_date,
                )
            else:
                user = loginSession(
                    u.id,
                    role,
                    u.name,
                    "",
                    u.email,
                    u.email,
                    u.image,
                    u.active_account,
                    url_redirect,
                    u.image,
                    u.name,
                    u.id,
                    u.school_type_id,
                    "school_type",
                    u.package_id if u.package_id else PACKAGE.Demo.id,
                    u.renewal_date,
                )

            try:
                user.school_type = (SchoolTypeManager()).get(id=user.school_type_id)[
                    "label"
                ]

            except Exception as inst:
                user.school_type = user.role  # fake data

        else:
            user = None

        return user

    @classmethod
    def get_duration_session(self, remember_me):
        return (
            app.config["PERMANENT_SESSION_LIFETIME_REMEMBER"]
            if remember_me
            else app.config["PERMANENT_SESSION_LIFETIME_FORGET"]
        )


# --------------- LOGIN MANAGER
@app.login_manager.user_loader
def load_user(user_id):
    try:
        role = loginSession.get_role_session()

        if user_id is None or role is None:
            return None

        # Log session data for debugging

        session_data = loginSession.get_user_data()

        if session_data is not None:
            user_data = loginSession.from_dict(session_data)
            return user_data

        # If session lost Build the user object (Optionnel)
        manager = AccountManager()
        user = manager.build_login_session(int(user_id), None, None, role,False)
        user.role = role
        if user:
            loginSession.set_user_data(user.to_dict())
        return user

    except Exception as inst:
        loginSession.reset_user_data()
        Api.log_exception(inst)
        return None


@app.login_manager.unauthorized_handler
def unauthorized_handler():
    next_url = url_for(request.endpoint, **request.view_args)
    session['next_url'] = next_url
    return redirect(url_for("AccountView:login", next=next_url))


@app.before_request
def make_session_permanent():
    try:
        remember_me = False
        remember_me = loginSession.get_remember_me()
        session.permanent = True
        app.permanent_session_lifetime = (AccountManager()).get_duration_session(
            remember_me=remember_me
        )
    except Exception as inst:
        return Api.json_exception(inst)
