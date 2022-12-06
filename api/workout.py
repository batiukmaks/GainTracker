from flask import Blueprint, request, abort, jsonify, redirect, url_for, render_template
from flask_jwt_extended import jwt_required, current_user
from marshmallow import ValidationError
from schemas import *
from models import *
from db import get_db

workout = Blueprint("workouts", __name__, url_prefix="/workouts")
db = get_db()


@workout.route("/", methods=["GET"])
@jwt_required()
def get_workouts():
    workouts = db.query(Workout).filter(Workout.author_id == current_user.id)
    workouts_info = [get_workout_info_schema(workout.id) for workout in workouts]
    return render_template("workouts/workouts_list.html", workouts=workouts_info)


@workout.route("/add", methods=["GET", "POST"])
@jwt_required()
def add_workout():
    if request.method == "GET":
        exercises = db.query(Exercise).all()
        exercises_info = [
            get_exercise_info_schema(exercise.id) for exercise in exercises
        ]
        return render_template("workouts/workout_create.html", exercises=exercises_info)
    elif request.method == "POST":
        new_workout = {
            "name": request.form.get("name"),
            "exercises": request.form.getlist("exercises"),
            "author_id": current_user.id,
        }

        workout = Workout(name=new_workout["name"], author_id=new_workout["author_id"])
        db.add(workout)
        db.flush()
        db.refresh(workout)

        workout_exercises = [
            WorkoutExercise(workout_id=workout.id, exercise_id=exercise)
            for exercise in new_workout["exercises"]
        ]

        db.add_all(workout_exercises)
        db.commit()
        return redirect(f"{workout.id}")


@workout.route("/<id>", methods=["GET", "POST"])
@jwt_required()
def get_workout_by_id(id):
    workout = db.query(Workout).filter(Workout.id == id).first()
    if not workout:
        return jsonify({"Error": "There is no such workout"}), 404
    if not workout.author_id == current_user.id:
        return jsonify({"Error": "You have no permission on this workout"}), 401

    if request.method == "GET":
        return render_template(
            "workouts/workout_info.html", workout=get_workout_info_schema(id)
        )
    elif request.method == "POST" and request.form.get("_method") == "DELETE":
        db.query(Workout).filter(Workout.id == id).delete()
        db.commit()
        return redirect("/workouts")


def get_workout_info_schema(id):
    workout = db.query(Workout).filter(Workout.id == id).first()
    workout_schema = WorkoutInfoSchema().dump(workout)
    workout_exercises = (
        db.query(WorkoutExercise).filter(WorkoutExercise.workout_id == id).all()
    )
    workout_schema["exercises"] = [
        get_exercise_info_schema(exercise.exercise_id) for exercise in workout_exercises
    ]
    return workout_schema


def get_exercise_info_schema(id):
    exercise = db.query(Exercise).filter(Exercise.id == id).first()
    exercise_schema = ExerciseInfoSchema().dump(exercise)
    exercise_schema["type"] = (
        db.query(ExerciseType).filter(ExerciseType.id == exercise.type_id).first().name
    )
    muscles_worked = db.query(MuscleWorked).filter(MuscleWorked.exercise_id == id)
    exercise_schema["muscles"] = []
    for muscle_worked in muscles_worked:
        muscle = db.query(Muscle).filter(Muscle.id == muscle_worked.muscle_id).first()
        exercise_schema["muscles"].append(MuscleInfoSchema().dump(muscle))
    return exercise_schema
