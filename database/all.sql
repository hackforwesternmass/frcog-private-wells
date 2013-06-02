
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
	created_on  		timestamp not null default CURRENT_TIMESTAMP,
	created_by  		integer null,
	modified_on  		timestamp not null default CURRENT_TIMESTAMP,
	modified_by  		integer null
);

------------------------------------------
-- REFERENCE TABLES
------------------------------------------

CREATE TABLE municipalities (
	id			SERIAL PRIMARY KEY,
	name			varchar(100),
	created_on  		timestamp not null default CURRENT_TIMESTAMP,
	created_by  		integer references users(id) not null,
	modified_on  		timestamp not null default CURRENT_TIMESTAMP,
	modified_by  		integer references users(id) not null
);

CREATE TABLE wells_types (
	id			SERIAL PRIMARY KEY,
	name			varchar(100) null,
	created_on  		timestamp not null default CURRENT_TIMESTAMP,
	created_by  		integer references users(id) not null,
	modified_on  		timestamp not null default CURRENT_TIMESTAMP,
	modified_by  		integer references users(id) not null
);

CREATE TABLE measurements_types (
	id			SERIAL PRIMARY KEY,
	name			varchar(100) not null,
	created_on  		timestamp not null default CURRENT_TIMESTAMP,
	created_by  		integer references users(id) not null,
	modified_on  		timestamp not null default CURRENT_TIMESTAMP,
	modified_by  		integer references users(id) not null
);

------------------------------------------
-- CORE DATA TABLES - PRIVATE WELLS
------------------------------------------

CREATE TABLE wells (
	id			SERIAL PRIMARY KEY,
	dep_well_id 		integer,
	owner_name 		varchar(100) null,
	owner_street_1 		varchar(100) null,
	owner_street_2 		varchar(100) null,
	owner_city 		varchar(100) null,
	owner_state 		varchar(100) null,
	owner_zip 		varchar(100) null,
	well_street_1 		varchar(100) null,
	well_street_2 		varchar(100) null,
	latitude 		double precision,
	longitude 		double precision,
	total_depth 		integer,
	depth_to_bedrock 	integer,
	assessors_map 		varchar(10) null,
	assessors_lot 		varchar(10) null,
	boh_date_issued 	date null,
	boh_permit		varchar(100) null,
	comments		text null,
	wc_date			date null,
	firm			varchar(100) null,
	supervising_driller	varchar(100) null,
	field_notes		text,
	municipalities_id	integer references municipalities(id),
	well_types_id		integer references wells_types(id),
	created_on  		timestamp not null default CURRENT_TIMESTAMP,
	created_by  		integer references users(id) not null,
	modified_on  		timestamp not null default CURRENT_TIMESTAMP,
	modified_by  		integer references users(id) not null
);


CREATE TABLE wells_yields (
	id			SERIAL PRIMARY KEY,
	date			date null,
	rate			float not null,
	description		text,
	wells_id		integer not null references wells(id),
	created_on  		timestamp not null default CURRENT_TIMESTAMP,
	created_by  		integer references users(id) not null,
	modified_on  		timestamp not null default CURRENT_TIMESTAMP,
	modified_by  		integer references users(id) not null
);

------------------------------------------
-- CORE DATA TABLES - WATER QUALITY REPORTS
------------------------------------------

CREATE TABLE water_quality_reports (
	id			SERIAL PRIMARY KEY,
	wells_id		integer not null references wells(id),
	created_on  		timestamp not null default CURRENT_TIMESTAMP,
	created_by  		integer references users(id) not null,
	modified_on  		timestamp not null default CURRENT_TIMESTAMP,
	modified_by  		integer references users(id) not null
);

CREATE TABLE water_quality_reports_measurements (
	id				SERIAL PRIMARY KEY,
	measurements_types_id		integer not null references measurements_types(id),
	water_quality_reports_id	integer not null references water_quality_reports(id),
	created_on  			timestamp not null default CURRENT_TIMESTAMP,
	created_by  			integer references users(id) not null,
	modified_on  			timestamp not null default CURRENT_TIMESTAMP,
	modified_by  			integer references users(id) not null
);




