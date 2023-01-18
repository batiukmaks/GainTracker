from sqlalchemy import Column, String, Integer, Date, Float, ForeignKey
from sqlalchemy.orm import relationship
from models.Base import Base


class ExerciseRecord(Base):
    __tablename__ = "exercise_record"

    id = Column(Integer, primary_key=True)

    session_id = Column(Integer, ForeignKey("session.id", ondelete="CASCADE"))
    exercise_id = Column(Integer, ForeignKey("exercise.id", ondelete="CASCADE"))

    exercise_sets = relationship("ExerciseSet", cascade="all, delete-orphan")


class ExerciseSet(Base):
    __tablename__ = "exercise_set"

    id = Column(Integer, primary_key=True)
    sequence_number = Column(Integer)
    reps = Column(Integer)
    time = Column(Float)
    weight = Column(Float)

    exercise_record_id = Column(
        Integer, ForeignKey("exercise_record.id", ondelete="CASCADE")
    )
