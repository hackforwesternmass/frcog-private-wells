import os, ConfigParser, logging, sys
from flask import Flask, render_template
from dbmanager import DatabaseManager

app = Flask(__name__)

# read some database configuration from the config 
# file, get private info from environment variable
parser = ConfigParser.ConfigParser()
parser.read(os.path.join(os.path.dirname(__file__)), 'frcog-private-wells.cfg')

if not os.environ['FRCOG-PASSWORD']:
    logging.error("The FRCOG-PASSWORD environment variable was not found." + 
                  " Please set this on the command line.")
    sys.exit(15)

dbmanager = DatabaseManager(parser.get('Database', 'Host'), parser.get('Database', 'Catalog'), 
                            parser.get('Database', 'User'), parser.get('Database', 'Port'), 
                            parser.password)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/map')
def map():
    return render_template('map.html')

@app.route('/wells')
def wells():
    wells = dbmanager.get_wells_view()
    return render_template('well-list.html', {'wells' : wells})

@app.route('/wells/edit', methods=['GET', 'POST'])
def edit_well():
    if request.method == "POST":
        return render_template('edit-well.html')
    else:
        return render_template('edit-well.html')

@app.route('/reports', methods=['GET'])
def reports():
    return render_template('reports.html')

@app.route('/reports/edit', metods=['GET', 'POST'])
def edit_report():
    return render_template('edit-report.html')

@app.route('/quality-measures', methods=['GET', 'POST'])
def edit_quality_measure_list():
    return render_template('edit-quality-measures.html')
    

