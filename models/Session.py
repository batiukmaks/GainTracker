from sqlalchemy import Column, String, Integer, Date, ForeignKey
from sqlalchemy.orm import relationship
from models.Base import Base


class Session(Base):
    __tablename__ = "session"

    id = Column(Integer, primary_key=True)
    date = Column(Date)

    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    workout_id = Column(Integer, ForeignKey("workout.id", ondelete="CASCADE"))

    exercise_records = relationship("ExerciseRecord", cascade="all, delete-orphan")
