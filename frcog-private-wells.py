import os, ConfigParser, logging, sys
from flask import Flask, render_template
from logging.handlers import RotatingFileHandler
from flask.ext.sqlalchemy import SQLAlchemy
from models import *

file_handler = RotatingFileHandler('private-wells.log', maxBytes=1024 * 1024 * 100, backupCount=20)
file_handler.setLevel(logging.ERROR)
formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
file_handler.setFormatter(formatter)

app = Flask(__name__)
app.config['DEBUG'] = True
app.logger.addHandler(file_handler)

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

app.config['SQLALCHEMY_DATABASE_URI'] = database_url
db = SQLAlchemy(app)
db_session = scoped_session(sessionmaker(autocommit=False, autoflush=False, bind=db))

Base = declarative_base()
Base.query = db_session.query_property()

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/map')
def map():
    return render_template('map.html')

@app.route('/wells')
def well_index():
    results = db.session.query(wells).all()
    print("{0}".format(results))
    return render_template('well-list.html', wells=results)

@app.route('/wells/edit', methods=['GET', 'POST'])
def edit_well():
    if request.method == "POST":
        return render_template('well-list.html')
    else:
        #template_to_edit
        return render_template('edit-well.html')

@app.route('/reports', methods=['GET'])
def reports():
    return render_template('reports.html')

@app.route('/reports/edit', methods=['GET', 'POST'])
def edit_report():
    return render_template('edit-report.html')

@app.route('/quality-measures', methods=['GET', 'POST'])
def edit_quality_measure_list():
    return render_template('edit-quality-measures.html')
