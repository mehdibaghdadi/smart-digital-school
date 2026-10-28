from ...imports import  *


#---------------Api
class ChapterContentInstructorManager(Api):  
    route_base = "/instructor-course-chapter-content-manager/"

    @classmethod
    def getCountContents(self, course_chapter_id) -> int:

        try:
            nbr = (
                CourseChapterContent.query.filter_by(course_chapter_id=course_chapter_id)
                .count()
            )
            return nbr
        except Exception as inst:
            Api.json_exception(inst)
            return -1
        
    @route("/list-content/<chapter_id>",methods=Api.GET)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def getListContent(self,chapter_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.not_found)   
        try: 
            ch = CourseChapterContent.query.options(noload('*')).filter_by(course_chapter_id=chapter_id)\
                                                         .order_by(CourseChapterContent.sequence)\
                                                         .all()
            if not ch:
                return notFound 
            ch = [ i.serialize() for i in ch]  
          
            return Api.json_response(HTTPStatus.OK,ch) 
        except Exception as inst :
            return Api.json_exception(inst)        
          
    @route("/save-update/<chapter_id>",methods=Api.POST)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def saveUpdate(self,chapter_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        try:
            content  = json.loads(request.data)
            id = content["id"]
            content_type_id = content["content_type_id"]
            content_url = content.get("content_url",None)
            content_cover_url = content.get("content_cover_url",None)
            content_text = content["content_text"]
            content_brief = content["content_brief"]
            sequence = content["sequence"]
            is_visible = content["is_visible"]
            is_important = content["is_important"]
            is_open_for_free = content["is_open_for_free"]
            time_required_in_sec = content.get("time_required_in_sec",0)
            file_size_in_bytes = content.get("file_size_in_bytes",0)

            if id is None or chapter_id is None :
                return notFound

            id = int(id)

            c = CourseChapterContent()
            if id > 0:
                c = CourseChapterContent.query.options(lazyload(CourseChapterContent.course_chapter)) \
                                                .filter_by(id=id,course_chapter_id=chapter_id).one()
                if c is None:
                    return notFound

            c.content_url = content_url
            c.content_cover_url = content_cover_url 
            c.content_text=content_text
            c.content_brief=content_brief
            c.is_visible = is_visible
            c.is_important = is_important
            c.is_open_for_free = is_open_for_free
            c.time_required_in_sec = time_required_in_sec
            c.file_size_in_bytes = file_size_in_bytes
            c.date_update = datetime.today()

            if id <= 0:
                c.course_chapter_id = chapter_id
                c.content_type_id = content_type_id
                c.sequence = sequence
                c.date_creation = datetime.today()
                dbSession.add(c) 
                #update chapter
                chapter = CourseChapter.query.options(noload('*')).filter_by(id=chapter_id).one()
                chapter.num_of_contents +=1
                chapter.date_chapter_update = datetime.now()

            #Save content
            dbSession.commit()
       
            return Api.json_response(HTTPStatus.OK,c.serialize())             
        except Exception as inst :
            return Api.json_exception(inst)   

    @route("/update-visibility/<chapter_id>",methods=Api.POST)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def updateVisibility(self,chapter_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        ct = json.loads(request.data)
        id = ct["id"]
        is_visible = ct["is_visible"]

        if not id or not chapter_id or is_visible is None :
            return notFound

        id = int(id)

        try:
            ct = CourseChapterContent.query.options(lazyload(CourseChapterContent.course_chapter)).filter_by(id=id,course_chapter_id=chapter_id).one()
            if ct :
                ct.is_visible = is_visible
                ct.date_update = datetime.today()
                dbSession.commit()
            else:
                return notFound
       
            return Api.json_response(HTTPStatus.OK,{'id':ct.id})             
        except Exception as inst :
            return Api.json_exception(inst)           

    @route("/update-importance/<chapter_id>",methods=Api.POST)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def updateImportance(self,chapter_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        ct = json.loads(request.data)
        id = ct["id"]
        is_important = ct["is_important"]

        if not id or not chapter_id or is_important is None :
            return notFound

        id = int(id)

        try:
            ct = CourseChapterContent.query.options(lazyload(CourseChapterContent.course_chapter)).filter_by(id=id,course_chapter_id=chapter_id).one()
            if ct :
                ct.is_important = is_important
                ct.date_update = datetime.today()
                dbSession.commit()
            else:
                return notFound
       
            return Api.json_response(HTTPStatus.OK,{'id':ct.id})             
        except Exception as inst :
            return Api.json_exception(inst)           
    
    
    @route("/save-update-sequence/<chapter_id>",methods=Api.POST)
    @limiter.limit(limit.fast,error_message=limit.fast)
    @auth.login_required
    def saveUpdateSequence(self,chapter_id):  
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.registration_canceled)
        contentList = json.loads(request.data)

        if contentList is None or len(contentList)==0 or chapter_id is None :
            return notFound

        try:
            from sqlalchemy.sql import case

            CourseChapterContent.query.filter(CourseChapterContent.course_chapter_id==chapter_id,CourseChapterContent.id.in_(contentList))\
                                  .update({
                                        CourseChapterContent.sequence: case(
                                            contentList,
                                            value=CourseChapterContent.id,)}, synchronize_session=False)
            dbSession.commit()
            return Api.json_response(HTTPStatus.OK,{'sequence':'ok'})             
        except Exception as inst :
            return Api.json_exception(inst)   
    
    
    @route("/delete-all/<chapter_id>",methods=Api.POST)
    @limiter.limit(limit.slow,error_message=limit.slow,deduct_when=lambda response: response.status_code != 200)
    @auth.login_required
    def delete_all(self,chapter_id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST,ARS.deletion_canceled)
        content = json.loads(request.data)
        id = content["id"]

        if not chapter_id or not id or not content :
            return notFound

        try:
            ct = CourseChapterContent.query.options(noload('*')).filter_by(id=id,course_chapter_id=chapter_id).one()
            if ct :
                try:

                    # Delete associated files
                    if ct.content_url and len(ct.content_url) >0:
                        delete_file_async(ct.content_url)

                    if ct.content_cover_url and  len(ct.content_cover_url) >0:
                        delete_file_async(ct.content_cover_url)


                     # Delete all related LearningProgress records first
                    LearningProgress.query.filter_by(course_chapter_content_id=ct.id).delete()
                    dbSession.delete(ct)
                    dbSession.flush()

                    #update chapter
                    chapter = CourseChapter.query.options(noload('*')).filter_by(id=chapter_id).one()
                    chapter.num_of_contents = chapter.num_of_contents -1 if chapter.num_of_contents >0 else 0
                    
                    #update sequences contents
                    contents = (
                        CourseChapterContent.query.filter(CourseChapterContent.course_chapter_id == chapter_id)
                        .order_by(CourseChapterContent.sequence)
                        .all()
                    )
                    if contents and len(contents) > 0:
                        for idx, ctn in enumerate(contents):
                            ctn.sequence = idx+1
                    #Save
                    dbSession.commit()
                except SQLAlchemyError as e:
                    Api.json_exception(e) 
                    return Api.json_response(HTTPStatus.BAD_REQUEST,ARS.deletion_content_canceled)
            else:
                return notFound
           
            return Api.json_response(HTTPStatus.OK,{'id':ct.id})             
        except Exception as inst :
            return Api.json_exception(inst) 



  