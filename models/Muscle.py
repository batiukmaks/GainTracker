from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship
from models.Base import Base

class Muscle(Base):
    __tablename__ = "muscle"

    id = Column(Integer, primary_key=True)
    name = Column(String(255))

    muscles_worked = relationship("MuscleWorked", cascade="all, delete-orphan")

class MuscleWorked(Base):
    __tablename__ = "muscle_worked"

    id = Column(Integer, primary_key=True)
    muscle_id = Column(Integer, ForeignKey("muscle.id", ondelete="CASCADE"))
    exercise_id = Column(Integer, ForeignKey("exercise.id", ondelete="CASCADE"))