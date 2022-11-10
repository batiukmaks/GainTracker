from flask import Blueprint, request, abort, jsonify, redirect, url_for
from marshmallow import ValidationError
from schemas import *
from models import *
from db import get_db
workout = Blueprint('workouts', __name__, url_prefix='/workouts')
db = get_db()

@workout.route('/', methods=['GET'])
def get_workouts():
    author_id = request.args.get("author_id")  # temporary

    workouts = db.query(Workout).filter(Workout.author_id == author_id)
    workouts_info = []
    for workout in workouts:
        workouts_info.append(get_workout_info_schema(workout.id))
    return jsonify(workouts_info)


@workout.route('/add', methods=['GET', 'POST'])
def add_workout():
    author_id = request.args.get("author_id")  # temporary

    if request.method == 'GET':  # return list of exercises
        exercises = db.query(Exercise).all()
        exercises_info = []
        for exercise in exercises:
            exercises_info.append(get_exercise_info_schema(exercise.id))
        return jsonify(exercises_info)
    elif request.method == 'POST':
        try:
            new_workout = WorkoutCreationSchema().load(request.json)
            new_workout["author_id"] = author_id
        except ValidationError:
            return jsonify({'Error': 'Invalid input for WorkoutCreation'}), 400

        workout = Workout(
            name=new_workout["name"], author_id=new_workout["author_id"])
        
        db.add(workout)
        db.flush()
        db.refresh(workout)

        workout_exercises = []
        for exercise in new_workout["exercises"]:
            workout_exercises.append(WorkoutExercise(
                workout_id=workout.id, exercise_id=exercise
            ))

        db.add_all(workout_exercises)
        db.commit()
        return get_workout_info_schema(workout.id)


@workout.route('/<id>', methods=['GET', 'DELETE'])
def get_workout_by_id(id):
    workout = db.query(Workout).filter(Workout.id == id).first()
    if not workout:
        return jsonify({'Error': 'There is no such workout'}), 404

    if request.method == 'GET':
        return jsonify(get_workout_info_schema(id))
    elif request.method == 'DELETE':
        db.query(Workout).filter(Workout.id == id).delete()
        db.commit()
        if db.query(Workout).filter(Workout.id == id).first():
            return jsonify({'Error': 'Cannot delete the workout'})
        return jsonify({'Message': 'Workout successfully deleted'})


def get_workout_info_schema(id):
    workout = db.query(Workout).filter(Workout.id == id).first()
    workout_info = WorkoutInfoSchema().dump(workout)
    workout_info['exercises'] = []
    workout_exercises = db.query(WorkoutExercise).filter(
        WorkoutExercise.workout_id == id).all()

    for exercise in workout_exercises:
        workout_info["exercises"].append(get_exercise_info_schema(exercise.exercise_id))
    return workout_info

def get_exercise_info_schema(id):
    exercise = db.query(Exercise).filter(Exercise.id == id).first()
    exercise_info = ExerciseInfoSchema().dump(exercise)
    exercise_info['muscles'] = []
    muscles_worked = db.query(MuscleWorked).filter(MuscleWorked.exercise_id==id)
    for muscle_worked in muscles_worked:
        muscle = db.query(Muscle).filter(Muscle.id==muscle_worked.muscle_id).first()
        exercise_info['muscles'].append(MuscleInfoSchema().dump(muscle))
        print (exercise_info['muscles'])
    return exercise_info
