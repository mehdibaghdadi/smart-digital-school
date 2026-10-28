from ...imports import  *
from flask import Flask, url_for ,render_template, current_app as app
from flask_login import login_required
import re

def get_api_map():
        """Search API from rules, if match the pattern then we said it is API."""
        for rule in app.url_map.iter_rules():
            if re.search(r'/api/.+', str(rule)):
                yield str(rule), rule.endpoint


def _get_api_name(func):
        """e.g. Convert 'do_work' to 'Do Work'"""
        words = func.__name__.split('_')
        words = [w.capitalize() for w in words]
        return ' '.join(words)

def _get_api_doc(func):
    if func.__doc__:
        return func.__doc__
    else:
        return 'No doc found for this API!'

   
class ApiDocsView(Api):
    route_prefix = ""    
    route_base = "/"     

    @login_required
    @role_required(role=ROLES.School.value)
    @route("/map")
    def site_map(self):
        """List all API to this page, api_map contains each api url + endpoint."""
        api_map = sorted(list(get_api_map()))
        index_url = url_for('IndexView:index', _external=True)
        api_map = [(index_url + x[0][1:], x[1]) for x in api_map]
        return render_template('/_base/w_api/api.html', api_map=api_map)

    @login_required
    @role_required(role=ROLES.School.value)    
    @route('/map/docs/<endpoint>', methods=['GET'])
    def docs(self,endpoint):
        """Document page for an endpoint."""
        api = {
            'endpoint': endpoint,
            'methods': [],
            'doc': '',
            'url': '',
            'name': ''
        }

        try:
            func = app.view_functions[endpoint]

            api['name'] = _get_api_name(func)
            api['doc'] = _get_api_doc(func)

            for rule in app.url_map.iter_rules():
                if rule.endpoint == endpoint:
                    api['methods'] = ','.join(rule.methods)
                    api['url'] = str(rule)
                    break

        except:
            api['doc'] = 'Invalid api endpoint: "{}"!'.format(endpoint)

        return render_template('/_base/w_api/api_docs.html', api=api)

   