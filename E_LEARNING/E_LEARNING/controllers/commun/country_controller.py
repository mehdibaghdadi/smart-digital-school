from ...imports import *


# ---------------Api
class CountryManager(Api):
    route_base = "/country-manager/"

    @route("/countries", methods=Api.GET)
    def getListCountries(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        try:
            language = g.current_language if g.current_language else "en"
            column_to_select = getattr(Country, f"country_{language}")

            # Query all records, but defer loading the other columns
            countries = (
                Country.query.options(noload("*"))
                .with_entities(Country.id, column_to_select)
                .all()
            )

            # Convert the query result to a list of dictionaries
            countries_dict = [
                {"id": c.id, "country": getattr(c, f"country_{language}")}
                for c in countries
            ]

            return countries_dict
        except Exception as inst:
            return Api.json_exception(inst)

    @route("/country/<id>", methods=Api.GET)
    def getCountry(self, id):
        notFound = {"id": 0, "country": "..."}

        try:
            language = g.current_language if g.current_language else "en"
            column_to_select = getattr(Country, f"country_{language}")

            # Query all records, but defer loading the other columns
            ctr = (
                Country.query.options(noload("*"))
                .with_entities(Country.id, column_to_select)
                .filter_by(id=id)
                .first()
            )

            if not ctr:
                return notFound

            ctr_dict = {"id": ctr.id, "country": getattr(ctr, f"country_{language}")}

            return ctr_dict
        except Exception as inst:
            Api.json_exception(inst)
            return notFound

    @route("/region-cities", methods=Api.GET)
    def getListCities(self):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        try:
            list = CountryRegionCityView.query.all()
            if not list:
                return notFound

            cc_list = [c.serialize() for c in list]

            return cc_list
        except Exception as inst:
            return notFound

    @route("/region-city/<id>", methods=Api.GET)
    def getCity(self, id):
        notFound = Api.json_response(HTTPStatus.BAD_REQUEST, ARS.not_found)

        if not id:
            return notFound
        try:
            c = CountryRegionCityView.query.filter_by(id=id).first()
            if not c:
                return notFound

            return Api.json_response(HTTPStatus.OK, c.serialize())
        except Exception as inst:
            return notFound
