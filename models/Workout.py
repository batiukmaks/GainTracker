from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship
from models.Base import Base

class Workout(Base):
    __tablename__ = "workout"

    id = Column(Integer, primary_key=True)
    name = Column(String(255))

    author_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    
    workout_exercises = relationship("WorkoutExercise", cascade="all, delete-orphan")
    sessions = relationship("Session", cascade="all, delete-orphan")

class WorkoutExercise(Base):
    __tablename__ = "workout_exercise"

    id = Column(Integer, primary_key=True)
    workout_id = Column(Integer, ForeignKey("workout.id", ondelete="CASCADE"))
    exercise_id = Column(Integer, ForeignKey("exercise.id", ondelete="CASCADE"))
    