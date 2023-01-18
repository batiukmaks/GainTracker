from sqlalchemy import Column, String, Integer, ForeignKey, Text
from sqlalchemy.orm import relationship
from models.Base import Base


class Exercise(Base):
    __tablename__ = "exercise"

    id = Column(Integer, primary_key=True)
    name = Column(String(255))
    equipment = Column(String(255))
    description = Column(Text)
    author_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))

    muscles_worked = relationship("MuscleWorked", cascade="all, delete-orphan")
    workout_exercises = relationship("WorkoutExercise", cascade="all, delete-orphan")
    exercise_records = relationship("ExerciseRecord", cascade="all, delete-orphan")
    exercise_types = relationship("ExerciseType", cascade="all, delete-orphan")


class ExerciseType(Base):
    __tablename__ = "exercise_type"

    id = Column(Integer, primary_key=True)
    exercise_id = Column(Integer, ForeignKey("exercise.id", ondelete="CASCADE"))
    exercise_type = Column(String(255))
