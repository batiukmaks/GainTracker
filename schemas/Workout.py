from marshmallow import Schema, fields
from models import Workout

class MuscleInfoSchema(Schema):
    id = fields.Int()
    name = fields.Str()

class ExerciseInfoSchema(Schema):
    id = fields.Int()
    name = fields.Str()
    equipment = fields.Str()
    type = fields.Str()
    muscles = fields.List(fields.Nested(MuscleInfoSchema))
    description = fields.Str()
    author_id = fields.Int()

class WorkoutCreationSchema(Schema):
    name = fields.Str(required=True)
    exercises = fields.List(fields.Int(), required=True)
    author_id = fields.Int()

class WorkoutInfoSchema(WorkoutCreationSchema):
    id = fields.Int()
    exercises = fields.List(fields.Nested(ExerciseInfoSchema))

