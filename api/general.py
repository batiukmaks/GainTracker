from flask import Blueprint, render_template, redirect

general = Blueprint("general", __name__, url_prefix="/")

@general.route("", methods=["GET"])
def home():
    return redirect('about')

@general.route("about", methods=["GET"])
def about():
    return render_template('general/about.html')