
DROP TABLE IF EXISTS xref_users_municipalities;

-- Water Quality Reports
DROP TABLE IF EXISTS water_quality_reports_measurements;
DROP TABLE IF EXISTS water_quality_reports;

-- Wells
DROP TABLE IF EXISTS wells_yields;
DROP TABLE IF EXISTS wells;

-- Reference tables
DROP TABLE IF EXISTS wells_types;
DROP TABLE IF EXISTS measurements_types;
DROP TABLE IF EXISTS municipalities;

-- Users
DROP TABLE IF EXISTS users;

------------------------------------------
-- USERS
------------------------------------------

CREATE TABLE users (
	id        		SERIAL PRIMARY KEY,
	username		varchar(100) UNIQUE,
	password		varchar(100),  	---- BAD, BAD, BAD, REFACTOR ME!!!!!
	email			varchar(100) UNIQUE,
	first_name		varchar(100),
	last_name		varchar(100),
	created_on  		date not null default CURRENT_DATE,
	created_by  		integer null,
	modified_on  		date not null default CURRENT_DATE,
	modified_by  		integer null
);

------------------------------------------
-- REFERENCE TABLES
------------------------------------------

CREATE TABLE municipalities (
	id			SERIAL PRIMARY KEY,
	name			varchar(100),
	created_on  		date not null default CURRENT_DATE,
	created_by  		integer references users(id) not null,
	modified_on  		date not null default CURRENT_DATE,
	modified_by  		integer references users(id) not null
);

CREATE TABLE wells_types (
	id			SERIAL PRIMARY KEY,
	name			varchar(100) null,
	created_on  		date not null default CURRENT_DATE,
	created_by  		integer references users(id) not null,
	modified_on  		date not null default CURRENT_DATE,
	modified_by  		integer references users(id) not null
);

CREATE TABLE measurements_types (
	id			SERIAL PRIMARY KEY,
	name			varchar(100) not null,
	created_on  		date not null default CURRENT_DATE,
	created_by  		integer references users(id) not null,
	modified_on  		date not null default CURRENT_DATE,
	modified_by  		integer references users(id) not null
);

------------------------------------------
-- CORE DATA TABLES - PRIVATE WELLS
------------------------------------------

CREATE TABLE wells (
	id			SERIAL PRIMARY KEY,
	dep_well_id		integer null,
	street_address1		varchar(100) null,
	street_address2		varchar(100) null,
	city			varchar(100) null,
	latitude		float null,
	longitude		float null,
	municipalities_id	integer references municipalities(id),
	well_types_id		integer references wells_types(id),
	created_on  		date not null default CURRENT_DATE,
	created_by  		integer references users(id) not null,
	modified_on  		date not null default CURRENT_DATE,
	modified_by  		integer references users(id) not null
);


CREATE TABLE wells_yields (
	id			SERIAL PRIMARY KEY,
	date			date null,
	rate			float not null,
	description		text,
	wells_id		integer not null references wells(id),
	created_on  		date not null default CURRENT_DATE,
	created_by  		integer references users(id) not null,
	modified_on  		date not null default CURRENT_DATE,
	modified_by  		integer references users(id) not null
);

------------------------------------------
-- CORE DATA TABLES - WATER QUALITY REPORTS
------------------------------------------

CREATE TABLE water_quality_reports (
	id			SERIAL PRIMARY KEY,
	wells_id		integer not null references wells(id),
	created_on  		date not null default CURRENT_DATE,
	created_by  		integer references users(id) not null,
	modified_on  		date not null default CURRENT_DATE,
	modified_by  		integer references users(id) not null
);

CREATE TABLE water_quality_reports_measurements (
	id				SERIAL PRIMARY KEY,
	measurements_types_id		integer not null references measurements_types(id),
	water_quality_reports_id	integer not null references water_quality_reports(id),
	created_on  			date not null default CURRENT_DATE,
	created_by  			integer references users(id) not null,
	modified_on  			date not null default CURRENT_DATE,
	modified_by  			integer references users(id) not null
);




------------------------------------------
-- XREF TABLES
------------------------------------------


CREATE TABLE xref_users_municipalities (
	id			SERIAL PRIMARY KEY,
	users_id		integer references users(id),
	municipalities_id	integer references municipalities(id),
	created_on  		date not null default CURRENT_DATE,
	created_by  		integer references users(id) not null,
	modified_on  		date not null default CURRENT_DATE,
	modified_by  		integer references users(id) not null
);

ALTER TABLE xref_users_municipalities ADD CONSTRAINT xref_users_municipalities_unique UNIQUE (users_id, municipalities_id);


------------------------------------------
-- DATA INITIALIZATION
------------------------------------------

INSERT INTO users (username, password, email, first_name, last_name) values ('admin', 'admin', 'rpitre@gmail.com', 'data', 'init');
INSERT INTO municipalities (name, created_by, modified_by) values ('northampton', 1, 1);

