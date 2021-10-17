var draw, snap, modify; //globale Variablen 

/* --------------------------------------------

Layers für: 

POI

RUNDGANG

STRECKEN

-------------------------------------------- */ 

var feature_c = new ol.Feature();
var pointSource_c = new ol.source.Vector();

var pointLayer_c = new ol.layer.Vector
({
	visible: true,
	source: pointSource_c,
	style: styleCustomPoi
});
map.addLayer(pointLayer_c);


var feature_r = new ol.Feature();
var pointSource_r = new ol.source.Vector();

var pointLayer_r = new ol.layer.Vector
({
	visible: true,
	source: pointSource_r,
	style: styleRundgang
});
map.addLayer(pointLayer_r);

var feature_s = new ol.Feature();
var pointSource_s = new ol.source.Vector();

var pointLayer_s = new ol.layer.Vector
({
	visible: true,
	source: pointSource_s,
	style: styleStrecke
});
map.addLayer(pointLayer_s);





/* --------------------------------------------

Menüpunkte: POI

-------------------------------------------- */ 

$('#stopPoi').click(function() 
{
	// ENABLE andere Menüpunkte 
  $('#poiDraw').attr('disabled', false);
  $('#Deletepoi').attr('disabled', false);
  $('#Deletepoi')

  removeInteractions();
  pointSource_c.clear();
});

$('#poiDraw').click(function()
{
  $('#Deletepoi').attr('disabled', false);
  
  removeInteractions(); 
  clearForm_poi(); 
  createpoi(); 
}); 


$('#Deletepoi').click(function() 
{	
  removeInteractions();
});


/*--------------------------------------------

Funktion POI erstellen 

--------------------------------------------*/ 
function createpoi()
{
  draw = new ol.interaction.Draw
  ({
    source: pointSource_c,
    type: 'Point'
  });
  map.addInteraction(draw); 

	draw.on('drawend', function(e) 
	{
		map.removeInteraction(draw);
		
		var f = e.feature;
		var g = f.getGeometry();

		var coord4326 = ol.proj.transform(g.getCoordinates(), 'EPSG:3857', 'EPSG:4326');

		$('#poiLong').val(ol.coordinate.format(coord4326, '{x}', 6));
		$('#poiLat').val(ol.coordinate.format(coord4326, '{y}', 6));
	}, this);
}

/*
--------------------------------------------
Funktion: AJAX POI ERSTELLEN
--------------------------------------------
*/ 
$('#createPOI').click(function(e)
{
    e.preventDefault(); // no reload

    var url; 
    url = '/createPOI'; 

    var form_data = {}; 
    form_data.POIname = $('#POIname').val(); 
    form_data.stationNr = $('#stationNr').val(); 
    form_data.addedBy = $('#addedBy').val(); 
    form_data.poiLong = $('#poiLong').val(); 
    form_data.poiLat = $('#poiLat').val(); 

    console.log(form_data);
    $.ajax({
		type: 'POST',
		url: url,
		data: form_data
	}).done(function(response) 
	{
    console.log("Daten wurden gespeichert"); 
    console.log(response);
	}).fail(function() 
	{
		console.log("FEHLER");
    });
})


/*
--------------------------------------------
Funktion: AJAX POI löschen
--------------------------------------------
*/ 
function poiDelete(f) 
{
  content.innerHTML = "<img src='/images/icon_24.png'>" + "<br>" +
						"POI: " + feature.get("poi_name") + "<br>" + "Station: " +
						feature.get("station_nr") + "<br>" + "Hinzugefügt von: " + feature.get("added_by") + "<br>" +
						"<p>Soll dieser POI gelöscht werden?</p>" +
						"<button type='button' class='btn btn-primary' id='Deletepoi'>Löschen</button>&nbsp;" +
						"<button type='button' class='btn btn-primary' id='poiAbbruch'>Doch nicht...</button>";
  overlay.setPosition(f.getGeometry().getCoordinates());

  $('#Deletepoi').click(function() 
  {
		$.ajax({
			type: 'POST',
			url: '/deletecustomPOI',
			data: "id=" + f.get('id')
		}).done(function(response) 
		{
      	console.log("Daten wurden gelöscht"); 
      	console.log(response);
		}).fail(function(response) 
		{
      	console.log("FEHLER"); 
      	console.log(response);
    });
    
		lyrCustomPoi.getSource().removeFeature(f);

		// Popup schließen
		overlay.setPosition(undefined);
		closer.blur();
	});

	$('#poiAbbruch').click(function() 
	{
		// Popup schließen
		overlay.setPosition(undefined);
		closer.blur();
  	});
}

