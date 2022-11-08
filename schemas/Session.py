from marshmallow import Schema, fields, post_load
from models import ExerciseSet


class ExerciseSetSchema(Schema):
    sequence_number = fields.Integer()
    reps = fields.Integer()
    time = fields.Float()
    weight = fields.Float()
    exercise_record_id = fields.Integer()

    @post_load
    def make_set(self, data, **kwargs):
        return ExerciseSet(**data)


class RecordCreationSchema(Schema):
    exercise_id = fields.Integer()
    sets = fields.List(fields.Nested(ExerciseSetSchema))


class RecordInfoSchema(RecordCreationSchema):
    id = fields.Integer()
    exercise_name = fields.String()


class SessionCreationSchema(Schema):
    date = fields.Date(format='%d-%m-%Y')
    workout_id = fields.Integer()
    records = fields.List(fields.Nested(RecordCreationSchema))


class SessionInfoForListSchema(Schema):
    id = fields.Integer()
    workout_id = fields.Integer()
    workout_name = fields.String()
    date = fields.Date(format='%d-%m-%Y')


class SessionFullInfoSchema(SessionInfoForListSchema):
    records = fields.List(fields.Nested(RecordInfoSchema))
