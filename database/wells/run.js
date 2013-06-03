// npm install csv
// sudo apt-get install postgresql-common
// sudo apt-get install libpq-dev
// npm install pg
// 
var util = require('util');
var fs = require('fs');

// http://www.adaltas.com/projects/node-csv/
var csv = require('csv');

// delete out file
var outfile = 'wells_insert.sql';

fs.unlink(outfile, function (err) {
    //if (err) throw err;
    console.log('successfully deleted ' + outfile);
});

var towns = ['buckland', 'charlemont', 'gill'];

function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}

function varchar(str, len) {
    var value = '';

    if (isBlank(str)) {
        return 'null';
    } else {
        value =  str.replace(/'/g, "").replace(/"/g, "");
    }

    if(len) {
        value = value.substring(0, len);
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

function mapMuni(str) {
    if (str.toUpperCase() === 'GILL') return 109;
    else if (str.toUpperCase() === 'BUCKLAND') return 48;
    else if (str.toUpperCase() === 'CHARLEMONT') return 54;
}

var sql_insert = "INSERT INTO wells_well (" +
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
        "modified_by) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);";


var sqlFile = fs.createWriteStream(outfile, {
    flags: "a",
    encoding: "encoding",
    mode: 0744
})

for (var i = 0 ; i < towns.length ; i++) {
    extract(towns[i]);
}

function extract(town) {

    csv()
    .from.path(__dirname+'/csv/'+town+'.csv', {
      columns: true
    })
    .transform( function(row){

            var statement = util.format(sql_insert,
                integer(row.WELL_COMPLETION_ID),
                varchar(row.PROPERTY_OWNER, 100),
                varchar(row.OWNER_STREET_NUMBER, 100),
                varchar(row.OWNER_STREET_NAME, 100),
                varchar(row.OWNER_CITY, 100),
                varchar(''),
                varchar(''),
                varchar(row.WELL_STREET_NUMBER, 100),
                varchar(row.WELL_STREET_NAME, 100),
                float(row.LATITUDE),
                float(row.LONGITUDE),
                integer(row.WC_DEPTH),
                integer(row.DEPTH_TO_BEDROCK),
                varchar(row.ASSESSORS_MAP, 10),
                varchar(row.ASSESSORS_LOT, 10),
                date(row.BOH_DATE_ISSUED),
                varchar(row.BOH_PERMIT, 100),
                varchar(row.COMMENTS, 100),
                date(row.WC_DATE),
                varchar(row.FIRM, 100),
                varchar(row.SUPERVISING_DRILLER, 100),
                varchar(''),
                mapMuni(town),
                2,
                1,
                1);

    sqlFile.write(statement + '\n');
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

}