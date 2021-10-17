/*var map = new ol.Map({
	target: 'map',
	layers: [
		new ol.layer.Tile({
			title: 'OSM',
			type: 'base',
			visible: true,
			source: new ol.source.OSM()
		})
	],
	view: new ol.View({
		center: ol.proj.fromLonLat([10.0728, 53.568]),
		zoom: 15
	})
});
console.log(map); */

var map = new ol.Map({
	target: 'map',
	layers: [
		new ol.layer.Tile({
			title: 'OpenStreetMaps (Basislayer)',
			type: 'base',
			visible: true,
			source: new ol.source.OSM()
		})
	],
	view: new ol.View({
		center: ol.proj.fromLonLat([10.0728, 53.568]),
		zoom: 15
	})
});


const MapGroup = new ol.layer.Group({
	'title': 'maplayers',
		layers:[
				new ol.layer.Tile({
				name: "ÖPNV",
				id: 'OPNV',
				title: 'ÖPNV Layer',
				visible: true,
				source: new ol.source.XYZ
				({
					url: 'http://www.openptmap.org/tiles/{z}/{x}/{y}.png'
				})
			}),

			new ol.layer.Tile({
				name: "OpenStreetMapsBW",
				id: 'OSMbw',
				title: 'OpenStreetMaps (sw)',
				visible: false,
				source: new ol.source.XYZ
				({
					url: 'https://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png'
				})
			}),

			new ol.layer.Tile({
				name: "Nachtmodus",
				id: 'Kartedunkel',
				title: 'Nachtmodus Karte',
				visible: false,
				source: new ol.source.XYZ
				({
					url: 'http://b.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png'
				})
			})
		]
});
	
/*--------------------------------------------

Layer STANDARD-POIS

--------------------------------------------*/ 
var styleStandardPois = function(feature, resolution){
	var idx = feature.get('plakat_nr');
	var icon = '/images/circle20.png';
	var txt = resolution<3 ? feature.get('poi_name') : '';

	
	var styleCache = {};
	styleCache[idx] = [ new ol.style.Style({
		image: new ol.style.Icon({
			anchor: [0.5, 0.5],
			anchorXUnits: 'fraction',
			anchorYUnits: 'fraction',
			opacity: 1,
			src: icon
		}),
		text: new ol.style.Text({
			font: '14px Arial,sans-serif',
			text: txt,
			fill: new ol.style.Fill({
				color: '#35354F'
			}),
			stroke: new ol.style.Stroke({
				color: '#0000',
				width: 4
			})
		})
	})];
	return styleCache[idx];
}

var srcStandardPoi = new ol.source.Vector({
	url: '/getPOIs',
	format: new ol.format.GeoJSON()
});


var lyrStandardPoi = new ol.layer.Vector({
	title: 'StandardPoi',
	id: 'standardPOI',
	visible: true,
	source: srcStandardPoi,
	style: styleStandardPois
});

map.addLayer(lyrStandardPoi);




/*--------------------------------------------

Layer CUSTOM-POIs

--------------------------------------------*/ 
var styleCustomPoi = function(feature, resolution){
	var idx = feature.get('station_nr');
	var icon = '/images/c_circle20.png';
	var txt = resolution<3 ? feature.get('poi_name') : '';

	
	var styleCache = {};
	styleCache[idx] = [ new ol.style.Style({
		image: new ol.style.Icon({
			anchor: [0.5, 0.5],
			anchorXUnits: 'fraction',
			anchorYUnits: 'fraction',
			opacity: 1,
			src: icon
		}),
		text: new ol.style.Text({
			font: '14px Arial,sans-serif',
			text: txt,
			fill: new ol.style.Fill({
				color: '#35354F'
			}),
			stroke: new ol.style.Stroke({
				color: '#0000',
				width: 4
			})
		})
	})];
	return styleCache[idx];
}

var srcCustomPoi = new ol.source.Vector({
	url: '/getcustomPOIs',
	format: new ol.format.GeoJSON()
});


var lyrCustomPoi = new ol.layer.Vector({
	title: 'CustomPoi',
	id: 'customPOI',
	visible: true,
	source: srcCustomPoi,
	style: styleCustomPoi
});

map.addLayer(lyrCustomPoi);

/* --------------------------------------------------

Layer RUNDGANG

----------------------------------------------------*/


var styleRundgang = function(feature, resolution){
	var idx = feature.get('id');
	var icon = '/images/rundgang50.png';
	var txt = resolution<3 ? feature.get('rundgang_name') : '';

	
	var styleCache = {};
	styleCache[idx] = [ new ol.style.Style({
		text: new ol.style.Text({
			font: '14px Arial,sans-serif',
			text: txt,
			fill: new ol.style.Fill({
				color: '#35354F',
			}),
			stroke: new ol.style.Stroke({
				color: '#0000',
				width: 4,
			})
		}),
		stroke: new ol.style.Stroke({
			color: '#FF6347',
			  width: 3,
			  opacity: 0.7
		})
	})];
	return styleCache[idx];
}

var srcRundgang = new ol.source.Vector({
	url: '/getRundgang',
	format: new ol.format.GeoJSON()
});


var lyrRundgang = new ol.layer.Vector({
	title: 'Rundgang',
	id: 'id_Rundgang',
	visible: true,
	source: srcRundgang,
	style: styleRundgang
});

map.addLayer(lyrRundgang);

/* --------------------------------------------------

Layer STRECKE

----------------------------------------------------*/

var styleStrecke = function(feature, resolution){
	var idx = feature.get('id');
	var txt = resolution<4 ? feature.get('strecken_name') : '';
	
	var styleCache = {};
	styleCache[idx] = [ new ol.style.Style({
		text: new ol.style.Text({
			font: '14px Arial,sans-serif',
			text: txt,
			fill: new ol.style.Fill({
				color: '#35354F',
			}),
			stroke: new ol.style.Stroke({
				color: '#0000',
				width: 4,
			})
		}),
		stroke: new ol.style.Stroke({
			color: '#FFD700	',
			  width: 3,
			  opacity: 0.7
		})
	})
];
	return styleCache[idx];
}

var srcStrecke = new ol.source.Vector({
	url: '/getStrecken',
	format: new ol.format.GeoJSON()
});


var lyrStrecke = new ol.layer.Vector({
	title: 'Strecke',
	id: 'id_Strecke',
	visible: true,
	source: srcStrecke,
	style: styleStrecke
});

map.addLayer(lyrStrecke);
