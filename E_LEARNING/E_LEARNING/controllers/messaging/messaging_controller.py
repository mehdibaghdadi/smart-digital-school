from ...imports import *


class MessagingView(Api):
    route_prefix = ""
    route_base = "/messaging/"

    @login_required
    @role_required(role=ROLES.Any.value)
    @route("", methods=Api.GET)
    def index(self):
        cl = MessagingManager()
        listeMBXResult = cl.getInboxByUser(current_user.email)
        message_get_inbox_user_messageid_url = url_for("MessagingManager:getInboxByUserMessageId_1")
        message_get_url = url_for("MessagingManager:getMessage_1")
        message_mark_read_url = url_for("MessagingManager:markReadMessageBox_1")
        message_delete_url = url_for("MessagingManager:delete_1", to_trash=0)
        message_delete_totrash_url = url_for("MessagingManager:delete_0", to_trash=1)
        message_save_url = url_for("MessagingManager:SaveAndUpdateMessageBox")

        if ROLES.Instructor.value == current_user.role:
            contact_list_url = url_for(
                "MessagingManager:getInstructorContactsListAll",
                id=current_user.id,
                school_id=current_user.school_id,
                allInfos=0,
            )

        if ROLES.Student.value == current_user.role:
            contact_list_url = url_for(
                "MessagingManager:getStudentContactsListAll",
                id=current_user.id,
                school_id=current_user.school_id,
                allInfos=0,
            )

        if ROLES.School.value == current_user.role:
            contact_list_url = url_for(
                "MessagingManager:getSchoolContactsListAll",
                id=current_user.id,
                allInfos=0,
            )

        return render_template(
            "/messaging/message-box-list.html",
            listeMessagesBox=listeMBXResult,
            user_id=current_user.id,
            user_email=current_user.email,
            role=current_user.role,
            message_get_url=message_get_url,
            message_get_inbox_user_messageid_url=message_get_inbox_user_messageid_url,
            message_mark_read_url=message_mark_read_url,
            message_delete_url=message_delete_url,
            message_delete_totrash_url=message_delete_totrash_url,
            message_save_url=message_save_url,
            contact_list_url=contact_list_url,
        )


