from flask import Blueprint, request, jsonify, render_template, redirect
from flask_jwt_extended import (
    create_access_token,
    jwt_required,
    current_user,
    set_access_cookies,
    unset_jwt_cookies,
    get_jwt_identity,
)
from werkzeug.security import generate_password_hash, check_password_hash
from marshmallow import ValidationError
from schemas import *
from models import *
from .authentication import *
from db import get_db


auth = Blueprint("auth", __name__, url_prefix="/user")
db = get_db()


@auth.route("/signup", methods=["GET", "POST"])
def signup():
    if request.method == "GET":
        return render_template("auth/signup.html")

    new_user_schema = {
        "username": request.form.get("username"),
        "email": request.form.get("email"),
        "password": generate_password_hash(request.form.get("password")),
        "first_name": request.form.get("first_name"),
        "last_name": request.form.get("last_name"),
        "sex": request.form.get("sex"),
        "birthday": request.form.get("birthday"),
    }
    if new_user_schema["sex"] == "none":
        new_user_schema["sex"] = "other"

    # temporary solution
    if new_user_schema["email"] is None:
        new_user_schema["email"] = f'{new_user_schema["username"]}@email.com'

    try:
        new_user = UserCreationSchema().load(new_user_schema)
    except ValidationError:
        return jsonify({"Error": "Invalid input"}), 400

    if db.query(User).filter(User.username == new_user.username).first():
        return render_template(
            "auth/signup.html",
            error={"message": "The user with such username already exists."},
        )
    if db.query(User).filter(User.email == new_user.email).first():
        return render_template(
            "auth/signup.html",
            error={"message": "The user with such email already exists."},
        )

    db.add(new_user)
    db.commit()
    return redirect("login")


@auth.route("/login", methods=["GET", "POST"])
def login():
    db.rollback()
    if request.method == "GET":
        return render_template("auth/login.html")

    username = request.form.get("username_or_email")
    password = request.form.get("password")
    user = (
        db.query(User).filter(User.username == username).first()
        or db.query(User).filter(User.email == username).first()
    )
    if user is None:
        return render_template(
            "auth/login.html",
            error={
                "message": "Cannot find the user. Check your login or create an account."
            },
        )
    if not check_password_hash(user.password, password):
        return render_template(
            "auth/login.html", error={"message": "Invalid password. Try again."}
        )

    response = redirect("/user/progress/measurements")
    access_token = create_access_token(identity=user)
    set_access_cookies(response, access_token)
    return response


@auth.route("/logout", methods=["GET"])
@jwt_required()
def logout():
    response = redirect("login")
    unset_jwt_cookies(response)
    return response
