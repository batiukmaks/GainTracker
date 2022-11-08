from flask import Blueprint, request, abort, jsonify, redirect, url_for
from marshmallow import ValidationError
from schemas import *
from models import *
from db import get_session
workout = Blueprint('workouts', __name__, url_prefix='/workouts')


@workout.route('/', methods=['GET'])
def get_workouts():
    session = get_session()
    author_id = request.args.get("author_id")  # temporary

    workouts = session.query(Workout).filter(Workout.author_id == author_id)
    workouts_info = []
    for workout in workouts:
        workouts_info.append(get_workout_info_schema(workout.id, session))
    return jsonify(workouts_info)


@workout.route('/add', methods=['GET', 'POST'])
def add_workout():
    session = get_session()
    author_id = request.args.get("author_id")  # temporary

    if request.method == 'GET':  # return list of exercises
        exercises = session.query(Exercise).all()
        exercises_info = []
        for exercise in exercises:
            exercises_info.append(get_exercise_info_schema(exercise.id, session))
        return jsonify(exercises_info)
    elif request.method == 'POST':
        try:
            new_workout = WorkoutCreationSchema().load(request.json)
            new_workout["author_id"] = author_id
        except ValidationError:
            return jsonify({'Error': 'Invalid input for WorkoutCreation'}), 400

        workout = Workout(
            name=new_workout["name"], author_id=new_workout["author_id"])
        
        session.add(workout)
        session.flush()
        session.refresh(workout)

        workout_exercises = []
        for exercise in new_workout["exercises"]:
            workout_exercises.append(WorkoutExercise(
                workout_id=workout.id, exercise_id=exercise
            ))

        session.add_all(workout_exercises)
        session.commit()
        return get_workout_info_schema(workout.id, session)


@workout.route('/<id>', methods=['GET', 'DELETE'])
def get_workout_by_id(id):
    session = get_session()
    workout = session.query(Workout).filter(Workout.id == id).first()
    if not workout:
        return jsonify({'Error': 'There is no such workout'}), 404

    if request.method == 'GET':
        return jsonify(get_workout_info_schema(id, session))
    elif request.method == 'DELETE':
        session.query(Workout).filter(Workout.id == id).delete()
        session.commit()
        if session.query(Workout).filter(Workout.id == id).first():
            return jsonify({'Error': 'Cannot delete the workout'})
        return jsonify({'Message': 'Workout successfully deleted'})


def get_workout_info_schema(id, session):
    workout = session.query(Workout).filter(Workout.id == id).first()
    workout_info = WorkoutInfoSchema().dump(workout)
    workout_info['exercises'] = []
    workout_exercises = session.query(WorkoutExercise).filter(
        WorkoutExercise.workout_id == id).all()

    for exercise in workout_exercises:
        workout_info["exercises"].append(get_exercise_info_schema(exercise.exercise_id, session))
    return workout_info

def get_exercise_info_schema(id, session):
    exercise = session.query(Exercise).filter(Exercise.id == id).first()
    exercise_info = ExerciseInfoSchema().dump(exercise)
    exercise_info['muscles'] = []
    muscles_worked = session.query(MuscleWorked).filter(MuscleWorked.exercise_id==id)
    for muscle_worked in muscles_worked:
        muscle = session.query(Muscle).filter(Muscle.id==muscle_worked.muscle_id).first()
        exercise_info['muscles'].append(MuscleInfoSchema().dump(muscle))
        print (exercise_info['muscles'])
    return exercise_info
