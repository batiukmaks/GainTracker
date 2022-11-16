from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, current_user
from marshmallow import ValidationError
from sqlalchemy import desc
from schemas import *
from models import *
from .workout import get_workout_info_schema
from db import get_db
import datetime

session = Blueprint('sessions', __name__, url_prefix='/sessions')
db = get_db()

@session.route('/', methods=['GET'])
@jwt_required()
def get_sessions():
    sessions = db.query(Session).filter(Session.user_id == current_user.id).order_by(desc(Session.date))
    sessions_info = []
    for session in sessions:
        workout = db.query(Workout).filter(
            Workout.id == session.workout_id).first()
        sessions_info.append(SessionInfoForListSchema().dump(session))
        sessions_info[-1]["workout_name"] = workout.name
    return jsonify(sessions_info)


@session.route('/<id>', methods=['GET'])
@jwt_required()
def get_session_by_id(id):
    session = db.query(Session).filter(Session.id == id).first()
    if not session:
        return jsonify({'Error': 'There is no such session.'}), 404
    if not session.user_id == current_user.id:
        return jsonify({'Error': 'You have no permission to view this session.'}), 401
        
    return jsonify(get_session_info_schema(id)), 200 


@session.route('/add', methods=['GET', 'POST'])
@jwt_required()
def create_session():
    if request.method == 'GET':
        workout = db.query(Workout).filter(Workout.id==request.args.get("workout_id")).first()
        if not workout:
            return jsonify({'Error': 'There is no such workout.'}), 404
        if not workout.author_id == current_user.id:
            return jsonify({'Error': 'You have no permission to user this workout.'}), 401
        return jsonify(get_workout_info_schema(workout.id))
    elif request.method == 'POST':
        try:
            new_session_schema = SessionCreationSchema().load(request.json)
        except ValidationError:
            return jsonify({'Error': 'Invalid input.'}), 400
        session = Session(
            date = datetime.datetime.now(datetime.timezone.utc),
            user_id=current_user.id,
            workout_id=new_session_schema["workout_id"]
        )
        db.add(session)
        db.flush()
        db.refresh(session)

        for record in new_session_schema["records"]:
            exercise_record = ExerciseRecord(
                date=session.date,
                session_id=session.id,
                exercise_id=record["exercise_id"]
            )
            db.add(exercise_record)
            db.flush()
            db.refresh(exercise_record)
            for set in record["sets"]:
                set.exercise_record_id = exercise_record.id
                db.add(set)
        db.commit()
        return get_session_info_schema(session.id)


def get_session_info_schema(id):
    session = db.query(Session).filter(Session.id == id).first()
    workout = db.query(Workout).filter(
        Workout.id == session.workout_id).first()
    exercise_records = db.query(ExerciseRecord).filter(
        ExerciseRecord.session_id == id)

    session_schema = SessionInfoForListSchema().dump(session)
    session_schema["workout_name"] = workout.name
    session_schema["records"] = []
    for exercise_record in exercise_records:
        session_schema['records'].append(
            get_record_info_schema(exercise_record.id))

    return session_schema


def get_record_info_schema(id):
    exercise_record = db.query(ExerciseRecord).filter(
        ExerciseRecord.id == id).first()
    exercise = db.query(Exercise).filter(
        Exercise.id == exercise_record.exercise_id).first()
    exercise_sets = db.query(ExerciseSet).filter(
        ExerciseSet.exercise_record_id == exercise_record.id).order_by(ExerciseSet.sequence_number)

    exercise_record_schema = {
        'id': exercise_record.id,
        'exercise_id': exercise_record.exercise_id,
        'exercise_name': exercise.name,
        'sets': []
    }
    for exercise_set in exercise_sets:
        exercise_record_schema['sets'].append(
            ExerciseSetSchema().dump(exercise_set))

    return exercise_record_schema
