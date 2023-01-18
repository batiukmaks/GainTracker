from sqlalchemy import Column, String, Integer, Float, Date, ForeignKey
from sqlalchemy.orm import relationship
from models.Base import Base


class BodyMeasurementRecord(Base):
    __tablename__ = "body_measurement_record"

    id = Column(Integer, primary_key=True)
    record = Column(Float)
    date = Column(Date)

    user_id = Column(Integer, ForeignKey("user.id", ondelete="CASCADE"))
    criteria_id = Column(
        Integer, ForeignKey("body_measurement_criteria.id", ondelete="CASCADE")
    )


class BodyMeasurementCriteria(Base):
    __tablename__ = "body_measurement_criteria"

    id = Column(Integer, primary_key=True)
    name = Column(String(255))

    body_measurements = relationship(
        "BodyMeasurementRecord", cascade="all, delete-orphan"
    )
