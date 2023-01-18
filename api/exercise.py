from flask import Blueprint, request, redirect, render_template
from flask_jwt_extended import jwt_required, current_user
from schemas import *
from models import *
from db import get_db
from .workout import get_exercise_info_schema

exercise = Blueprint("exercises", __name__, url_prefix="/exercises")
db = get_db()


@exercise.route("/<id>", methods=["GET", "POST"])
@jwt_required()
def get_exercise(id):
    exercise = db.query(Exercise).filter(Exercise.id == id).first()

    if request.method == "GET":
        schema = get_exercise_info_schema(exercise.id)
        schema["muscles"] = [muscle["id"] for muscle in schema["muscles"]]
        filters = {
            "muscles": db.query(Muscle).all(),
            "types": [
                et[0]
                for et in db.query(ExerciseType.exercise_type).group_by(
                    ExerciseType.exercise_type
                )
            ],
        }
        return render_template(
            "exercises/exercise_info_edit.html", schema=schema, filters=filters
        )
    elif request.method == "POST" and request.form.get("_method") == "PUT":
        exercise.name = request.form.get("name").lower()
        exercise.equipment = request.form.get("equipment")
        exercise.description = request.form.get("description")

        db.query(MuscleWorked).filter(MuscleWorked.exercise_id == exercise.id).delete()
        db.query(ExerciseType).filter(ExerciseType.exercise_id == exercise.id).delete()
        add_muscles(exercise.id, list(map(int, request.form.getlist("muscles"))))
        add_types(exercise.id, request.form.getlist("types"))
        db.commit()
        return redirect("/workouts/add")
    elif request.method == "POST" and request.form.get("_method") == "DELETE":
        db.delete(exercise)
        db.commit()
        return redirect("/workouts/add")


@exercise.route("/add", methods=["GET", "POST"])
@jwt_required()
def add_exercise():
    if request.method == "GET":
        schema = {
            "muscles": db.query(Muscle).all(),
            "types": [
                et[0]
                for et in db.query(ExerciseType.exercise_type).group_by(
                    ExerciseType.exercise_type
                )
            ],
        }
        return render_template("exercises/exercise_create.html", schema=schema)

    new_exercise = Exercise(
        name=request.form.get("name").lower(),
        equipment=request.form.get("equipment"),
        description=request.form.get("description"),
        author_id=current_user.id,
    )
    db.add(new_exercise)
    db.flush()
    db.refresh(new_exercise)

    add_muscles(new_exercise.id, list(map(int, request.form.getlist("muscles"))))
    add_types(new_exercise.id, request.form.getlist("types"))

    db.commit()

    return redirect(f"{new_exercise.id}")


def add_muscles(exercise_id, muscle_ids):
    muscles_worked = [
        MuscleWorked(exercise_id=exercise_id, muscle_id=muscle) for muscle in muscle_ids
    ]
    db.add_all(muscles_worked)


def add_types(exercise_id, types):
    types = [
        ExerciseType(exercise_id=exercise_id, exercise_type=type) for type in types
    ]
    db.add_all(types)
