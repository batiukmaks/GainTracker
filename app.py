from db import *
from models import *
from flask import Flask

import os

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)

    from db import db_init
    db_init()

    from api import auth, progress, workout, session
    app.register_blueprint(auth.auth)
    app.register_blueprint(progress.progress)
    app.register_blueprint(workout.workout)
    app.register_blueprint(session.session)

    return app