/* --------------------------------------------

Menüpunkte: RUNDGANG

-------------------------------------------- */ 

$('#stopRundgang').click(function()
{

	$('#rundgangDraw').attr('disabled', false); 
	$('#rundgangModify').attr('disabled', false);
	$('#rundgangDelete').attr('disabled', false);

	removeInteractions(); 
	pointSource_r.clear(); //clear Rundgang
});

$('#rundgangDraw').click(function()
{
	$('#rundgangModify').attr('disabled', false);
	$('#rundgangDelete').attr('disabled', false);
	//removeInteractions(); 
	clearForm_rundgang();
	createRundgang(); 
});

$('#rundgangModify').click(function()
{
	$('#rundgangDraw').attr('disabled', false);
	$('#rundgangDelete').attr('disabled', false);
	
	clearForm_rundgang();
	//removeInteractions(); 
	rundgang_modify(); 
});

$('#rundgangDelete').click(function()
{
	$('#rundgangDraw').attr('disabled', false);
	$('#rundgangModify').attr('disabled', false);
	removeInteractions(); 
});



/* --------------------------------------------

RUNDGANG ERSTELLEN

--------------------------------------------*/ 

function createRundgang(){
	console.log("inside create rundgang()");
	draw = new ol.interaction.Draw({
		source: pointSource_r,
		type: 'Polygon'
	});
	map.addInteraction(draw); 

	draw.on('drawend', function(e)
	{
		map.removeInteraction(draw);

		var f = e.feature; 

		let formatWKT = new ol.format.WKT();
		let featureWKT = formatWKT.writeFeature(f, 
		{
			dataProjection: 'EPSG:4326',
			featureProjection: 'EPSG:3857',
			rightHanded: true,
			decimals: 6
		});
		$('#poly_geom').val(featureWKT);
	}, this);


	modify = new ol.interaction.Modify({source: pointSource_r});
	map.addInteraction(modify); 

	modify.on('modifyend', function(e)
	{
		let features = e.features; 
		let f = features.item(0); 

		let formatWKT = new ol.format.WKT(); 
		
		let featureWKT = formatWKT.writeFeature(f, 
		{
			dataProjection: 'EPSG:4326',
            featureProjection: 'EPSG:3857',
			rightHanded: true,
            decimals: 6
        });
        $('#poly_geom').val(featureWKT);
	});
};

/* --------------------------------------------

RUNDGANG MODIFY

-------------------------------------------- */ 

function rundgang_modify(){
	modify = new ol.interaction.Modify
	({
		source: srcRundgang
	});

	rundgangChangeInteraction(); 

	modify.on('modifyend', function(e){
		let feature = undefined;
		for (let f of e.features.getArray()){

			if (id === f.getId())
			{
				feature = f;
			}
		}

		let formatWKT = new ol.format.WKT(); 
		let featureWKT = formatWKT.writeFeature(feature, 
			{
				dataProjection: 'EPSG:4326',
				featureProjection: 'EPSG:3857',
				rightHanded: true,
				decimals: 6
			});
			$('#poly_geom').val(featureWKT);	
	});
};

/* --------------------------------------------

RUNDGANG ERSTELLEN

-------------------------------------------- */ 

