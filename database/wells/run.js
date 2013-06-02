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

String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g, '');};

function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}

function varchar(str) {
    var value = '';

    if (isBlank(str)) {
        value = '';
    } else {
        value =  str.replace(/'/g, "").replace(/"/g, "");
    }

    return  "'" + value + "'";
}

function date(str) {
    return 'null';
}

function float(str) {
    return (str != null && str !== '') ? str : 'null';
}

function integer(str) {
    return (str != null && str !== '') ? str : 'null';
}

var sql_insert = "INSERT INTO wells(" +
    "dep_well_id, " +
    "owner_name, " +
    "owner_street_1, " +
    "owner_street_2," +
    "owner_city, " +
    "owner_state, " +
    "owner_zip, " +
    "well_street_1," +
    "well_street_2," +
    "latitude," +
    "longitude," +
    "total_depth," +
    "depth_to_bedrock," +
    "assessors_map," +
    "assessors_lot," +
    "boh_date_issued," +
    "boh_permit," +
    "comments, " +
    "wc_date," +
    "firm," +
    "supervising_driller," +
    "field_notes," +
    "municipalities_id," +
    "well_types_id," +
    "created_by," +
        "modified_by) VALUES (%s, %s, %s, %s,%s, %s, %s, %s, %s,%s,%s, %s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);";

/**
 * charlemont.csv
 * buckland.csv
 * gill.csv
 */

csv()
.from.path(__dirname+'/csv/gill.csv', {
  columns: true
})
.transform( function(row){

        var statement = util.format(sql_insert,
            integer(row.WELL_COMPLETION_ID),
            varchar(row.PROPERTY_OWNER),
            varchar(row.OWNER_STREET_NUMBER),
            varchar(row.OWNER_STREET_NAME),
            varchar(row.OWNER_CITY),
            varchar(''),
            varchar(''),
            varchar(row.WELL_STREET_NUMBER),
            varchar(row.WELL_STREET_NAME),
            float(row.LATITUDE),
            float(row.LONGITUDE),
            varchar(row.WC_DEPTH),
            integer(row.DEPTH_TO_BEDROCK),
            varchar(row.ASSESSORS_MAP),
            varchar(row.ASSESSORS_LOT),
            varchar(row.BOH_DATE_ISSUED),
            varchar(row.BOH_PERMIT),
            varchar(row.COMMENTS),
            date(row.WC_DATE),
            varchar(row.FIRM),
            varchar(row.SUPERVISING_DRILLER),
            varchar(''),
            109,
            2,
            1,
            1);

        /*
        * //{ WELL_COMPLETION_ID: '282860',
         // WELL_LOCATION: '',
         // WELL_STREET_NUMBER: '',
         // WELL_STREET_NAME: 'West Gill Road',
         // TOWN_NAME: 'Gill',
         // PROPERTY_OWNER: 'Robert Whitney',
         // WELL_SUB_NAME: '',
         // OWNER_ADDRESS: '',
         // OWNER_STREET_NUMBER: '',
         // OWNER_STREET_NAME: '',
         // OWNER_CITY: 'Gill',
         // ASSESSORS_LOT: '',
         // ASSESSORS_MAP: '',
         // BOH_DATE_ISSUED: '',
         // DEPTH_TO_BEDROCK: '12',
         // BOH_PERMIT: 'NR',
         // WC_DATE: '22-Jul-74',
         // COMMENTS: 'Steel Casing Type actually 19.45 pounds.',
         // FIRM: 'Stavens Brothers, Inc.',
         // WELLTYPE: 'DMST',
         // SUPERVISING_DRILLER: 'Robert C. Stavens',
         // WC_DEPTH: '210',
         // LATITUDE: '',
         // LONGITUDE: '',
         LATD: '',
         LATM: '',
         LONGD: '',
         LONGM: '',
         WELL_LOT_NUM: '' }

         * */
  console.log(statement);

})
.on('record', function(row, index){
  console.log(row);
})
.on('end', function(count){
  //console.log('Number of lines: '+count);
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
