from marshmallow import Schema, fields, validate, post_load
from models import User


class UserCreationSchema(Schema):
    username = fields.Str()
    email = fields.Email()
    password = fields.Str()
    first_name = fields.Str()
    last_name = fields.Str()
    sex = fields.Str(validate=validate.OneOf(['male', 'female']))
    birthday = fields.Date()

    @post_load
    def make_set(self, data, **kwargs):
        return User(**data)


class UserInfoSchema(Schema):
    id = fields.Integer()
    username = fields.Str()
    email = fields.Email()
    first_name = fields.Str()
    last_name = fields.Str()
    sex = fields.Str(validate=validate.OneOf(['male', 'female']))
    birthday = fields.Date()