$('#createRundgang').click(function(e)
{
    e.preventDefault(); // no reload

    var url; 
    if ( $('#rundgangDraw').is(':checked')){

		url = '/createRundgang';
	}
	else if ( $('#rundgangModify').is(':checked')) {
		url = '/updateRundgang'; 
	}

	var form_data = {}; 

    form_data.rundgang_name = $('#rundgang_name').val(); 
    form_data.stadtteil = $('#stadtteil').val(); 
    form_data.added_by = $('#added_by').val(); 
    form_data.poly_geom = $('#poly_geom').val(); 
	
	if ($('#rundgangModify').is(':checked')){
		form_data.id = id; 
	}
    console.log(form_data);
    $.ajax({
		type: 'POST',
		url: url,
		data: form_data
	}).done(function(response) 
	{
    console.log("Daten wurden gespeichert"); 
    console.log(response);
	}).fail(function() 
	{
		console.log("FEHLER");
	});
	
	if ($('#rundgangDraw').is(':checked'))
	{
		let features = [];
		pointSource_r.forEachFeature(f => {
			features.push(f); 
		});
		let f = features[0]; 

		f.setProperties({
			'rundgang_name': $('#rundgang_name').val(),
			'stadtteil': $('#stadtteil').val()
		});
		f.setId($('#rundgang_name').val());
	

		lyrRundgang.getSource().addFeature(f); 
		srcRundgang.clear(); 
	}

	if ( $('#rundgangModify').is(':checked') ) 
	{
		// ... werden die geänderten Formulardaten in das Feature geschrieben.
		feature_r.setProperties({
			'rundgang_name': $('#rundgang_name').val()
		});
	}

	removeInteractions(); 
	
})

/* --------------------------------------------

Menüpunkte STRECKEN

-------------------------------------------- */ 
$('#stopStrecken').click(function()
{
	$('#streckenDraw').attr('disabled', false); 
	$('#streckenModify').attr('disabled', false);
	$('#streckenDelete').attr('disabled', false);

	removeInteractions(); 
	pointSource_s.clear(); //clear Strecken
});

$('#streckenDraw').click(function()
{
	$('#streckenModify').attr('disabled', false);
	$('#streckenDelete').attr('disabled', false);
	
	clearForm_strecken();
	//removeInteractions(); 
	createStrecke(); 
});

$('#streckenModify').click(function()
{
	$('#streckenDraw').attr('disabled', false);
	$('#streckenDelete').attr('disabled', false);
	
	clearForm_strecken();
	//removeInteractions(); 
	strecke_modify(); 
});

$('#streckenDelete').click(function()
{
	$('#streckenDraw').attr('disabled', false);
	$('#streckenModify').attr('disabled', false);
	
	removeInteractions(); 
});






/* --------------------------------------------

AJAX : STRECKE ERSTELLEN 

--------------------------------------------*/ 

function createStrecke(){
	
	draw = new ol.interaction.Draw({
		source: pointSource_s,
		type: 'LineString'
	});
	map.addInteraction(draw); 

	draw.on('drawend', function(e)
	{
		map.removeInteraction(draw);

		var f = e.feature; 

		let formatWKT = new ol.format.WKT();
		let featureWKT = formatWKT.writeFeature(f, 
		{
			dataProjection: 'EPSG:4326',
			featureProjection: 'EPSG:3857',
			rightHanded: true,
			decimals: 6
		});
		$('#geom').val(featureWKT);
	}, this);

	modify = new ol.interaction.Modify({source: pointSource_s});
	map.addInteraction(modify); 

	modify.on('modifyend', function(e)
	{
		let features = e.features; 
		let f = features.item(0); 

		let formatWKT = new ol.format.WKT(); 
		
		let featureWKT = formatWKT.writeFeature(f, 
		{
			dataProjection: 'EPSG:4326',
            featureProjection: 'EPSG:3857',
			rightHanded: true,
            decimals: 6
        });
        $('#geom').val(featureWKT);
	});
}

