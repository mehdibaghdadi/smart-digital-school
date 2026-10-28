from flask import session, current_app as app
from flask_login import UserMixin
from ...utilities.flask.flask_services import getImage
from ..database.db_enums import *
from datetime import datetime, date

class loginSession(UserMixin):
    def __init__(
        self,
        id,
        role,
        first_name,
        last_name,
        email,
        email_school,
        image,
        active_account,
        url_index,
        image_school,
        name_school,
        school_id,
        school_type_id,
        school_type,
        package_id,
        renewal_date
    ):
        self.id = id
        self.role = role
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.email_school = email_school
        self.image = image
        self.active_account = active_account
        self.url_index = url_index
        self.image_school = image_school
        self.name_school = name_school
        self.school_id = school_id
        self.school_type_id = school_type_id
        self.school_type = school_type
        self.package_id = package_id
        self.renewal_date = renewal_date

    # Serialization method
    def to_dict(self):
        return {
            'id': self.id,
            'role': self.role,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'email': self.email,
            'email_school': self.email_school,
            'image': (self.image) if self.image else None,  # Serialize image
            'active_account': self.active_account,
            'url_index': self.url_index,
            'image_school': (self.image_school) if self.image_school else None,  # Serialize school image
            'name_school': self.name_school,
            'school_id': self.school_id,
            'school_type_id': self.school_type_id,
            'school_type': self.school_type,
            'package_id': self.package_id,
            'renewal_date': self.renewal_date,
        }
    # Deserialization method
    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            role=data['role'],
            first_name=data['first_name'],
            last_name=data['last_name'],
            email=data['email'],
            email_school=data['email_school'],
            image= data['image'],
            active_account=data['active_account'],
            url_index=data['url_index'],
            image_school= data['image_school'],
            name_school=data['name_school'],
            school_id=data['school_id'],
            school_type_id=data['school_type_id'],
            school_type=data['school_type'],
            package_id=data['package_id'],
            renewal_date=data['renewal_date'],
        )

    @property
    def full_name(self):
        return self.first_name + (
            "" if self.last_name is None else " " + self.last_name
        )

    @property
    def picture(self):
        img = getImage(self.image)
        return img

    @property
    def picture_school(self):
        img = getImage(self.image_school)
        return img

    @property
    def icon(self):
        icon = "fas fa-user-lock"
        role = self.role
        if role == ROLES.Student.value:
            icon = "fa fa-ew-student"
        elif role == ROLES.Instructor.value:
            icon = "fa fa-ew-instructor"
        elif role == ROLES.School.value:
            icon = "fa fa-ew-school"
        elif role == ROLES.Admin.value:
            icon = "fas fa-user-shield"
        return icon

    @property
    def is_active(self):
        return self.active_account == True

    @property
    def unused_days(self):
        try:
            today = date.today()

            if  not self.renewal_date:
                return 0

            if isinstance(self.renewal_date, datetime):
                renewal_date = self.renewal_date.date()
            else:
                renewal_date = self.renewal_date

            remaining_days = (renewal_date - today).days

            return remaining_days if remaining_days > 0 else 0

        except Exception as e:
            print(f"Error session unused_days: {e}")
            return 0


    @staticmethod
    def set_role_session(role):
        session["role_account"] = role

    @staticmethod
    def get_role_session():
        if "role_account" in session:
            return session["role_account"]
        return None

    @staticmethod
    def set_remember_me(remember_me):
        session["remember_me"] = remember_me

    @staticmethod
    def get_remember_me():
        if "remember_me" in session:
            return session["remember_me"]
        return False

    @staticmethod
    def set_code_recovery_pass(revovery_pass):
        session["recovery_pass"] = revovery_pass

    @staticmethod
    def get_code_recovery_pass():
        if "recovery_pass" in session:
            return session["recovery_pass"]
        return None
    @staticmethod
    def delete_session():
        for k in list(session.keys()):
            if k == "role_account" or k=="user_data":
                session.pop(k, None)
        session.modified = True
                

    # user data session
    @staticmethod
    def set_user_data(data):
        session["user_data"] = data
        session.modified = True

    @staticmethod
    def get_user_data():
        return session.get('user_data', None)

    @staticmethod
    def reset_user_data():
        if "user_data" in session:
            session.pop("user_data", None)
            session.modified = True
