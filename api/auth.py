from flask import Blueprint
auth = Blueprint('auth', __name__, url_prefix='/user')

@auth.route('/auth')
def hello():
    return 'Hello, Auth!'