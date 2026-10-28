from flask import g, current_app as app
from flask_login import current_user
from .menu_admin import app_menu_admin
from .menu_school import app_menu_school
from .menu_instructor import app_menu_instructor
from .menu_student import app_menu_student
from collections import OrderedDict
from ...commun.database.db_enums import ROLES
from ...utilities.flask.flask_menu import FlaskMenu


def menu_builder():
    # create object
    app_menu = {"menu_id": "login", "endpoint": "AccountView:login"}

    try:
        role = current_user.role if current_user.is_authenticated else ROLES.Any.value
        if role == ROLES.Student.value:
            app_menu = app_menu_student

        elif role == ROLES.Instructor.value:
            app_menu = app_menu_instructor

        elif role == ROLES.School.value:
            app_menu = app_menu_school

        elif role == ROLES.Admin.value:
            app_menu = app_menu_admin
    except:
        pass

    return app_menu


# load jinja utility extension
# app.jinja_env.add_extension('jinja2.ext.do')


# make this object globally available in template context
@app.context_processor
def utility_app_menu():
    return dict(app_menu=menu_builder)
