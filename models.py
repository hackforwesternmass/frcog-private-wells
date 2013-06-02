# -*- coding: utf-8 -*-
## File autogenerated by SQLAutoCode
## see http://code.google.com/p/sqlautocode/

from flask.ext.sqlalchemy import *
from sqlalchemy import *
#from sqlalchemy.databases.postgresql import *

metadata = MetaData()


wells_types =  Table('wells_types', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".wells_types_id_seq\'::regclass)')),
            Column(u'name', VARCHAR(length=100), primary_key=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False, nullable=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False, nullable=False),
    ForeignKeyConstraint([u'created_by'], [u'public.users.id'], name=u'wells_types_created_by_fkey'),
            ForeignKeyConstraint([u'modified_by'], [u'public.users.id'], name=u'wells_types_modified_by_fkey'),
    
    )
Index('wells_types_pkey', wells_types.c.id, unique=True)


wells_yields =  Table('wells_yields', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".wells_yields_id_seq\'::regclass)')),
            Column(u'date', DATE(), primary_key=False),
            Column(u'rate', Float(precision=53), primary_key=False, nullable=False),
            Column(u'description', TEXT(), primary_key=False),
            Column(u'wells_id', INTEGER(), primary_key=False, nullable=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False, nullable=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False, nullable=False),
    ForeignKeyConstraint([u'created_by'], [u'public.users.id'], name=u'wells_yields_created_by_fkey'),
            ForeignKeyConstraint([u'modified_by'], [u'public.users.id'], name=u'wells_yields_modified_by_fkey'),
            ForeignKeyConstraint([u'wells_id'], [u'public.wells.id'], name=u'wells_yields_wells_id_fkey'),
    
    )
Index('wells_yields_pkey', wells_yields.c.id, unique=True)


wells =  Table('wells', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".wells_id_seq\'::regclass)')),
            Column(u'dep_well_id', INTEGER(), primary_key=False),
            Column(u'owner_name', VARCHAR(length=100), primary_key=False),
            Column(u'owner_street_1', VARCHAR(length=100), primary_key=False),
            Column(u'owner_street_2', VARCHAR(length=100), primary_key=False),
            Column(u'owner_city', VARCHAR(length=100), primary_key=False),
            Column(u'owner_state', VARCHAR(length=100), primary_key=False),
            Column(u'owner_zip', VARCHAR(length=100), primary_key=False),
            Column(u'well_street_1', VARCHAR(length=100), primary_key=False),
            Column(u'well_street_2', VARCHAR(length=100), primary_key=False),
            Column(u'latitude', Float(precision=53), primary_key=False),
            Column(u'longitude', Float(precision=53), primary_key=False),
            Column(u'total_depth', INTEGER(), primary_key=False),
            Column(u'depth_to_bedrock', INTEGER(), primary_key=False),
            Column(u'assessors_map', VARCHAR(length=10), primary_key=False),
            Column(u'assessors_lot', VARCHAR(length=10), primary_key=False),
            Column(u'boh_date_issued', DATE(), primary_key=False),
            Column(u'boh_permit', VARCHAR(length=100), primary_key=False),
            Column(u'comments', TEXT(), primary_key=False),
            Column(u'wc_date', DATE(), primary_key=False),
            Column(u'firm', VARCHAR(length=100), primary_key=False),
            Column(u'supervising_driller', VARCHAR(length=100), primary_key=False),
            Column(u'field_notes', TEXT(), primary_key=False),
            Column(u'municipalities_id', INTEGER(), primary_key=False),
            Column(u'well_types_id', INTEGER(), primary_key=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False, nullable=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False, nullable=False),
    ForeignKeyConstraint([u'municipalities_id'], [u'public.municipalities.id'], name=u'wells_municipalities_id_fkey'),
            ForeignKeyConstraint([u'well_types_id'], [u'public.wells_types.id'], name=u'wells_well_types_id_fkey'),
            ForeignKeyConstraint([u'created_by'], [u'public.users.id'], name=u'wells_created_by_fkey'),
            ForeignKeyConstraint([u'modified_by'], [u'public.users.id'], name=u'wells_modified_by_fkey'),
    
    )
Index('wells_pkey', wells.c.id, unique=True)


measurements_types =  Table('measurements_types', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".measurements_types_id_seq\'::regclass)')),
            Column(u'name', VARCHAR(length=100), primary_key=False, nullable=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False, nullable=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False, nullable=False),
    ForeignKeyConstraint([u'modified_by'], [u'public.users.id'], name=u'measurements_types_modified_by_fkey'),
            ForeignKeyConstraint([u'created_by'], [u'public.users.id'], name=u'measurements_types_created_by_fkey'),
    
    )
