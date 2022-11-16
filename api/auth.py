from flask import Blueprint, request, jsonify
from flask_jwt_extended import (
    create_access_token, jwt_required, current_user,
    set_access_cookies, unset_jwt_cookies
)
from werkzeug.security import generate_password_hash, check_password_hash
from marshmallow import ValidationError
from schemas import *
from models import *
from .authentication import *
from db import get_db

auth = Blueprint('auth', __name__, url_prefix='/user')
db = get_db()

@auth.route('/signup', methods=['POST'])
def signup():
    try:
        new_user = UserCreationSchema().load(request.json)
        new_user.password = generate_password_hash(new_user.password)
    except ValidationError:
        return jsonify({'Error': 'Invalid input'}), 400

    if db.query(User).filter(User.email == new_user.email).first():
        return jsonify({'Error': 'The user with such email already exists.'}), 400
    if db.query(User).filter(User.username == new_user.username).first():
        return jsonify({'Error': 'The user with such username already exists.'}), 400

    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return jsonify(UserInfoSchema().dump(new_user))


@auth.route("/login", methods=["GET"])
def login():
    username = request.args.get("username")
    password = request.args.get("password")
    if username is None:
        return {'Error': 'Invalid input'}, 400
    user = db.query(User).filter(User.username==username).first() or db.query(User).filter(User.email==username).first()
    if user is None:
        return jsonify({"msg": "Bad username"}), 404
    if not check_password_hash(user.password, password):
        return jsonify({"msg": "Bad password"}), 401
    
    access_token = create_access_token(identity=user)
    user_schema = UserFullInfoSchema().dump(user)
    user_schema['token'] = access_token
    response = jsonify(user_schema)
    set_access_cookies(response, access_token)
    return response


@auth.route("/logout", methods=["GET"])
@jwt_required()
def logout():
    response = jsonify({"msg": "logout successful"})
    unset_jwt_cookies(response)
    return response

