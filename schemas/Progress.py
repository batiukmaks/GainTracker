from marshmallow import Schema, fields, post_load
from .User import UserInfoSchema


class MeasurementRecordCreationSchema(Schema):
    name = fields.Str()
    record = fields.Float()

class MeasurementRecordInfoSchema(MeasurementRecordCreationSchema):
    id = fields.Integer()
    user_id = fields.Integer()
    date = fields.Date()

class CoordinateSchema(Schema):
    value = fields.Float()
    date = fields.Date()

class GraphSchema(Schema):
    graph_name = fields.Str()
    coordinates = fields.List(fields.Nested(CoordinateSchema))

class userAndMeasurementsInfoSchema(UserInfoSchema):
    measurement_records = fields.List(fields.Nested(GraphSchema))

class userAndExerciseInfoSchema(UserInfoSchema):
    graph = fields.Nested(GraphSchema)

class userAndMuscleInfoSchema(UserInfoSchema):
    graph = fields.Nested(GraphSchema)
