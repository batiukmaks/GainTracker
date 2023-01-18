from sqlalchemy import Column, String, Integer, Date, Text
from sqlalchemy.orm import relationship
from models.Base import Base


class User(Base):
    __tablename__ = "user"

    id = Column(Integer, primary_key=True)
    username = Column(String(255))
    email = Column(String(255))
    password = Column(Text)
    first_name = Column(String(255))
    last_name = Column(String(255))
    sex = Column(String(255))
    birthday = Column(Date)

    body_measurement_records = relationship(
        "BodyMeasurementRecord", cascade="all, delete-orphan"
    )
    workouts = relationship("Workout", cascade="all, delete-orphan")
    sessions = relationship("Session", cascade="all, delete-orphan")
    exercises = relationship("Exercise", cascade="all, delete-orphan")
