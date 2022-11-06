from flask import Blueprint
session = Blueprint('sessions', __name__, url_prefix='/sessions')

@session.route('/sessions')
def hello():
    return 'Hello, sessions!'