from ...imports import  *
#---------------view
class SubjectInstructorView(Api):
    route_prefix = ""    
    route_base = "/instructor/subject/" 

    @login_required
    @role_required(role=ROLES.Instructor.value)
    @route("",methods=Api.GET)
    def index(self):  
        from .profile_controller import ProfileInstructorManager
        instructor_id = current_user.id
        user = (ProfileInstructorManager()).getUser(current_user.id)
        school_id = user.school_id if user else 0

        s_api = SubjectInstructorManager()
        subject = s_api.getListSubjectPredefined(school_id)
        subject_db = s_api.getListSubject(instructor_id)
        url_save_update = url_for("SubjectInstructorManager:save_update",instructor_id=instructor_id)

        return render_template("/instructors/subject.html",
                              url_save_update = url_save_update,
                              subject = subject,
                              subject_db = subject_db)

#---------------Api
class SubjectInstructorManager(Api):  
    route_base = "/instructor-subject-manager/"

    @route("/list-subject-predefined/<school_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListSubjectPredefined(self,school_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)
        try: 
            qList = SchoolSubjectView.query.options(noload('*')).filter_by(school_id=school_id)\
                        .order_by(SchoolSubjectView.label_subject,SchoolSubjectView.education,SchoolSubjectView.code)\
                        .all()
            if not qList:
                return notFound   
          
            qList = [ i.serialize() for i in qList]

            return Api.json_response(HTTPStatus.OK,qList) 
        except Exception as inst :
            return Api.json_exception(inst) 

    @route("/list-subject/<instructor_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListSubject(self,instructor_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)
        try: 
            qList = InstructorSubject.query.options(noload('*')).filter_by(instructor_id=instructor_id).all()

            if not qList:
                return notFound   
          
            qList = [ i.serialize() for i in qList]

            return Api.json_response(HTTPStatus.OK,qList) 
        except Exception as inst :
            return Api.json_exception(inst) 

    @route("/save-update/<instructor_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def save_update(self,instructor_id):  
        #time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)

        subject = json.loads(request.data)
                
        if not instructor_id or not subject :
            return notFound

        return self.save_update_internal(instructor_id,subject)


    @auth.login_required
    def save_update_internal(self,instructor_id,subject):  
        #time.sleep(2)
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
                        
        if not instructor_id or not subject :
            return notFound

        instructor_id = int(instructor_id)

        selected = [ InstructorSubject(school_subject_id=x['id'],classrooms_teaching=','.join(x['classrooms_teaching']),subject_price=0,instructor_id=instructor_id)  
                                        for x in subject if x['selected'] == True]

        unselected = [ (x['id'],instructor_id) for x in subject if x['selected'] == False]

        try: 
            exist_insert =[]
            commit_exists=False
            sb_db = InstructorSubject.query.options(noload('*')).filter_by(instructor_id=instructor_id).all()

            if  sb_db :
                exist_insert = [ (sub.school_subject_id,sub.instructor_id) for sub in sb_db]
                for item in sb_db : #update records
                    sc = [x for x in selected if x.school_subject_id == item.school_subject_id ]
                    if sc :
                        item.classrooms_teaching=sc[0].classrooms_teaching
                        commit_exists=True

                #delete
                if(len(unselected) > 0):
                    exist_remove = [ (rm.id,rm.school_subject_id,rm.instructor_id) for rm in sb_db]
                    unselected = [ i[0] for i in exist_remove if (i[1],i[2]) in unselected ]

                    if(len(unselected) > 0):
                        dbSession.query(InstructorSubject)\
                            .filter(InstructorSubject.id.in_(unselected),
                            InstructorSubject.instructor_id == instructor_id).delete(synchronize_session=False)  
                        dbSession.commit()

            # new records
            new_selection = [ i for i in selected if (i.school_subject_id,i.instructor_id) not in exist_insert ] 


            #update
            if commit_exists :
                dbSession.add_all(sb_db) 

            #insert
            if(len(new_selection) > 0):
                dbSession.add_all(new_selection) 
                commit_exists=True # force commit
            
            #commit
            if commit_exists :
                dbSession.commit()
       

            return Api.json_response(HTTPStatus.OK,{'instructor_id':instructor_id}) 
        except Exception as inst :
            return Api.json_exception(inst) 