function strecke_modify(){
	modify = new ol.interaction.Modify
	({
		source: srcStrecke
	});

	streckenChangeInteraction(); 

	modify.on('modifyend', function(e){
		let feature = undefined;
		for (let f of e.features.getArray()){

			if (id == f.getId())
			{
				feature = f;
			}
		}

		let formatWKT = new ol.format.WKT(); 
		let featureWKT = formatWKT.writeFeature(feature, 
			{
				dataProjection: 'EPSG:4326',
				featureProjection: 'EPSG:3857',
				rightHanded: true,
				decimals: 6
			});
			$('#geom').val(featureWKT);	
	});
}

$('#createStrecke').click(function(e)
{
    e.preventDefault(); // no reload

    var url; 

	if ($('#streckenDraw').is(':checked')){
		url = '/createStrecke'; 
	}
	else if ($('#streckenModify').is(':checked')){
		url = '/updateStrecke';
	}

	var form_data = {}; 
	if ($('#streckenModify').is(':checked')){
		form_data.id = id; 
	}
    form_data.strecken_name = $('#strecken_name').val(); 
    form_data.stadtteil = $('#stadtteil').val(); 
    form_data.add_by = $('#add_by').val(); 
    form_data.geom = $('#geom').val(); 

    console.log(form_data);
    $.ajax({
		type: 'POST',
		url: url,
		data: form_data
	}).done(function(response) 
	{
    console.log("Daten wurden gespeichert"); 
    console.log(response);
	}).fail(function() 
	{
		console.log("FEHLER");
	});
	
	if ($('#streckenDraw').is(':checked'))
	{
		let features = [];
		pointSource_s.forEachFeature(f => {
			features.push(f); 
		});
		let f = features[0]; 

		f.setProperties({
			'strecken_name': $('#strecken_name').val(),
			'stadtteil': $('#stadtteil').val()
		});
		f.setId($('#id').val());
	

		lyrStrecke.getSource().addFeature(f); 
		srcStrecke.clear(); 
	}

	if ( $('#streckenModify').is(':checked') ) 
	{
		feature_r.setProperties({
			'strecken_name': $('#strecken_name').val()
		});
	}

	removeInteractions(); 
	
})




/* --------------------------------------------

AJAX : RUNDGANG LÖSCHEN

--------------------------------------------*/ 

function removeRundgang(f){

	content.innerHTML = "<img src='/images/rundgang50.png'>"+ "<br>" + "Rundgang: " + f.get("rundgang_name") + "<br>" +
	"Hinzugefügt von: " + f.get("added_by") + "<br>" +
	"<p>Möchten Sie diesen Rundgang <i>wirklich</i> löschen?</p>" +
	"<button type='button' class='btn btn-primary' id='rundgangDelete_btn'>Löschen</button>&nbsp;" +
	"<button type='button' class='btn btn-primary' id='rundgangAbbruch'>Doch nicht...</button>";
overlay.setPosition(f.getGeometry().getCoordinates()[0]);


	$('#rundgangDelete_btn').click(function()
	{
	console.log("AJAX rundgang")
	$.ajax({
		type: 'POST',
		url: '/deleteRundgang',
		data: "id=" + f.get('id')
	}).done(function(response){
		console.log("Daten wurden gelöscht!");
		console.log(response);
	}).fail(function(response){
		console.log("Fehler!");
		console.log(response); 
	});

	lyrRundgang.getSource().removeFeature(f);

	overlay.setPosition(undefined);
	closer.blur(); 
	});
	
	$('#rundgangAbbruch').click(function() 
	{
		console.log("Abbruch")
		overlay.setPosition(undefined);
		closer.blur(); 
	});
}


/* --------------------------------------------

Pop-up STRECKEN

--------------------------------------------*/ 





/* --------------------------------------------

AJAX : STRECKE LÖSCHEN

--------------------------------------------*/ 

