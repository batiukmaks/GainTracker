from flask import Blueprint, request, abort, jsonify, redirect, url_for, render_template
from flask_jwt_extended import jwt_required, current_user
from marshmallow import ValidationError
from schemas import *
from models import *
from db import get_db

workout = Blueprint('workouts', __name__, url_prefix='/workouts')
db = get_db()

@workout.route('/', methods=['GET'])
@jwt_required()
def get_workouts():
    workouts = db.query(Workout).filter(Workout.author_id == current_user.id)
    workouts_info = []
    for workout in workouts:
        workouts_info.append(get_workout_info_schema(workout.id))
    return render_template('workouts/workouts_list.html', workouts=workouts_info)
    return jsonify(workouts_info)


@workout.route('/add', methods=['GET', 'POST'])
@jwt_required()
def add_workout():
    if request.method == 'GET':  # return list of exercises
        exercises = db.query(Exercise).all()
        exercises_info = []
        for exercise in exercises:
            exercises_info.append(get_exercise_info_schema(exercise.id))
        
        return render_template("workouts/workout_create.html", exercises=exercises_info)
        return jsonify(exercises_info)
    elif request.method == 'POST':
        # try:
        #     new_workout = WorkoutCreationSchema().load(request.json)
        #     new_workout["author_id"] = current_user.id
        # except ValidationError:
        #     return jsonify({'Error': 'Invalid input for WorkoutCreation'}), 400

        new_workout = {}
        new_workout['name'] = request.form.get('name')
        new_workout['exercises'] = request.form.getlist('exercises')
        new_workout['author_id'] = current_user.id
        print('\n\n\n\n\n\n', new_workout, '\n\n\n')

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
        return redirect(f'{workout.id}')
        return get_workout_info_schema(workout.id)


@workout.route('/<id>', methods=['GET', 'POST'])
@jwt_required()
def get_workout_by_id(id):
    workout = db.query(Workout).filter(Workout.id == id).first()
    if not workout:
        return jsonify({'Error': 'There is no such workout'}), 404
    if not workout.author_id == current_user.id:
        return jsonify({'Error': 'You have no permission on this workout'}), 401

    if request.method == 'GET':
        return render_template('workouts/workout_info.html', workout=get_workout_info_schema(id))
        return jsonify(get_workout_info_schema(id))
    elif request.method == 'POST' and request.form.get('_method') == 'DELETE':
        db.query(Workout).filter(Workout.id == id).delete()
        db.commit()
        if db.query(Workout).filter(Workout.id == id).first():
            return jsonify({'Error': 'Cannot delete the workout'})
        return redirect('/workouts')
        return jsonify({'Message': 'Workout successfully deleted'})





def get_workout_info_schema(id):
    workout = db.query(Workout).filter(Workout.id == id).first()
    workout_schema = WorkoutInfoSchema().dump(workout)
    workout_schema['exercises'] = []
    workout_exercises = db.query(WorkoutExercise).filter(
        WorkoutExercise.workout_id == id).all()

    for exercise in workout_exercises:
        workout_schema["exercises"].append(get_exercise_info_schema(exercise.exercise_id))
    return workout_schema

def get_exercise_info_schema(id):
    exercise = db.query(Exercise).filter(Exercise.id == id).first()
    exercise_schema = ExerciseInfoSchema().dump(exercise)
    exercise_schema['type'] = db.query(ExerciseType).filter(ExerciseType.id==exercise.type_id).first().name
    exercise_schema['muscles'] = []
    muscles_worked = db.query(MuscleWorked).filter(MuscleWorked.exercise_id==id)
    for muscle_worked in muscles_worked:
        muscle = db.query(Muscle).filter(Muscle.id==muscle_worked.muscle_id).first()
        exercise_schema['muscles'].append(MuscleInfoSchema().dump(muscle))
    return exercise_schema


@workout.route('/test', methods=['GET', 'POST'])
def test():
    if request.method == 'GET':
        return redirect(f'65')
        print('\n\n\nThis is GET request\n\n\n')
        return jsonify({'Message': 'This is GET request'}), 200
    elif request.method == 'POST':
        print('\n\n\nThis is POST request\n')
        print(request.form)
        print(request.form.get('name'))
        print(request.form.getlist('exercises'))
        return jsonify({'Message': 'This is POST request'}), 200