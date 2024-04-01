from flask import current_app, g
from .models import Negotiation, Offer

class NegotiationService:
    # logic for negotiations
    
    # place offer / create negotiation
    @classmethod
    def create_negotiation(cls, vehical_id, customer_id, offer_price):
        try:
            # check for existing negotiation
            if Negotiation.check_existing_negotiation(vehical_id, customer_id):
                raise Exception('Negotiation already exists for customer and vehical')
            # create negotiation
            negotiation = Negotiation.create_negotiation(vehical_id, customer_id)
            # create offer
            offer = Offer.create_offer(negotiation.negotiation_id, int(Offer.OfferType.OFFER), offer_price)
            return negotiation.negotiation_id
        except Exception as e:
            raise e
        
    # get negotiations for a customer
    @classmethod
    def get_negotiations(cls, customer_id):
        try:
            # get all negotiations for a customer
            negotiations = Negotiation.get_negotiations(customer_id)
            return negotiations
        except Exception as e:
            raise e
        
    # get all negotiations
    @classmethod
    def get_all_negotiations(cls):
        try:
            # get all negotiations
            negotiations = Negotiation.get_all_negotiations()
            return negotiations
        except Exception as e:
            raise e
        
    # get negotiation details
    @classmethod
    def get_negotiation_details(cls, negotiation_id):
        try:
            # get negotiation
            negotiation = Negotiation.get_negotiation(negotiation_id)
            offers = Offer.get_offers(negotiation_id)
            return negotiation, offers
        except Exception as e:
            raise e
        
    # counter offer / additional offer
    @classmethod
    def counter_offer(cls, negotiation_id, offer_price):
        try:
            # update current offer status
            Offer.update_current_offer_status(negotiation_id, int(Offer.OfferStatus.COUNTERED))
            # create offer
            offer = Offer.create_offer(negotiation_id, int(Offer.OfferType.COUNTER), offer_price)
            return offer.offer_id
        except Exception as e:
            raise e
        
    # additional offer
    @classmethod
    def additional_offer(cls, negotiation_id, offer_price):
        try:
            # update current offer status
            Offer.update_current_offer_status(negotiation_id, int(Offer.OfferStatus.COUNTERED))
            # create offer
            offer = Offer.create_offer(negotiation_id, int(Offer.OfferType.OFFER), offer_price)
            return offer.offer_id
        except Exception as e:
            raise e
        
    # accept offer
    @classmethod
    def accept_offer(cls, negotiation_id):
        try:
            # update negotiation status to 2 (accepted)
            Negotiation.update_negotiation_status(negotiation_id, Negotiation.NegotiationStatus.ACCEPTED)
            # update offer status to 2 (accepted)
            Offer.update_current_offer_status(negotiation_id, int(Offer.OfferStatus.ACCEPTED))
        except Exception as e:
            raise e
        
    # reject offer
    @classmethod
    def reject_offer(cls, negotiation_id):
        try:
            # update negotiation status to 3 (rejected)
            Negotiation.update_negotiation_status(negotiation_id, Negotiation.NegotiationStatus.REJECTED)
            # update offer status to 3 (rejected)
            Offer.update_current_offer_status(negotiation_id, int(Offer.OfferStatus.REJECTED))
        except Exception as e:
            raise e