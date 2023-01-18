from flask import redirect, make_response
from flask_jwt_extended import JWTManager
from models import *
from schemas import *
from app import app
from db import get_db

db = get_db()
jwt = JWTManager(app)


@jwt.user_identity_loader
def user_identity_lookup(user):
    return user.id


@jwt.user_lookup_loader
def user_lookup_callback(_jwt_header, jwt_data):
    identity = jwt_data["sub"]
    return db.query(User).filter(User.id == identity).first()


@jwt.expired_token_loader
def my_expired_token_callback(jwt_header, jwt_payload):
    return redirect("/user/logout")


@jwt.unauthorized_loader
def my_expired_token_callback(jwt_header):
    return redirect("/user/logout")
