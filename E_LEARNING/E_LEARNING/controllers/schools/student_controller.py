from ...imports import  *

#---------------view
class StudentSchoolView(Api):
    route_prefix = ""    
    route_base = "/school/student/" 
    top_list = 10

    @login_required
    @role_required(role=ROLES.School.value)
    @route("",methods=Api.GET)
    def index(self):  
        from ..commun.country_controller import CountryManager
        cities = (CountryManager()).getListCities()
        countries = (CountryManager()).getListCountries()


        from .qualification_controller import QualificationSchoolManager
        qualification_school_list = (QualificationSchoolManager()).getListSaved(current_user.id)
        if qualification_school_list.status_code == 200:
            jsonr = qualification_school_list.json
            qualification_school_list = jsonr['response'] if (jsonr and jsonr['status'] == 200) else []
        else:
            qualification_school_list = []

        student_list = (StudentSchoolManager()).getList(current_user.id,0)
        student_update_password_url = url_for("StudentSchoolManager:reset_password",school_id=current_user.id)
        student_active_user_url = url_for("StudentSchoolManager:active_user",school_id=current_user.id)
        student_update_profile_url = url_for("StudentSchoolManager:profile_update",school_id=current_user.id)
        student_delete_url = url_for("StudentSchoolManager:delete_user",school_id=current_user.id)
        student_add_url= url_for("StudentSchoolView:add")

        return render_template("/schools/students/student-list.html",
                               student_list = student_list,
                               student_add_url = student_add_url ,
                               student_update_password_url = student_update_password_url,
                               student_active_user_url = student_active_user_url,
                               student_update_profile_url = student_update_profile_url,
                               student_delete_url = student_delete_url,
                               cities=cities,
                               countries=countries,
                               qualification_school_list=qualification_school_list)
        
    @login_required
    @role_required(role=ROLES.School.value)
    @route("/add",methods=Api.GET)
    def add(self):  
        from ..packages.package_controller import PackageManager

        pack = (PackageManager()).get(current_user.package_id)
        max_students = pack["max_students"]


        from ..commun.country_controller import CountryManager
        cities = (CountryManager()).getListCities()
        countries = (CountryManager()).getListCountries()

        from .qualification_controller import QualificationSchoolManager
        qualification_school_list = (QualificationSchoolManager()).getListSaved(current_user.id)
        if qualification_school_list.status_code == 200:
            jsonr = qualification_school_list.json
            qualification_school_list = jsonr['response'] if (jsonr and jsonr['status'] == 200) else []
        else:
            qualification_school_list = []


        student_list = (StudentSchoolManager()).getList(current_user.id,self.top_list)
        student_list_json = []
        if student_list.status_code == 200:
            jsonr = student_list.json
            student_list_json = (
                jsonr["response"] if (jsonr and jsonr["status"] == 200) else []
            )

        # Max exceed
        max_students_exceed = len(student_list_json) >= max_students



        student_add_url = url_for("StudentSchoolManager:add",school_id=current_user.id)

        student_add_new_url = url_for("StudentSchoolView:add")
        student_list_url = url_for("StudentSchoolView:index")


        return render_template("/schools/students/student-edit.html",
                               student_list = student_list,
                               student_add_url = student_add_url,
                               qualification_school_list=qualification_school_list,
                               student_add_new_url=student_add_new_url,
                               student_list_url = student_list_url,
                               cities = cities,
                               countries = countries,
                               top_list = self.top_list,
                               max_students=max_students,
                               max_students_exceed = max_students_exceed
                               )
        