function removeStrecke(f){

		content.innerHTML = "<img src='/images/strecke50.png'>"+ "<br>" + "Strecke: " + f.get("strecken_name") + "<br>" +
		"Hinzugefügt von: " + f.get("add_by") + "<br>" +
		"<p>Möchten Sie diese Strecke <i>wirklich</i> löschen?</p>" +
		"<button type='button' class='btn btn-primary' id='streckenDelete_btn'>Löschen</button>&nbsp;" +
		"<button type='button' class='btn btn-primary' id='streckeAbbruch'>Doch nicht...</button>";
	overlay.setPosition(f.getGeometry().getCoordinates()[0]);
	
	
		$('#streckenDelete_btn').click(function()
		{
			$.ajax({
			type: 'POST',
			url: '/deleteStrecke',
			data: "id=" + f.get('id')
		}).done(function(response){
			console.log("Daten wurden gelöscht!");
			console.log(response);
		}).fail(function(response){
			console.log("Fehler!");
			console.log(response); 
		});
	
		lyrStrecke.getSource().removeFeature(f);
	
		overlay.setPosition(undefined);
		closer.blur(); 
		});
		
		$('#streckenAbbruch').click(function() 
		{
			console.log("Abbruch")
			overlay.setPosition(undefined);
			closer.blur(); 
		});
}
	






/* --------------------------------------------

EVENTHANDLER POPUPS

--------------------------------------------*/ 
map.on('click', function(e) 
{

	feature = map.forEachFeatureAtPixel(e.pixel, function(feature, layer) 
	{
		try 
		{
			feature.layerId = layer.get("id");
			return feature;
		} catch(err) { }
	});
	
	if (feature) 
	{
		/* 

		POPUP für selbstdefinierte POIs 

		*/
		
		if (feature.layerId == "customPOI") 
		{
		    content.innerHTML = "<img src='/images/icon_24.png'>" + "<br>" +
									feature.get("poi_name") + "<br>" + "Station: " +
									feature.get("station_nr") + "<br>" + "Hinzugefügt von: " + feature.get("added_by");
        overlay.setPosition(e.coordinate);

		if ($('#poiDelete').is(':checked')) 
		{
		  poiDelete(feature); 
        }
	  }
	  
     	/* 

		POPUP für Standard-POIs. Diese POIs können nicht gelöscht werden. 

		*/

		if (feature.layerId == "standardPOI")
		{
		content.innerHTML = "<img src='/images/icon_24.png'>" +"<br>"+
						feature.get("poi_name") + "<br>" + "PlakatNr.: " +
						feature.get("plakat_nr") + "<br>" + "Rundgang: " + feature.get("rundgang_name");
			overlay.setPosition(e.coordinate);
		}

		/* 

		POPUP für Rundgänge

		*/

		if (feature.layerId == "id_Rundgang")
		{
			content.innerHTML = "<img src='/images/rundgang50.png'>" +"<br>"+
			feature.get("rundgang_name") + "<br>" + "Stadtteil: " +
			feature.get("stadtteil") + "<br>" + "Hinzugefügt von: " + feature.get("added_by");
			overlay.setPosition(e.coordinate);

			if ($('#rundgangDelete').is(':checked')) 
			{
			removeRundgang(feature); 
			}
		}	

		/* 

		POPUP für Strecken

		*/

		if (feature.layerId == "id_Strecke")
		{
			content.innerHTML = "<img src='/images/strecke50.png'>" +"<br>"+
			feature.get("strecken_name") + "<br>" + "Stadtteil: " +
			feature.get("stadtteil") + "<br>" + "Hinzugefügt von: " + feature.get("add_by");
			overlay.setPosition(e.coordinate);
			
			if ($('#streckenDelete').is(':checked')) 
			{
				removeStrecke(feature); 
			}
		}
	}

	removeInteractions(); 
});


/* --------------------------------------------

Funktionen

--------------------------------------------*/


function streckenUpdate(f) {
	let coordinate = f.getGeometry().getCoordinates(); 
	$('#id').val(f.get('id'));
	$('strecken_name').val(f.get('name')); 

	modify.on('modifyend', function(e){
		streckenUpdate(f);
	})
}
 