------------------------------------------
-- XREF TABLES
------------------------------------------


CREATE TABLE xref_users_municipalities (
	id			SERIAL PRIMARY KEY,
	users_id		integer references users(id),
	municipalities_id	integer references municipalities(id),
	created_on  		timestamp not null default CURRENT_TIMESTAMP,
	created_by  		integer references users(id) not null,
	modified_on  		timestamp not null default CURRENT_TIMESTAMP,
	modified_by  		integer references users(id) not null
);

ALTER TABLE xref_users_municipalities ADD CONSTRAINT xref_users_municipalities_unique UNIQUE (users_id, municipalities_id);


------------------------------------------
-- DATA INITIALIZATION
------------------------------------------

INSERT INTO users (username, password, email, first_name, last_name) values ('admin', 'admin', 'rpitre@gmail.com', 'data', 'init');

INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ABINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ACTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ACUSHNET',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ADAMS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('AGAWAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ALFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('AMESBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('AMHERST',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ANDOVER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('AQUINNAH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ARLINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ASHBURNHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ASHBY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ASHFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ASHLAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ATHOL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ATTLEBORO',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('AUBURN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('AVON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('AYER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BARNSTABLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BARRE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BECKET',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BEDFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BELCHERTOWN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BELLINGHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BELMONT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BERKLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BERLIN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BERNARDSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BEVERLY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BILLERICA',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BLACKSTONE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BLANDFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BOLTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BOSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BOURNE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BOXBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BOXFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BOYLSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BRAINTREE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BREWSTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BRIDGEWATER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BRIMFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BROCKTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BROOKFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BROOKLINE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BUCKLAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('BURLINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CAMBRIDGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CANTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CARLISLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CARVER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHARLEMONT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHARLTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHATHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHELMSFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHELSEA',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHESHIRE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHESTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHESTERFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHICOPEE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CHILMARK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CLARKSBURG',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CLINTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('COHASSET',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('COLRAIN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CONCORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CONWAY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('CUMMINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DALTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DANVERS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DARTMOUTH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DEDHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DEERFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DENNIS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DIGHTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DOUGLAS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DOVER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DRACUT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DUDLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DUNSTABLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('DUXBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('E. BRIDGEWATER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('E. BROOKFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('E. LONGMEADOW',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EAST BRIDGEWATER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EAST BROOKFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EAST LONGMEADOW',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EASTHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EASTHAMPTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EASTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EDGARTOWN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EGREMONT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ERVING',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ESSEX',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('EVERETT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FAIRHAVEN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FALL RIVER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FALMOUTH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FITCHBURG',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FLORIDA',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FOXBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FRAMINGHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FRANKLIN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('FREETOWN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GARDNER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GEORGETOWN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GILL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GLOUCESTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GOSHEN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GOSNOLD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GRAFTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GRANBY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GRANVILLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GREAT BARRINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GREENFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GROTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('GROVELAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HADLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HALIFAX',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HAMILTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HAMPDEN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HANCOCK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HANOVER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HANSON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HARDWICK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HARVARD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HARWICH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HATFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HAVERHILL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HAWLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HEATH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HINGHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HINSDALE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HOLBROOK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HOLDEN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HOLLAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HOLLISTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HOLYOKE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HOPEDALE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HOPKINTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HUBBARDSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HUDSON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HULL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('HUNTINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('IPSWICH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('KINGSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LAKEVILLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LANCASTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LANESBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LAWRENCE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LEE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LEICESTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LENOX',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LEOMINSTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LEVERETT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LEXINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LEYDEN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LINCOLN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LITTLETON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LONGMEADOW',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LOWELL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LUDLOW',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LUNENBURG',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LYNN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('LYNNFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MALDEN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MANCHESTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MANSFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MARBLEHEAD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MARION',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MARLBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MARSHFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MASHPEE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MATTAPOISETT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MAYNARD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MEDFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MEDFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MEDWAY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MELROSE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MENDON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MERRIMAC',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('METHUEN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MIDDLEBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MIDDLEFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MIDDLETON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MILFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MILLBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MILLIS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MILLVILLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MILTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MONROE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MONSON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MONTAGUE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MONTEREY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MONTGOMERY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('MOUNT WASHINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('N. ADAMS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('N. ANDOVER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('N. ATTLEBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('N. BROOKFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('N. READING',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NAHANT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NANTUCKET',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NATICK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEEDHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEW ASHFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEW BEDFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEW BRAINTREE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEW MARLBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEW SALEM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEWBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEWBURYPORT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NEWTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORFOLK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTH ADAMS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTH ANDOVER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTH ATTLEBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTH BROOKFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTH READING',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTHAMPTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTHBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTHBRIDGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTHFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORWELL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('NORWOOD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('OAK BLUFFS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('OAKHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ORANGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ORLEANS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('OTIS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('OXFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PALMER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PAXTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PEABODY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PELHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PEMBROKE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PEPPERELL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PERU',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PETERSHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PHILLIPSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PITTSFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PLAINFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PLAINVILLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PLYMOUTH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PLYMPTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PRINCETON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('PROVINCETOWN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('QUINCY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('RANDOLF',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('RANDOLPH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('RAYNHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('READING',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('REHOBOTH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('REVERE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('RICHMOND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ROCHESTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ROCKLAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ROCKPORT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ROWE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ROWLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('ROYALSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('RUSSELL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('RUTLAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('S. HADLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SALEM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SALISBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SANDISFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SANDWICH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SAUGUS',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SAVOY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SCITUATE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SEEKONK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SHARON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SHEFFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SHELBURNE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SHERBORN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SHIRLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SHREWSBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SHUTESBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SOMERSET',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SOMERVILLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SOUTH HADLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SOUTHAMPTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SOUTHBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SOUTHBRIDGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SOUTHWICK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SPENCER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SPRINGFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('STERLING',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('STOCKBRIDGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('STONEHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('STOUGHTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('STOW',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('STURBRIDGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SUDBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SUNDERLAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SUTTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SWAMPSCOTT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('SWANSEA',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TAUNTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TEMPLETON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TEWKSBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TISBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TOLLAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TOPSFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TOWNSEND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TRURO',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TYNGSBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('TYRINGHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('UPTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('UXBRIDGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('W. BOYLSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('W. BRIDGEWATER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('W. BROOKFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('W. NEWBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('W. SPRINGFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('W. STOCKBRIDGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('W. TISBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WAKEFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WALES',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WALPOLE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WALTHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WARE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WAREHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WARREN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WARWICK',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WASHINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WATERTOWN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WAYLAND',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEBSTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WELLESLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WELLFLEET',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WENDELL',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WENHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEST BOYLSTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEST BRIDGEWATER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEST BROOKFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEST NEWBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEST SPRINGFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEST STOCKBRIDGE',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEST TISBURY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WESTBOROUGH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WESTFIELD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WESTFORD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WESTHAMPTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WESTMINSTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WESTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WESTPORT',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WESTWOOD',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WEYMOUTH',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WHATELY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WHATLEY',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WHITMAN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WILBRAHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WILLIAMSBURG',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WILLIAMSTOWN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WILMINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WINCHENDON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WINCHESTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WINDSOR',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WINTHROP',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WOBURN',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WORCESTER',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WORTHINGTON',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('WRENTHAM',1,1);
INSERT INTO municipalities(name, created_by,modified_by) VALUES ('YARMOUTH',1,1);

INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Cathodic Protection',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Domestic',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Geoconstruction',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Geothermal Closed Loop',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Geothermal Open Loop',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Industrial',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Cathodic Protection',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Domestic',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Geoconstruction',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Geothermal Closed Loop',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Geothermal Open Loop',1,1);
INSERT INTO wells_types(name, created_by, modified_by) VALUES ('Industrial',1,1);
