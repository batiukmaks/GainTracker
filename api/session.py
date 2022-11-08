from flask import Blueprint, request, jsonify
from marshmallow import ValidationError
from sqlalchemy import desc
from schemas import *
from models import *
from .workout import get_workout_info_schema
from db import get_session
session = Blueprint('sessions', __name__, url_prefix='/sessions')


@session.route('/', methods=['GET'])
def get_sessions():
    session = get_session()
    user_id = request.args.get("user_id")  # temporary

    sessions = session.query(Session).filter(Session.user_id == user_id).order_by(desc(Session.date))
    sessions_info = []
    for sess in sessions:
        workout = session.query(Workout).filter(
            Workout.id == sess.workout_id).first()
        sessions_info.append(SessionInfoForListSchema().dump(sess))
        sessions_info[-1]["workout_name"] = workout.name
    return jsonify(sessions_info)


@session.route('/<id>', methods=['GET'])
def get_session_by_id(id):
    session = get_session()
    sess = session.query(Session).filter(Session.id == id).first()
    if not sess:
        return jsonify({'Error': 'There is no such session.'})
    return jsonify(get_session_info_schema(id, session))


@session.route('/add', methods=['GET', 'POST'])
def create_session():
    session = get_session()

    if request.method == 'GET':
        workout_id = request.args.get("workout_id")
        return jsonify(get_workout_info_schema(workout_id, session))
    elif request.method == 'POST':
        user_id = request.args.get("user_id")  # temporary
        try:
            new_session_schema = SessionCreationSchema().load(request.json)
        except ValidationError:
            return jsonify({'Error': 'Invalid input.'}), 400
        sess = Session(
            date=new_session_schema["date"],
            user_id=user_id,
            workout_id=new_session_schema["workout_id"]
        )
        session.add(sess)
        session.flush()
        session.refresh(sess)

        for record in new_session_schema["records"]:
            exercise_record = ExerciseRecord(
                date=new_session_schema["date"],
                session_id=sess.id,
                exercise_id=record["exercise_id"]
            )
            session.add(exercise_record)
            session.flush()
            session.refresh(exercise_record)
            for set in record["sets"]:
                set.exercise_record_id = exercise_record.id
                session.add(set)
        session.commit()
        return get_session_info_schema(sess.id, session)


def get_session_info_schema(id, session):
    sess = session.query(Session).filter(Session.id == id).first()
    workout = session.query(Workout).filter(
        Workout.id == sess.workout_id).first()
    exercise_records = session.query(ExerciseRecord).filter(
        ExerciseRecord.session_id == id)

    session_schema = SessionInfoForListSchema().dump(sess)
    session_schema["workout_name"] = workout.name
    session_schema["records"] = []
    for exercise_record in exercise_records:
        session_schema['records'].append(
            get_record_info_schema(exercise_record.id, session))

    return session_schema


def get_record_info_schema(id, session):
    exercise_record = session.query(ExerciseRecord).filter(
        ExerciseRecord.id == id).first()
    exercise = session.query(Exercise).filter(
        Exercise.id == exercise_record.exercise_id).first()
    exercise_sets = session.query(ExerciseSet).filter(
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
