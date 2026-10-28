from ...imports import *


# ---------------Api
class SchoolTypeManager(Api):
    route_base = "/school-type-manager/"

    @route("/<id>", methods=Api.GET)
    def get(self,id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            language = g.current_language if g.current_language else "en"
            label = f"label_{language}"
            column_to_select = getattr(SchoolType, label)

            # Query one record, but defer loading the other columns
            t = (
                SchoolType.query.options(noload("*"))
                .filter_by(id=id)
                .with_entities(SchoolType.id, column_to_select)
                .first()
            )
            if not t:
                return notFound   

            # Convert the query result to a list of dictionaries
            ty ={"id": t.id, "label": getattr(t, label)}

            return ty
        except Exception as inst:
            return Api.json_exception(inst)
        

    @route("/list", methods=Api.GET)
    def getList(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)
        try:
            language = g.current_language if g.current_language else "en"
            label = f"label_{language}"
            column_to_select = getattr(SchoolType, label)

            # Query all records, but defer loading the other columns
            types = (
                SchoolType.query.options(noload("*"))
                .with_entities(SchoolType.id, column_to_select)
                .all()
            )

            # Convert the query result to a list of dictionaries
            type_dict = [
                {"id": s.id, "label": getattr(s, label)}
                for s in types
            ]

            return type_dict
        except Exception as inst:
            return Api.json_exception(inst)

