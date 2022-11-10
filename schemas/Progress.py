from marshmallow import Schema, fields, post_load


class MeasurementRecordCreationSchema(Schema):
    name = fields.Str()
    record = fields.Float()

class MeasurementRecordInfoSchema(MeasurementRecordCreationSchema):
    id = fields.Integer()
    user_id = fields.Integer()
    date = fields.Date()
