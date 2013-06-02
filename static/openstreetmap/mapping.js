var styleContext = {
    getStrokeOpacity: function(feature) {
        //return Math.min(feature.attributes["crime_count"] * 0.1, 1);
        return 0.4
    },
    getFillOpacity: function(feature) {
        //return Math.min(feature.attributes["crime_count"] * 0.1, 1);
        return 0.4
    },
};

var defaultStyle = new OpenLayers.Style({
        pointRadius: 10,
        strokeWidth: 3,
        strokeColor: "red",
        fillColor: "red",
        strokeOpacity: "${getStrokeOpacity}",
        fillOpacity: "${getFillOpacity}"
    }, {context: styleContext});

var hoverStyle = new OpenLayers.Style({
        strokeColor: "#ffff33",
        fillColor: "#ffff33",
    }, {context: styleContext});


var bounds = new OpenLayers.Bounds(-73.39, 42.86, -71.25, 42.86);

var projWGS84 = new OpenLayers.Projection("EPSG:4326");
var map = new OpenLayers.Map('map', { projection: projWGS84})

var geojson_layer = new OpenLayers.Layer.Vector("GeoJSON", {
            strategies: [new OpenLayers.Strategy.Fixed()],
            protocol: new OpenLayers.Protocol.HTTP({
                url: "/map-feed",
                format: new OpenLayers.Format.GeoJSON({
                    "internalProjection" : map.getProjectionObject(),
                    "externalProjection" : projWGS84
                    }),
            }),
            styleMap: new OpenLayers.StyleMap({"default" : defaultStyle,
                                               "hover" : hoverStyle
                                              })
       })

var layer = new OpenLayers.Layer.OSM("Simple OSM Map")

map.addLayers([layer, geojson_layer]);

function onHoverPopupClose(evt) {
    // 'this' is the popup
    var feature = this.feature;
    if (feature.layer) {
        hoverControl.unselect(feature);
    }  
    this.destroy();
}

function onDetailedPopupClose(evt) {
    var feature = this.feature;
    if (feature.layer) {
        selectControl.unselect(feature);
    }
    this.destroy();
    hoverControl.activate();
}

function onFeatureClickOut(feature) {
    feature.popup.destroy();
    selectControl.unselect(feature);
    hoverControl.activate();
}


function showFeatureInfo(evt) {
    feature = evt.feature;
    popup = new OpenLayers.Popup.Anchored("featurePopup",
            feature.geometry.getBounds().getCenterLonLat(),
            new OpenLayers.Size(200,100),
            "<h2>"+feature.attributes["address"]+ "</h2>",
            null, true, onHoverPopupClose);
    feature.popup = popup;
    popup.feature = feature;
    map.addPopup(popup, true);
    popupfeature = feature
}

function onFeatureUnselect(feature) {
    hoverControl.activate()
    map.removePopup(feature.popup);
}

var selectControl = new OpenLayers.Control.SelectFeature(geojson_layer, {
   clickout: true,
    onSelect: function(feature)  {
        $.getJSON(
        "/map-feed",
          { "address" : feature.attributes["address"]},
            function(data) {
                popupContent = "<h2>"+feature.attributes["address"]+ "</h2>"

                popup = new OpenLayers.Popup.Anchored("featurePopup",
                    feature.geometry.getBounds().getCenterLonLat(),
                    new OpenLayers.Size(400,200),
                    popupContent,
                    null, true, onDetailedPopupClose);
                feature.popup = popup;
                popup.feature = feature;

                map.addPopup(popup, true);
            });
        }
    });

map.addControl(selectControl);
selectControl.activate();

map.setCenter(
    new OpenLayers.LonLat(-72.71, 42.38).transform(
        projWGS84, map.getProjectionObject()), 
        9);
