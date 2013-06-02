import flask, os, sys
from flask import Flask, request, json
sys.path.append('/var/services')
from dbmanager import DatabaseManager
import sys, json, logging
from crossdomain import *

logging.basicConfig(stream=sys.stderr)
dbmanager = DatabaseManager('localhost', 'policelog', 'mapping', 'mapuser1')
application = Flask(__name__)

@application.route("/")
def all_view():
    """ Return json-rendered content representing 
        all or one specific log entry in the database
    """
    if "address" in request.args:
        print(request.args)
        records = dbmanager.exec_query('''select time, description,
                                         count(RT.*) from log_entry LE inner join
                                          response_times RT on LE.logid = RT.logid
                                          where location = %s
                                          group by LE.logid
                                          order by LE.time desc''', 
                                        request.args['address'])
        print(records)
        if not records:
            return "No record found for address {0}".format(request.args['address'])
        else:
            json_content = [
                            {
                             "time" : str(record[0]),
                             "description" : record[1],
                             "num_responding" : record[2]}
                            for record in records
                           ]
            return json.dumps(json_content)
    else:
        log_entries = dbmanager.exec_query('''select location, longitude, 
                                                latitude, count(location) 
                                             from log_entry
                                             group by location, longitude, latitude''')
        json_content = {"type" : "FeatureCollection", 
                        "features" : 
                        [
                            {"geometry" : 
                             {
                                "type" : "Point",
                                "coordinates" : [entry[1], entry[2]]
                             },
                            "type" : "Feature",
                            "properties" : {"crime_count" : entry[3],
                                            "short_address" : entry[0][:entry[0].index(",")],
                                            "address" : entry[0]}
                            }
                        for entry in log_entries
                        ]
                        }
        return json.dumps(json_content)
        

    

    


