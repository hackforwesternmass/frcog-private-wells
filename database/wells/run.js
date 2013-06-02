// npm install csv
// sudo apt-get install postgresql-common
// sudo apt-get install libpq-dev
// npm install pg
// 
var util = require('util');
var fs = require('fs');

// http://www.adaltas.com/projects/node-csv/
var csv = require('csv');

// https://github.com/brianc/node-postgres
var pg = require('pg').native;


var conString = "tcp://crwpuwcgrodlii:tXiOYzbzVQJOlxVhyndPgt9Aof@ec2-23-21-130-168.compute-1.amazonaws.com/dcrmabu3rp1e14";

var client = new pg.Client(conString);
//hclient.connect();


var sql_insert = "INSERT INTO wells(dep_well_id, owner_name, owner_street_1, owner_street_2,owner_city, owner_state, owner_zip, well_street_1, well_street_2,latitude, longitude, total_depth, depth_to_bedrock, assessors_map,assessors_lot, boh_date_issued, boh_permit, comments, wc_date,firm, supervising_driller, field_notes, municipalities_id, well_types_id,created_on, created_by, modified_on, modified_by) VALUES (%s, ?, ?, ?,?, ?, ?, ?, ?,?, ?, ?, ?, ?,?, ?, ?, ?, ?,?, ?, ?, ?, ?,?, ?, ?, ?);";

/**
 * charlemont.csv
 * buckland.csv
 * gill.csv
 */

csv()
.from.path(__dirname+'/csv/ashfield.csv', {
  columns: true
})
.transform( function(row){


        console.log(util.format(sql_insert, row.WELL_ID));

/*        { WELL_ID: '\n',
            TOWN: null,
            STREET_NUMBER: null,
            STREET_NAME: null,
            LATITUDE: null,
            LONGITUDE: null,
            DATE_COMPLETE: null,
            WELL_TYPE: null,
            WORKPERFORMED: null,
            TOTAL_DEPTH: null,
            DEPTH_TO_BEDROCK: null,
            WATER_LEVEL: null
        }*/

   console.log("")

    console.log(row);
  return row;
})
.on('record', function(row,index){
  console.log('#'+index+' '+JSON.stringify(row));
})
.on('end', function(count){
  console.log('Number of lines: '+count);
})
.on('error', function(error){
  console.log(error.message);
});








/**
 *
 */

/*
var query = client.query("SELECT * FROM wells_types");

//can stream row results back 1 at a time
query.on('row', function(row) {
  console.log(row);
});

//fired after last row is emitted
query.on('end', function() { 
  client.end();
});

*/
