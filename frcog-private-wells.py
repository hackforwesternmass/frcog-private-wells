import os, ConfigParser, logging, sys, json
from flask import Flask, render_template
from logging.handlers import RotatingFileHandler
from database import db_session
from models import *
from flask.ext.wtf import Form
from wtforms.ext.sqlalchemy.orm import model_form
from collections import namedtuple

app = Flask(__name__)

file_handler = RotatingFileHandler('private-wells.log', maxBytes=1024 * 1024 * 100, backupCount=20)
file_handler.setLevel(logging.ERROR)
formatter = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
file_handler.setFormatter(formatter)

app.config['DEBUG'] = True
app.logger.addHandler(file_handler)

@app.teardown_request
def shutdown_session(exception=None):
    db_session.remove()

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/map')
def map():
    return render_template('map.html')

@app.route('/wells')
def well_index():
    results = Well.query.all()
    print("{0}".format(results))
    return render_template('well-list.html', wells=results)

@app.route('/wells/edit<id>', methods=['GET', 'POST'])
def edit_well(id):
    WellForm = model_form(Well, Form)
    model = Well.get(id)
    if request.method == "POST":
        form = WellForm(request.form, model)

        if form.validate_on_submit():
            form.populate_obj(model)
            model.put() 
            return redirect(url_for("well-list"))
        return render_template('edit-well.html', form=form)
    else:
        form = WellForm(request.POST, model)
        return render_template('edit-well.html', form=form)
        
@app.route('/reports', methods=['GET'])
def reports():
    return render_template('reports.html')

@app.route('/map-feed', methods=['GET'])
def get_map_data():
    #TestMapData = namedtuple('TestMapData', ['latitude', 'longitude', 
                        #'well_street_1', 'well_street_2'], verbose=True)
    
    entries = Well.query.filter(Well.longitude is not None 
                        and Well.latitude is not None).all()
    json_content = {"type" : "FeatureCollection", 
                    "features" : 
                    [
                        {"geometry" : 
                         {
                            "type" : "Point",
                            "coordinates" : [entry.longitude, entry.latitude]
                         },
                        "type" : "Feature",
                        "properties" : {"address" : "{0} {1} {2}".format(entry.well_street_1, 
                                                                    entry.well_street_2, entry.municipality.name) }
                        }
                    for entry in entries
                    ]
                    }
    return json.dumps(json_content)

@app.route('/upload-file', methods=['POST'])
def upload_file():
    return  None


@app.route('/reports/edit', methods=['GET', 'POST'])
def edit_report():
    return render_template('edit-report.html')

@app.route('/quality-measures', methods=['GET', 'POST'])
def edit_quality_measure_list():
    return render_template('edit-quality-measures.html')

