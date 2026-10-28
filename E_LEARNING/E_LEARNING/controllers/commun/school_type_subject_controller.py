from ...imports import *


# ---------------Api
class SchoolTypeSubjectManager(Api):
    route_base = "/school-type-subject-manager/"

    @route("/<id>", methods=Api.GET)
    def get(self, id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            language = g.current_language if g.current_language else "en"
            label = f"label_{language}"
            label_cl = getattr(SchoolTypeSubjectView, label)             
            school_type = f"school_type_{language}"
            school_type_cl = getattr(SchoolTypeSubjectView, school_type)

            # Query one record, but defer loading the other columns
            t = (
                SchoolTypeSubjectView.query.options(noload("*"))
                .filter_by(id=id)
                .with_entities(
                    SchoolTypeSubjectView.id,
                    label_cl,
                    
                    SchoolTypeSubjectView.school_type_id,
                    school_type_cl,
                )
                .first()
            )
            if not t:
                return notFound

            # Convert the query result to a list of dictionaries
            ty = {
                "id": t.id,
                "school_type_id": t.school_type_id,
                "label": getattr(t, label),
                "school_type": getattr(t, school_type),
            }

            return ty
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/list", methods=Api.GET)
    def getList(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            language = g.current_language if g.current_language else "en"
            label = f"label_{language}"
            label_cl = getattr(SchoolTypeSubjectView, label)           
            school_type = f"school_type_{language}"
            school_type_cl = getattr(SchoolTypeSubjectView, school_type)            

            # Query all records, but defer loading the other columns
            types = (
                SchoolTypeSubjectView.query.options(noload("*"))
                .with_entities(
                    SchoolTypeSubjectView.id,
                    label_cl,
                    SchoolTypeSubjectView.school_type_id,
                    school_type_cl,
                )
                .all()
            )

            # Convert the query result to a list of dictionaries
            type_dict = [
                {
                    "id": s.id,
                    "school_type_id": s.school_type_id,
                    "label": getattr(s, label),
                    "school_type": getattr(s, school_type),
                }
                for s in types
            ]

            return type_dict
        except Exception as inst:
            return Api.json_exception(inst)

