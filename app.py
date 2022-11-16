from db import *
from models import *
from flask import Flask
from flask_cors import CORS

from datetime import timedelta
app = 'placeholder'

def create_app(test_config=None):
    global app
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    # Uncomment after testing
    """
    # If true this will only allow the cookies that contain your JWTs to be sent
    # over https. In production, this should always be set to True
    app.config["JWT_COOKIE_SECURE"] = False
    app.config["JWT_TOKEN_LOCATION"] = ["cookies", "headers"]
    """
    app.config["JWT_SECRET_KEY"] = "super-secret"  # Change this!
    app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(minutes=90)
    
    CORS(app)
    from db import db_init
    db_init()

    from api import auth, progress, workout, session
    app.register_blueprint(auth.auth)
    app.register_blueprint(progress.progress)
    app.register_blueprint(workout.workout)
    app.register_blueprint(session.session)

    return app