class MessagingManager(Api):

    route_base = "/messaging-manager/"

    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    @route("/get-inbox-by-user/<email>", methods=Api.GET)
    def getInboxByUser(self, email):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = MessagesBoxInboxSP(email,None)
            if not qList:
                return notFound

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)
        
    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    @route("/get-inbox-by-user-messageid", defaults={"email": '', "message_id": 0}, methods=Api.GET)
    @route("/get-inbox-by-user-messageid/<email>/<message_id>", methods=Api.GET)
    def getInboxByUserMessageId(self, email,message_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = MessagesBoxInboxSP(email,message_id)
            if not qList:
                return notFound

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)
        



    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    @route("/get-count-read/<int:id_user>/<role>/<int:is_read>", methods=Api.GET)
    def getMessageCountRead(self, id_user, role, is_read):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = MessageBoxCountRead(id_user, role, is_read)
            if not qList:
                return notFound

            return Api.json_response(HTTPStatus.OK, qList[0])
        except Exception as inst:
            return Api.json_exception(inst)

    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    @route("/get", defaults={"id_user": 0, "email": "@"}, methods=Api.GET)
    @route("/get/<int:id_user>/<email>", methods=Api.GET)
    def getMessage(self, id_user, email):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = MessagesBoxSP(id_user, email)
            if not qList:
                return notFound

            return Api.json_response(HTTPStatus.OK, qList[0])
        except Exception as inst:
            return Api.json_exception(inst)

    @limiter.limit(limit.medium, error_message=limit.fast)
    @auth.login_required
    @route("/delete/<int:to_trash>/<int:id>", methods=Api.POST)
    @route("/delete-to-trash/<int:to_trash>/<int:id>", methods=Api.POST)
    @route("/delete/<int:to_trash>", defaults={"id": 0}, methods=Api.POST)
    @route("/delete-to-trash/<int:to_trash>", defaults={"id": 0}, methods=Api.POST)
    def delete(self, to_trash, id):
        try:
            # time.sleep(3)
            obj = MessagesBox.query.filter(MessagesBox.id == id).first()
            if obj is None:
                return Api.json_response(HTTPStatus.BAD_REQUEST, "Not found")

            if to_trash == 0:
                dbSession.query(MessagesBoxRecipient).filter_by(
                    message_box_id=obj.id
                ).delete(synchronize_session=False)
                dbSession.delete(obj)
            else:
                obj.to_trash = True

            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"id": id, "to_trash": to_trash})

        except Exception as inst:
            return Api.json_exception(inst)

    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    @route("/mark-read", defaults={"id": 0}, methods=Api.POST)
    @route("/mark-read/<int:id>", methods=Api.POST)
    def markReadMessageBox(self, id):
        try:

            obj = MessagesBoxRecipient.query.filter(
                MessagesBoxRecipient.id == id
            ).one_or_none()
            if obj is None:
                return Api.json_response(HTTPStatus.BAD_REQUEST, "Not found")

            obj.is_read = True
            dbSession.commit()

            return Api.json_response(HTTPStatus.OK, {"id": id, "is_read": obj.is_read})
        except Exception as inst:
            return Api.json_exception(inst)

    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    @route(
        "/instructor-contacts-list-all/<int:id>/<int:school_id>/<int:allInfos>",
        methods=Api.GET,
    )
    def getInstructorContactsListAll(self, id, school_id, allInfos):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = InstructorListStudent(id, allInfos)
            school = SchoolInfosCommun(school_id, allInfos)
            if not qList:
                qList = school
            else:
                qList.extend(school)

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    @route(
        "/student-contacts-list-all/<int:id>/<int:school_id>/<int:allInfos>",
        methods=Api.GET,
    )
    def getStudentContactsListAll(self, id, school_id, allInfos):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qList = StudentListInstructor(id, allInfos)
            school = SchoolInfosCommun(school_id, allInfos)
            if not qList:
                qList = school
            else:
                qList.extend(school)

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    @limiter.limit(limit.fast, error_message=limit.fast)
    @auth.login_required
    @route("/school-contacts-list-all/<int:id>/<int:allInfos>", methods=Api.GET)
    def getSchoolContactsListAll(self, id, allInfos):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            qListStudent = SchoolListStudent(id, allInfos)
            qList = SchoolListInstructor(id, allInfos)

            if qList and qListStudent:
                qList.extend(qListStudent)

            if not qList:
                return notFound

            return Api.json_response(HTTPStatus.OK, qList)
        except Exception as inst:
            return Api.json_exception(inst)

    # @limiter.limit(limit.fast, error_message=limit.fast)
    # @auth.login_required
    @route("/save-update-message-box", methods=Api.POST)
    def SaveAndUpdateMessageBox(self):
        try:
            # time.sleep(3)
            data = json.loads(request.data)
            messagebox = data["sender"]
            contacts = data["contacts"]

            id = int(messagebox["id"]) if representsInt(messagebox["id"]) else 0
            user_sender_id = int(messagebox["user_sender_id"]) if representsInt(messagebox["user_sender_id"]) else 0
            user_sender_role = messagebox["user_sender_role"]
            user_sender_email = messagebox["user_sender_email"]
            subject = messagebox["subject"]
            body = messagebox["body"]

            mb = MessagesBox()
            users = UserApp.query.filter(UserApp.email.in_(contacts)).all()

            if id > 0:
                mb = MessagesBox.query.filter(MessagesBox.id == id).first()
                if mb is None or mb.id <= 0:
                    mb = MessagesBox()

            mb.user_sender_id = user_sender_id
            mb.user_sender_role = user_sender_role
            mb.subject = subject
            mb.body = body
            mb.to_trash = False
            mb.date_update = datetime.today()

            if id <= 0:
                dbSession.add(mb)
                # new participant
                for x in users:
                    p = MessagesBoxRecipient()
                    p.user_recipient_id = x.id
                    p.user_recipient_role = x.role
                    p.is_read = False
                    p.message_box = mb
                    dbSession.add(p)
            elif mb.messages_box_recipients:
                mbr = mb.messages_box_recipients
                users_to_add = [
                    u
                    for u in users
                    if not any(
                        m.user_recipient_id == u.id and m.user_recipient_role == u.role
                        for m in mbr
                    )
                ]
                users_recipient_to_delete = [
                    m
                    for m in mbr
                    if not any(
                        m.user_recipient_id == u.id and m.user_recipient_role == u.role
                        for u in users
                    )
                ]
                if users_recipient_to_delete:
                    dbSession.query(MessagesBoxRecipient).filter(
                        MessagesBoxRecipient.id.in_(
                            [obj.id for obj in users_recipient_to_delete]
                        )
                    ).delete(synchronize_session=False)
                # add participant
                for x in users_to_add:
                    p = MessagesBoxRecipient()
                    p.user_recipient_id = x.id
                    p.user_recipient_role = x.role
                    p.is_read = False
                    p.message_box = mb
                    dbSession.add(p)

            dbSession.commit()

            sended = self.getMessage(mb.id, user_sender_email)

            return sended
        except Exception as inst:           
            return Api.json_exception(inst)