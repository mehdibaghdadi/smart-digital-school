# from flask import current_app as app
from enum import Enum
from E_LEARNING.resources.jinja2_resources import Jinja2Resources


class ROLES(Enum):
    Admin = "Admin"
    School = "School"
    Student = "Student"
    Instructor = "Instructor"
    Any = "Any"

    def __json__(self):
        return self.value


class STATUS_LEARNING_PROGRESS(Enum):
    Begin = "B"
    Completion = "C"

class PACKAGE(Enum):
    Demo = (1, "DEMO", "fa-stopwatch", "icon-gradient")
    Start = (2, "START", "fa-rocket", "icon-gradient-start")
    Basic = (3, "PRO", "fa-cubes", "icon-gradient-basic")
    Silver = (4, "BUSINESS", "fa-coins", "icon-gradient-silver")
    Gold = (5, "ENTERPRISE", "fa-trophy", "icon-gradient-gold")

    def __init__(self, id, label, icon,color):
        self.id = id
        self.label = label
        self.icon = icon
        self.color = color

    @classmethod
    def get_package_by_id(cls, id_value):
        # Iterate through each member of the PACKAGE enum
        for package in cls:
            # Check if the 'id' matches the given id_value
            if package.id == id_value:
                return package
        # If no matching id is found, return None (or raise an exception if needed)
        return None


class PAYMENT_METHOD(Enum):
    credit_card = ( "credit_card", Jinja2Resources.credit_card,"fa fa-credit-card")
    paypal = ( "paypal", "Paypal","fab fa-cc-paypal")
    bank_transfer = ( "bank_transfer", Jinja2Resources.bank_transfer,"fa fa-money-bill-trend-up")
    contact_sales = ( "contact_sales", Jinja2Resources.contact_sales,"fa-address-card")
    def __init__(self, id, label,css):
        self.id = id
        self.label = label
        self.css = css

    @classmethod
    def get_method_by_id(cls, id_value):
        for p in cls:
            if p.id == id_value:
                return p
        return None


class PAYMENT_STATUS(Enum):
    finished = ( "1", Jinja2Resources.finished,'finished-color')
    pending = ( "2", Jinja2Resources.pending,'pending-color')
    failed = ( "3", Jinja2Resources.failed,'failed-color')
    canceled = ( "4", Jinja2Resources.canceled1,'canceled-color')
    to_validate = ( "5", Jinja2Resources.waiting_validation,'pending-color')
    def __init__(self, id, label,css):
        self.id = id
        self.label = label
        self.css = css

    @classmethod
    def get_status_by_id(cls, id_value):
        for p in cls:
            if p.id == id_value:
                return p
        return None


