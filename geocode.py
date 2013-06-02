from database import db_session
from models import *
import urllib, json



wells = Well.query.filter(Well.well_street_1 is not None or Well.well_street_2 is not None,
                       Well.well_street_1 != '' or Well.well_street_2 != '',
                       Well.longitude is not None or Well.latitude is not None).all()
for well in wells:
    print("Geocoding {0}".format(well.id))
    parameters = urllib.urlencode({"address" : "{0} {1} {2} MA"
                                .format(well.well_street_1, well.well_street_2, well.municipality.name), 
                                'sensor' : 'false'})
    url = 'http://maps.googleapis.com/maps/api/geocode/json?{0}'.format(parameters)
    print("Geocoding {0}".format(url))
    response_content = urllib.urlopen(url).read() 
    response_json = json.loads(response_content)
    #response_json = {"results": [{"geometry" : {"location" : {"lng" : 5, "lat" : 5}}}]}

    longitude = response_json["results"][0]["geometry"]["location"]["lng"]
    latitude = response_json["results"][0]["geometry"]["location"]["lat"]
    #location = response_json["results"][0]["formatted_address"]

    well.latitude = latitude
    well.longitude = longitude
    db_session.commit()


db_session.remove()