function removeInteractions() 
{
	map.removeInteraction(draw);
	map.removeInteraction(snap);
	map.removeInteraction(modify);
}

function clearForm_poi() 
{
	$('#POIname').val('');
	$('#stationNr').val('');
	$('#addedBy').val('');
	$('#poiLong').val('');
	$('#poiLat').val('');
}

function clearForm_rundgang()
{
	$('#rundgang_name').val('');
	$('#stadtteil').val('');
	$('#added_by').val('');
	$('#poly_geom').val('');
}

function clearForm_strecken()
{
	$('#strecken_name').val('');
	$('#stadtteil').val('');
	$('#add_by').val('');
	$('#geom').val('');
}

//RUNDGANG
let select = null; // ref to currently selected interaction

let selectClick = new ol.interaction.Select({
	condition: ol.events.condition.click,
	layers: [lyrRundgang]
});
let styleSelected = new ol.style.Style({
    stroke: new ol.style.Stroke({
		lineDash: [10, 20],
        width: 5,
		color: '#E67E22'
    })
});
let rundgangChangeInteraction = function () {
	if (select !== null) {
		map.removeInteraction(select);
	}

	select = selectClick;

	if (select !== null) {
		map.addInteraction(select);
		select.on('select', function (e) {
			if (e.selected.length > 0) {
				e.selected[0].setStyle(styleSelected);
				id = e.selected[0].getId();
				$('#id').val(id);
				$('#rundgang_name').val(e.selected[0].get('rundgang_name'));
				let formatWKT = new ol.format.WKT();
				let featureWKT = formatWKT.writeFeature(e.selected[0], {
					dataProjection: 'EPSG:4326',
					featureProjection: 'EPSG:3857',
					rightHanded: true,
					decimals: 6
				});
				$('#poly_geom').val(featureWKT);
				map.addInteraction(modify);
			} else {
				map.removeInteraction(null);
			}
		});
	}
};

//STRECKEN
let select_s = null; // ref to currently selected interaction
let selectClick_s = new ol.interaction.Select({
	condition: ol.events.condition.click,
	layers: [lyrStrecke]
});
let styleSelected_s = new ol.style.Style({
    stroke: new ol.style.Stroke({
		lineDash: [10, 20],
        width: 5,
		color: '#E67E22'
    })
});

let streckenChangeInteraction = function() {
	if (select_s !== null) {
		map.removeInteraction(select_s);
	}

	select_s = selectClick_s;

	if (select_s !== null) {
		map.addInteraction(select_s);
		select_s.on('select', function (e) {
			if (e.selected.length > 0) {
				e.selected[0].setStyle(styleSelected_s);
				id = e.selected[0].getId();
				$('#id').val(id);
				$('#strecken_name').val(e.selected[0].get('strecken_name'));
				let formatWKT = new ol.format.WKT();
				let featureWKT = formatWKT.writeFeature(e.selected[0], {
					dataProjection: 'EPSG:4326',
					featureProjection: 'EPSG:3857',
					rightHanded: true,
					decimals: 6
				});
				$('#geom').val(featureWKT);
				map.addInteraction(modify);
			} else {
				map.removeInteraction(null);
			}
		});
	}
};




/* --------------------------------------------

Pop-up Einstellungen

--------------------------------------------*/ 

//Pop-up Container
var container = document.getElementById('popup');
var content = document.getElementById('popup-content');
var closer = document.getElementById('popup-closer');


//Overlay für den Pop-up
var overlay = new ol.Overlay
({
		element: container,
		autoPan: true,
		autoPanAnimation: {
			duration: 250
		}
});
map.addOverlay(overlay);

// Pop-up schließen 
closer.onclick = function() 
{
	// Popup schließen
	overlay.setPosition(undefined);
	closer.blur();
	
	return false;
};


/* --------------------------------------------

Etc.

--------------------------------------------*/ 



map.updateSize();
