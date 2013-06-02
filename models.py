from flask.ext.sqlalchemy import *
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime
from database import Base
from sqlalchemy.orm import relationship, backref

class Well(Base):
    __tablename__ = "wells"

    id = Column(Integer, primary_key=True)
    dep_well_id = Column(Integer)
    owner_name = Column(String(100))
    owner_street_1 = Column(String(100))
    owner_street_2 = Column(String(100))
    owner_city = Column(String(100))
    owner_state =Column(String(100))
    owner_zip = Column(String(100))
    well_street_1 = Column(String(100))
    well_street_2 = Column(String(100))
    latitude = Column(Float(53), primary_key=False)
    longitude = Column(Float(53), primary_key=False)
    total_depth = Column(Integer, primary_key=False)
    depth_to_bedrock = Column(Integer, primary_key=False)
    assessors_map = Column(String(10), primary_key=False)
    assessors_lot = Column(String(10), primary_key=False)
    boh_date_issued = Column(DateTime, primary_key=False)
    boh_permit = Column(String(100), primary_key=False)
    comments = Column(Text, primary_key=False)
    wc_date = Column(DateTime, primary_key=False)
    firm = Column(String(100), primary_key=False)
    supervising_driller = Column(String(100), primary_key=False)
    field_notes = Column(Text, primary_key=False)
    municipalities_id = Column(Integer, ForeignKey("municipalities.id"))
    municipality = relationship(lambda: Municipality,
                                primaryjoin = lambda: Well.municipalities_id==Municipality.id)
    well_types_id = Column(Integer, ForeignKey("well_types.id"))
    created_on = Column(DateTime, primary_key=False, nullable=False, default=text(u"('now'::text)::date"))
    created_by = Column(Integer, primary_key=False, nullable=False)
    modified_on = Column(DateTime, primary_key=False, nullable=False, default=text(u"('now'::text)::date"))
    modified_by = Column(Integer, primary_key=False, nullable=False)

class Municipality(Base):
    __tablename__ = "municipalities"

    id = Column(Integer, primary_key=True)
    name = Column(String(100))

class WellTypes(Base):
    __tablename__ = "well_types"
    id = Column(Integer, primary_key=True)


