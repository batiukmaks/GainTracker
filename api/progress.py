from flask import Blueprint, request, jsonify, render_template, redirect
from flask_jwt_extended import jwt_required, current_user
from sqlalchemy.sql.expression import func
from datetime import datetime
from db import get_db
from models import *
from schemas import *
import models

progress = Blueprint("progress", __name__, url_prefix="/user/progress")
db = get_db()


@progress.route("measurements/add", methods=["GET", "POST"])
@jwt_required()
def add_measurements():
    if request.method == "GET":
        schema = {
            "measurements": [
                bmc.name for bmc in db.query(BodyMeasurementCriteria).all()
            ]
        }
        return render_template("auth/add_measurements.html", schema=schema)

    records = []
    for key, val in request.form.items():
        if val:
            records.append({"name": key, "record": float(val)})

    new_records = []
    for record in records:
        criteria = (
            db.query(BodyMeasurementCriteria)
            .filter(BodyMeasurementCriteria.name == record["name"])
            .first()
        )
        if not criteria:
            return (
                jsonify(
                    {
                        "Error": f'There is no such BodyMeasurementCriteria as {record["name"]}'
                    }
                ),
                404,
            )
        new_records.append(
            BodyMeasurementRecord(
                record=record["record"],
                date=datetime.today().strftime("%Y-%m-%d"),
                user_id=current_user.id,
                criteria_id=criteria.id,
            )
        )
    db.add_all(new_records)
    db.flush()

    new_records_schema = []
    for new_record in new_records:
        db.refresh(new_record)
        new_records_schema.append(MeasurementRecordInfoSchema().dump(new_record))
        new_records_schema[-1]["name"] = (
            db.query(BodyMeasurementCriteria)
            .filter(BodyMeasurementCriteria.id == new_record.criteria_id)
            .first()
            .name
        )

    db.commit()
    return redirect("/user/progress/measurements")


@progress.route("measurements", methods=["GET"])
@jwt_required()
def get_measurements_progress():
    schema = userAndMeasurementsInfoSchema().dump(current_user)
    schema["birthday"] = str(schema["birthday"])
    schema["measurement_records"] = []
    measurement_criterias = db.query(BodyMeasurementCriteria).all()
    for criteria in measurement_criterias:
        schema["measurement_records"].append(
            get_measurement_records_graph_schema(current_user, criteria)
        )
    print(schema)
    return render_template("progress/measurements.html", schema=schema)
    return schema


@progress.route("exercises", methods=["GET", "POST"])
@jwt_required()
def get_exercises_progress():
    schema = userAndMeasurementsInfoSchema().dump(current_user)
    schema["birthday"] = str(schema["birthday"])

    if request.method == "POST":
        exercise_name = request.form.get("exercise_name")
        exercise = (
            db.query(Exercise)
            .filter(Exercise.name.like(f"%{exercise_name}%"))
            .order_by(func.length(Exercise.name))
            .first()
        )
        if exercise is None:
            return {"Error": "Cannot find the exercise"}

        schema["graph"] = {
            "graph_name": exercise.name,
            "coordinates": {"reps": [], "time": [], "weight": []},
        }

        records = get_records_for_exercises([exercise])
        for record in records:
            values = get_values_from_exercise_record(record)
            for key, val in values.items():
                if val != 0:
                    schema["graph"]["coordinates"][key].append(
                        {"value": val, "date": str(record.date)}
                    )
    return render_template("progress/exercises.html", schema=schema)


@progress.route("muscles", methods=["GET", "POST"])
@jwt_required()
def get_muscles_progress():
    schema = userAndMeasurementsInfoSchema().dump(current_user)

    if request.method == "POST":
        muscle_name = request.form.get("muscle_name").lower()

        muscle = (
            db.query(Muscle)
            .filter(Muscle.name.like(f"%{muscle_name}%"))
            .order_by(func.length(Muscle.name))
            .first()
        )
        if muscle is None:
            return {"Error": "Cannot find the muscle"}

        schema["graph"] = {
            "graph_name": muscle.name,
            "coordinates": {"reps": [], "time": [], "weight": []},
        }

        exercise_ids = [
            mw.exercise_id
            for mw in db.query(MuscleWorked)
            .filter(MuscleWorked.muscle_id == muscle.id)
            .all()
        ]

        exercises = db.query(Exercise).filter(Exercise.id.in_(exercise_ids)).all()

        records = get_records_for_exercises(exercises)

        dates = sorted(list(set([record.date for record in records])))
        coordinates = {}
        for date in dates:
            coordinates[date] = {"reps": [], "time": [], "weight": []}

        for record in records:
            values = get_values_from_exercise_record(record)
            for key, val in values.items():
                if val != 0:
                    coordinates[record.date][key].append(val)

        for date in dates:
            for key in ["reps", "time", "weight"]:
                if len(coordinates[date][key]) > 0:
                    schema["graph"]["coordinates"][key].append(
                        {
                            "value": sum(coordinates[date][key])
                            / len(coordinates[date][key]),
                            "date": str(date),
                        }
                    )
    return render_template("progress/muscles.html", schema=schema)


def get_records_for_exercises(exercises):
    exercise_ids = [exercise.id for exercise in exercises]

    session_ids = [
        session.id
        for session in db.query(models.Session)
        .filter(models.Session.user_id == current_user.id)
        .order_by(models.Session.date)
    ]

    records = list(
        db.query(ExerciseRecord).filter(
            ExerciseRecord.session_id.in_(session_ids),
            ExerciseRecord.exercise_id.in_(exercise_ids),
        )
    )

    for i in range(len(records)):
        records[i].date = (
            db.query(models.Session)
            .filter(models.Session.id == records[i].session_id)
            .first()
            .date
        )

    return records


def get_values_from_exercise_record(record):
    sets = (
        db.query(ExerciseSet).filter(ExerciseSet.exercise_record_id == record.id).all()
    )
    reps = 0
    time = 0
    weight = 0
    for set in sets:
        reps += set.reps
        time += set.time
        weight += set.weight
    reps /= len(sets)
    time /= len(sets)
    weight /= len(sets)
    return {"reps": reps, "time": time, "weight": weight}


def get_measurement_records_graph_schema(user, criteria):
    schema = {"graph_name": criteria.name, "coordinates": []}

    records = (
        db.query(BodyMeasurementRecord)
        .filter(
            BodyMeasurementRecord.user_id == current_user.id,
            BodyMeasurementRecord.criteria_id == criteria.id,
        )
        .order_by(BodyMeasurementRecord.date)
    )

    for record in records:
        coordinate = {"value": record.record, "date": str(record.date)}
        schema["coordinates"].append(coordinate)
    return schema