#---------------Api
class StudentSchoolManager(Api):  
    route_base = "/school-student-manager/"

    @route("/list/<school_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getList(self,school_id,top):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)
        try: 
            qList = self.__getStudentTopList(school_id,top)
            if not qList:
                return notFound 

            return Api.json_response(HTTPStatus.OK,qList) 
        except Exception as inst :
            return Api.json_exception(inst) 
   
    @auth.login_required
    def __getStudentTopList(self,school_id,top):  
        try: 
            query = StudentProfile.query.options(noload('*')).filter_by(school_id=school_id)
            qList = query.order_by(StudentProfile.id.desc()).limit(top)  if top > 0 else query.order_by(StudentProfile.id.desc()).all()

            if not qList:
                return None 
            
            for user in qList:
                img = getImage(user.image)
                setattr(user,'image' ,img)
                    
            qList = [ i.serialize() for i in qList]
            return qList
        except Exception as inst :
            Api.json_exception(inst) 
            return None

    @route("/add/<school_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def add(self,school_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        duplicateLogin = Api.json_response(HTTPStatus.CONFLICT,ARS.login_conflict)
        classNotFound = Api.json_response(HTTPStatus.CONFLICT,ARS.class_obligatory)
        student = json.loads(request.data)
        email = student["email"]
        password = student["password"]
        last_name = student["last_name"]
        first_name = student["first_name"]
        phone_primary = student["phone_primary"]
        phone_secondary = student['phone_secondary'] if 'phone_secondary' in student else None
        date_birth = student['date_birth']  if 'date_birth' in student else None
        address = student['address']  if 'address' in student else None
        classroom = student["classroom"]
        school_qualification_id = student['school_qualification_id'] if 'school_qualification_id' in student else None
        country_city_id = student['country_city_id'] if 'country_city_id' in student else None
        country_id = student['country_id'] if 'country_id' in student else None
        active_account = student["active_account"] if 'active_account' in student else 1

        if not school_id or not student :
            return notFound

        if not school_qualification_id or school_qualification_id <= 0 :
            return classNotFound

        try:
            exists = dbSession.query(UserApp.id).filter_by(email=email).first() is not None
            if exists == True:
                return duplicateLogin

            student = Student(school_id=school_id,
                                    email = email,
                                    password = password,
                                    last_name = last_name,
                                    first_name = first_name,
                                    phone_primary = phone_primary,
                                    phone_secondary = phone_secondary,
                                    date_birth = date_birth,
                                    address = address,
                                    country_city_id = country_city_id,
                                    country_id = country_id,
                                    school_qualification_id = school_qualification_id,
                                    classroom = classroom,
                                    registration_date =  datetime.today() ,
                                    active_account = active_account,
                                    image = None)
            dbSession.add(student) 
            dbSession.commit()

            student_list = self.__getStudentTopList(school_id,StudentSchoolView.top_list)
            return Api.json_response(HTTPStatus.OK,{'school_id':school_id,'student_list':student_list}) 
        except Exception as inst :
            return Api.json_exception(inst) 

    @route("/reset-password/<school_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def reset_password(self,school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        student = request.form
        id = student["id"]
        email = student["email"]
        password = student["password"]

        if not school_id or not id or not student :
            return notFound

        try:
            user = Student.query.options(noload('*')).filter_by(id=id,email=email,school_id=school_id).first()
            if user :
                user.password = password
                dbSession.commit()
            else:
                return notFound
       
            return Api.json_response(HTTPStatus.OK,{'id':user.id})             
        except Exception as inst :
            return Api.json_exception(inst) 

    @route("/active-user/<school_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def active_user(self,school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        student = json.loads(request.data)
        id = student["id"]
        email = student["email"]
        active_account = student["active_account"]

        if not school_id or not id or not student :
            return notFound

        try:
            user = Student.query.options(noload('*')).filter_by(id=id,email=email,school_id=school_id).first()
            if user :
                user.active_account = active_account
                dbSession.commit()
            else:
                return notFound
       
            return Api.json_response(HTTPStatus.OK,{'id':user.id})             
        except Exception as inst :
            return Api.json_exception(inst) 

    @route("/profile-update/<school_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def profile_update(self,school_id):  
        #time.sleep(3)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)
        classNotFound = Api.json_response(HTTPStatus.CONFLICT,ARS.class_obligatory)
        data = json.loads(request.data)
        id = data['id']
        email = data['email']
        password = data["password"]
        first_name = data['first_name']
        last_name = data['last_name']
        phone_primary = data['phone_primary']
        phone_secondary = data['phone_secondary'] if 'phone_secondary' in data else None
        date_birth = data['date_birth']  if 'date_birth' in data else None
        address = data['address']  if 'address' in data else None
        classroom = data['classroom']
        school_qualification_id = data['school_qualification_id'] if 'school_qualification_id' in data else 0
        country_city_id = data['country_city_id'] if 'country_city_id' in data else None
        country_id = data['country_id'] if 'country_id' in data else None
                       
        if not id :
            return notFound

        if not school_qualification_id or school_qualification_id <= 0 :
            return classNotFound

        try: 
            user = Student.query.options(noload('*')).filter_by(id=id).first()
            if user :
                user.password = password
                user.first_name = first_name
                user.last_name = last_name
                user.phone_primary = phone_primary
                user.phone_secondary = phone_secondary
                user.date_birth = date_birth
                user.address = address
                user.classroom = classroom
                user.school_qualification_id = school_qualification_id
                user.country_city_id = country_city_id
                user.country_id = country_id
                dbSession.commit()
            else:
                return notFound
       
            return Api.json_response(HTTPStatus.OK,{'id':user.id}) 
        except Exception as inst :
            return Api.json_exception(inst) 


    @route("/delete-user/<school_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def delete_user(self,school_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        student = json.loads(request.data)
        id = student["id"]
        email = student["email"]

        if not school_id or not id or not student :
            return notFound

        try:
            user = Student.query.options(noload('*')).filter_by(id=id,email=email,school_id=school_id).first()
            if user :
                try:
                    dbSession.delete(user)
                    dbSession.commit()
                except SQLAlchemyError as e:
                    return Api.json_response(HTTPStatus.BAD_REQUEST,ARS.deletion_student_canceled)
            else:
                return notFound
       
            return Api.json_response(HTTPStatus.OK,{'id':user.id})             
        except Exception as inst :
            return Api.json_exception(inst) 

