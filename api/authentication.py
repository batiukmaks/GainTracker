from flask import redirect
from flask_jwt_extended import (
    JWTManager,
    get_jwt,
    create_access_token,
    get_jwt_identity,
    set_access_cookies,
)
from models import *
from schemas import *
from app import app
from db import get_db

from datetime import datetime, timedelta, timezone

db = get_db()
jwt = JWTManager(app)


@jwt.user_identity_loader
def user_identity_lookup(user):
    return user.id


@jwt.user_lookup_loader
def user_lookup_callback(_jwt_header, jwt_data):
    identity = jwt_data["sub"]
    return db.query(User).filter(User.id == identity).first()


# @jwt.expired_token_loader
# def my_expired_token_callback(jwt_header, jwt_payload):
#     return redirect("/user/logout")


# @jwt.unauthorized_loader
# def my_expired_token_callback(jwt_header):
#     return redirect("/user/logout")


# Using an `after_request` callback, we refresh any token that is within 30
# minutes of expiring. Change the timedeltas to match the needs of your application.
@app.after_request
def refresh_expiring_jwts(response):
    try:
        exp_timestamp = get_jwt()["exp"]
        now = datetime.now(timezone.utc)
        target_timestamp = datetime.timestamp(now + timedelta(minutes=30))
        if target_timestamp > exp_timestamp:
            access_token = create_access_token(identity=get_jwt_identity())
            set_access_cookies(response, access_token)
        return response
    except (RuntimeError, KeyError):
        # Case where there is not a valid JWT. Just return the original response
        return response
