# coding: utf-8
from sqlalchemy import Column, Date, DateTime, Float, ForeignKey, INTEGER, String, TIMESTAMP, text
from sqlalchemy.dialects.mysql import INTEGER, TINYINT
from sqlalchemy.orm import relationship
from app import db


class Purchase(db.Model):
    __tablename__ = 'purchase'

    purchase_id = Column(INTEGER, primary_key=True, unique=True)
    customer_id = Column(ForeignKey('customer.customer_id'), nullable=False, index=True)
    purchase_date = Column(DateTime)
    purchase_type = Column(INTEGER)
    payment_method = Column(INTEGER)
    sub_total = Column(INTEGER)
    tax = Column(Float)
    total = Column(INTEGER)

    customer = relationship('Customer')





class Log(db.Model):
    __tablename__ = 'Log'

    log_id = Column(INTEGER, primary_key=True, unique=True)
    type = Column(String(45))
    message = Column(String(512))
    date = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))
    customer_id = Column(ForeignKey('customer.customer_id'), index=True)
    user_id = Column(ForeignKey('user.user_id'), index=True)

    customer = relationship('Customer')
    employee = relationship('Employee')





class Finance(db.Model):
    __tablename__ = 'finance'

    finance_id = Column(INTEGER, primary_key=True, unique=True)
    purchase_id = Column(ForeignKey('purchase.purchase_id'), nullable=False, unique=True)
    apy = Column(Float)
    term = Column(INTEGER)
    paid = Column(INTEGER)
    finance_status = Column(INTEGER)

    purchase = relationship('Purchase')


class Payment(db.Model):
    __tablename__ = 'payment'

    payment_id = Column(INTEGER, primary_key=True, unique=True)
    purchase_id = Column(ForeignKey('purchase.purchase_id'), nullable=False, index=True)
    ccv = Column(String(45))
    expiration = Column(String(45))
    card_number = Column(String(45))
    routing_number = Column(String(45))
    account_number = Column(String(45))

    purchase = relationship('Purchase')


class PurchaseItem(db.Model):
    __tablename__ = 'purchase_item'

    purchase_item_id = Column(INTEGER, primary_key=True, unique=True)
    purchase_id = Column(ForeignKey('purchase.purchase_id'), nullable=False, unique=True)
    item_id = Column(INTEGER, nullable=False, unique=True)
    price = Column(INTEGER)

    purchase = relationship('Purchase')


class CounterOffer(Base):
    __tablename__ = 'counter_offer'

    counter_offer_id = Column(INTEGER, primary_key=True, unique=True)
    offer_id = Column(ForeignKey('offer.offer_id'), nullable=False, unique=True)
    counter_price = Column(Integer, nullable=False)
    counter_date = Column(DateTime, server_default=text("CURRENT_TIMESTAMP"))
    counter_status = Column(String(45))

    offer = relationship('Offer')