Index('measurements_types_pkey', measurements_types.c.id, unique=True)


water_quality_reports =  Table('water_quality_reports', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".water_quality_reports_id_seq\'::regclass)')),
            Column(u'wells_id', INTEGER(), primary_key=False, nullable=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False, nullable=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False, nullable=False),
    ForeignKeyConstraint([u'created_by'], [u'public.users.id'], name=u'water_quality_reports_created_by_fkey'),
            ForeignKeyConstraint([u'modified_by'], [u'public.users.id'], name=u'water_quality_reports_modified_by_fkey'),
            ForeignKeyConstraint([u'wells_id'], [u'public.wells.id'], name=u'water_quality_reports_wells_id_fkey'),
    
    )
Index('water_quality_reports_pkey', water_quality_reports.c.id, unique=True)


water_quality_reports_measurements =  Table('water_quality_reports_measurements', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".water_quality_reports_measurements_id_seq\'::regclass)')),
            Column(u'measurements_types_id', INTEGER(), primary_key=False, nullable=False),
            Column(u'water_quality_reports_id', INTEGER(), primary_key=False, nullable=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False, nullable=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False, nullable=False),
    ForeignKeyConstraint([u'created_by'], [u'public.users.id'], name=u'water_quality_reports_measurements_created_by_fkey'),
            ForeignKeyConstraint([u'measurements_types_id'], [u'public.measurements_types.id'], name=u'water_quality_reports_measurements_measurements_types_id_fkey'),
            ForeignKeyConstraint([u'water_quality_reports_id'], [u'public.water_quality_reports.id'], name=u'water_quality_reports_measurement_water_quality_reports_id_fkey'),
            ForeignKeyConstraint([u'modified_by'], [u'public.users.id'], name=u'water_quality_reports_measurements_modified_by_fkey'),
    
    )
Index('water_quality_reports_measurements_pkey', water_quality_reports_measurements.c.id, unique=True)


municipalities =  Table('municipalities', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".municipalities_id_seq\'::regclass)')),
            Column(u'name', VARCHAR(length=100), primary_key=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False, nullable=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False, nullable=False),
    ForeignKeyConstraint([u'created_by'], [u'public.users.id'], name=u'municipalities_created_by_fkey'),
            ForeignKeyConstraint([u'modified_by'], [u'public.users.id'], name=u'municipalities_modified_by_fkey'),
    
    )
Index('municipalities_pkey', municipalities.c.id, unique=True)


users =  Table('users', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".users_id_seq\'::regclass)')),
            Column(u'username', VARCHAR(length=100), primary_key=False),
            Column(u'password', VARCHAR(length=100), primary_key=False),
            Column(u'email', VARCHAR(length=100), primary_key=False),
            Column(u'first_name', VARCHAR(length=100), primary_key=False),
            Column(u'last_name', VARCHAR(length=100), primary_key=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False),
    
    
    )
Index(u'users_username_key', users.c.username, unique=True)
Index(u'users_email_key', users.c.email, unique=True)


xref_users_municipalities =  Table('xref_users_municipalities', metadata,
    Column(u'id', INTEGER(), primary_key=True, nullable=False, default=text(u'nextval(\'"public".xref_users_municipalities_id_seq\'::regclass)')),
            Column(u'users_id', INTEGER(), primary_key=False),
            Column(u'municipalities_id', INTEGER(), primary_key=False),
            Column(u'created_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'created_by', INTEGER(), primary_key=False, nullable=False),
            Column(u'modified_on', DATE(), primary_key=False, nullable=False, default=text(u"('now'::text)::date")),
            Column(u'modified_by', INTEGER(), primary_key=False, nullable=False),
    ForeignKeyConstraint([u'users_id'], [u'public.users.id'], name=u'xref_users_municipalities_users_id_fkey'),
            ForeignKeyConstraint([u'municipalities_id'], [u'public.municipalities.id'], name=u'xref_users_municipalities_municipalities_id_fkey'),
            ForeignKeyConstraint([u'created_by'], [u'public.users.id'], name=u'xref_users_municipalities_created_by_fkey'),
            ForeignKeyConstraint([u'modified_by'], [u'public.users.id'], name=u'xref_users_municipalities_modified_by_fkey'),
    
    )
Index(u'xref_users_municipalities_unique', xref_users_municipalities.c.users_id, xref_users_municipalities.c.municipalities_id, unique=True)

