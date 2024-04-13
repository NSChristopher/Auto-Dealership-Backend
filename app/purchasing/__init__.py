from flask import Blueprint

purchasing_bp = Blueprint('purchasing', __name__, template_folder='templates', static_folder='static')

from . import purchasing_subs_rts  # Import routes to ensure they're registered with the blueprint