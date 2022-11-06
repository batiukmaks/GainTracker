from flask import Blueprint
workout = Blueprint('workouts', __name__, url_prefix='/workouts')

@workout.route('/workouts')
def hello():
    return 'Hello, workouts!'