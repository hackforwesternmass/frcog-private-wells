// This is the library for every Town spreadsheet
// If you change this, you need to choose File > Manage Versions and save a new version
// Then you need to go to each Town Spreadsheet and update the library version
//  Choose Resources > Libraries in the script editor for EVERY town spreadsheet
//  Update the version of FRCOG Library to the latest


// key needed for fusion tables api
var fusionTablesAPIKey = 'YOUR_API_KEY_HERE';

// the name of the range used in the program
var rangeName = 'updateFusion';

// create menu buttons
function onOpen() {
    var ss = SpreadsheetApp.getActiveSpreadsheet();
    var menuEntries = [{
    	name: "Update Fusion Table",
    	functionName: "updateFusion"
    }];
    ss.addMenu("Data Update Functions", menuEntries);
};

// main function
function updateFusion(tableIDFusion) {

    UserProperties.deleteAllProperties();

    var email = 'email@example.com';
    var password = '********';

    UserProperties.setProperty('email', email);
    UserProperties.setProperty('password', password);

	var authToken = getGAauthenticationToken(email, password);
	deleteData(authToken, tableIDFusion);

    var updatedRowsCount = updateData(authToken, tableIDFusion);
	SpreadsheetApp.getActiveSpreadsheet().toast("Updated " + updatedRowsCount + " rows in the Fusion Table", "Fusion Tables Update", 5)
};

// Google Authentication API this is taken directly from the google fusion api website
function getGAauthenticationToken(email, password) {
    password = encodeURIComponent(password);
    var response = UrlFetchApp.fetch("https://www.google.com/accounts/ClientLogin", {
        method: "post",
        payload: "accountType=GOOGLE&Email=" + email + "&Passwd=" + password + "&service=fusiontables&Source=testing"
    });

	var responseStr = response.getContentText();
	responseStr = responseStr.slice(responseStr.search("Auth=") + 5, responseStr.length);
	responseStr = responseStr.replace(/\n/g, "");
	return responseStr;
};

// query fusion API post
function queryFusionTables(authToken, query) {

    // location to send the infomation to
    var prefix = "https://www.googleapis.com/fusiontables/v1/query?key=";
    var suffix = fusionTablesAPIKey + '&';
    var URL = prefix + suffix;

    // sends the the authentication and the query in url format
    var response = UrlFetchApp.fetch(URL, {
        method: "post",
        headers: {
            "Authorization": "GoogleLogin auth=" + authToken,
        },
        payload: "sql=" + query
    });

    return response.getContentText();
};

// delete old data in fusion table
function deleteData(authToken, tableID) {
    var query = encodeURIComponent("DELETE FROM " + tableID);
    return queryFusionTables(authToken, query);
};

function insertIntoFusion(authToken, query)
{
  try {
      queryFusionTables(authToken, encodeURIComponent(query));
    } catch (e){
      Browser.msgBox("Import Error Detected.\nError:\n"+e.message);

      Logger.log("Import Errror Detected");
      Logger.log(e);
      Logger.log(query);
      return false;
    }
    return true;
}

// puts all the current information in the spreadsheet into a query
function updateData(authToken, tableID) {
    //find sheets with ranges that will be sent
    var ss = SpreadsheetApp.getActiveSpreadsheet();
    var range = ss.getDataRange();
    var data = range.getValues();
	var headers = data[0];

	var queryPrepend = "INSERT INTO " + tableID + " (" + headers.join(",") + ") VALUES ('";

    var query = "";
    var count = 0;
	for (var i = 1; i < data.length; ++i) {

	   if (typeof (data[i][0]) == "string" && data[i][0] == "" &&
           typeof (data[i][1]) == "string" && data[i][1] == "" &&
           typeof (data[i][2]) == "string" && data[i][2] == ""
          ) {
	       continue;
	   }

      for (var j=0; j<data[i].length; ++j) {
        if (typeof(data[i][j]) == "string") {
          data[i][j] = mysql_real_escape_string(data[i][j]);
        }
      }
      query += queryPrepend + data[i].join("','") + "'); ";
      if (i % 200 == 0) {
        if (! insertIntoFusion(authToken, query)) {
          return count;
        }
        count += 200;
        query = "";
      }
    }
  if (query != "") {
    if (!insertIntoFusion(authToken, query)) {
      return count;
    }
  }

	return data.length-1;
};

function mysql_real_escape_string (str) {
    return str.replace(/[\0\x08\x09\x1a\n\r"'\\\%]/g, function (char) {
        switch (char) {
            case "\0":
                return "\\0";
            case "\x08":
                return "\\b";
            case "\x09":
                return "\\t";
            case "\x1a":
                return "\\z";
            case "\n":
                return "\\n";
            case "\r":
                return "\\r";
            case "\"":
            case "'":
            case "\\":
            case "%":
                return "\\"+char; // prepends a backslash to backslash, percent,
                                  // and double/single quotes
        }
    });
}