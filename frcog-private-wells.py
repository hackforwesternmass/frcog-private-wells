import os
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/map')
def map():
    return render_template('map.html')

@app.route('/wells')
def wells():
    return render_template('well-list.html')

@app.route('/wells/edit')
def edit_well():
    return render_template('edit-well.html')

@app.route('/reports')
def reports():
    return render_template('reports.html')

@app.route('/reports/edit')
def edit_report():
    return render_template('edit-report.html')

@app.route('/quality-measures')
def edit_quality_measure_list():
    return render_template('edit-quality-measures.html')
    

