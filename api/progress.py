from flask import Blueprint, request, jsonify
from datetime import datetime
from db import get_db
from models import *
from schemas import *
progress = Blueprint('progress', __name__, url_prefix='/user/progress')


@progress.route('/progress')
def hello():
    return 'Hello, progress!'


@progress.route('/measurements/add', methods=['POST'])
def add_measurements():
    db = get_db()
    user_id = request.args.get("user_id")  # temporary
    records = request.json

    new_records = []
    for record in records:
        criteria = db.query(BodyMeasurementCriteria).filter(
            BodyMeasurementCriteria.name == record['name']).first()
        if not criteria:
            return jsonify({'Error': f'There is no such BodyMeasurementCriteria as {record["name"]}'}), 404
        new_records.append(BodyMeasurementRecord(
            record=record['record'],
            date=datetime.today().strftime('%Y-%m-%d'),
            user_id=user_id,
            criteria_id=criteria.id
        ))
    db.add_all(new_records)
    db.flush()

    new_records_schema = []
    for new_record in new_records:
        db.refresh(new_record)
        new_records_schema.append(
            MeasurementRecordInfoSchema().dump(new_record))
        new_records_schema[-1]['name'] = db.query(BodyMeasurementCriteria).filter(
            BodyMeasurementCriteria.id == new_record.criteria_id).first().name

    db.commit()
    return jsonify(new_records_schema)
