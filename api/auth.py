from flask import Blueprint, request, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from marshmallow import ValidationError
from schemas import *
from models import *
from db import get_db
auth = Blueprint('auth', __name__, url_prefix='/user')


@auth.route('/signup', methods=['POST'])
def signup():
    db = get_db()
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
    db.flush()
    db.refresh(new_user)
    db.commit()
    return jsonify(UserInfoSchema().dump(new_user))


@auth.route('/login', methods=['GET'])
def login():
    db = get_db()
    login = request.args.get("username_or_email")
    password = request.args.get("password")
    user = db.query(User).filter(User.email == login).first(
    ) or db.query(User).filter(User.username == login).first()
    if not user:
        return jsonify({'Error': 'User is not found'}), 404
    if not check_password_hash(user.password, password):
        return jsonify({'Error': 'Incorrect passwort'}), 401

    return jsonify(UserInfoSchema().dump(user))


@auth.route('/logout', methods=['GET'])
def logout():
    return jsonify({'Message': 'Logged out'})
