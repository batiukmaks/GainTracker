from marshmallow import Schema, fields, post_load
from models import Workout

class ExerciseInfoSchema(Schema):
    id = fields.Int()
    name = fields.Str()
    equipment = fields.Str()
    type = fields.Str()
    # muscles = List()
    description = fields.Str()

class WorkoutCreationSchema(Schema):
    name = fields.Str(required=True)
    exercises = fields.List(fields.Int(), required=True)
    author_id = fields.Int()

class WorkoutInfoSchema(WorkoutCreationSchema):
    id = fields.Int()
    exercises = fields.List(fields.Nested(ExerciseInfoSchema))

