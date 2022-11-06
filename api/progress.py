from flask import Blueprint
progress = Blueprint('progress', __name__, url_prefix='/user/progress')

@progress.route('/progress')
def hello():
    return 'Hello, progress!'