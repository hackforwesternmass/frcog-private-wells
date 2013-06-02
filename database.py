from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine
import ConfigParser, os, logging, sys

# read some database configuration from the config 
# file, get private info from environment variable
parser = ConfigParser.ConfigParser()
parser.read(os.path.join(os.path.dirname(__file__), 'frcog-private-wells.cfg'))

if not os.environ.get('FRCOG_PASSWORD'):
    logging.error("The FRCOG_PASSWORD environment variable was not found." + 
                  " Please set this on the command line.")
    sys.exit(15)

host = parser.get('Database', 'Host')
catalog = parser.get('Database', 'Catalog')
port = parser.get('Database', 'Port')
user = parser.get('Database', 'User')
password = os.environ["FRCOG_PASSWORD"]

database_url = ("postgresql://{user}:{password}@{host}:{port}/{catalog}"
                .format(user=user, password=password, host=host, 
                                        port=port, catalog=catalog))

db = create_engine(database_url)
db_session = scoped_session(sessionmaker(autocommit=False, autoflush=False, bind=db)) 

Base = declarative_base()
Base.query = db_session.query_property()

def init_db():
    import models
    Base.metadata.create_all(bind=db)

