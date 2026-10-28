# coding: utf-8
from . import db, BaseModel

from .package import Package
from .school import School




class Payment(db.Model):
    __tablename__ = 'payment'

    id = db.Column(db.Integer, primary_key=True)
    school_id = db.Column(db.ForeignKey('school.id', ondelete='CASCADE'), nullable=False, index=True)
    package_id = db.Column(db.ForeignKey('package.id', ondelete='CASCADE'), nullable=False, index=True)
    amount_paid_global = db.Column(db.Numeric(10, 2), nullable=False)
    payment_date = db.Column(db.DateTime, nullable=False, server_default=db.FetchedValue())
    payment_status = db.Column(db.String(20), nullable=False)
    transaction_reference = db.Column(db.String(255))

    package = db.relationship('Package', primaryjoin='Payment.package_id == Package.id', backref='payments')
    school = db.relationship('School', primaryjoin='Payment.school_id == School.id', backref='payments')
