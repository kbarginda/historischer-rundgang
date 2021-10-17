require('dotenv').config();

const bodyParser = require("body-parser"); 
const express = require("express"); 
const app = express(); 

app.use(express.static(`${__dirname}/public`));

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());  
const { Pool } = require('pg'); 

const port = process.env.PORT;
const version = process.env.VERSION;

const pool = new Pool ({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_DATABASE,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD
});


// https://dzone.com/articles/cors-in-node
// CORS erlauben
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});


/*--------------------------------------------

SERVER: POIS

--------------------------------------------*/

//Get STANDARD-POIS
app.get('/getPOIs', async(req,res,next)=> {
  try{
    const query = "SELECT poi_name, plakat_nr, stadtteil, rundgang_name, ST_AsGeoJSON(punkt_geom) as punkt_geom FROM pois";
    let items = []; 

    const client = await pool.connect(); 
    const result = await client.query(query); 

    for (let row of result.rows) {
      items.push(feature_s(row)); 
    }
    //console.log(geojson(items));
    res.json(JSON.parse(geojson(items)));  
  }
  catch (err){
    next(err); 
  }
});


//Features STANDARD-POIS
function feature_s(row) {
  return `{"type": "Feature", 
  "properties": {
    "poi_name": "${row.poi_name}",
    "plakat_nr": ${row.plakat_nr},
    "stadtteil": "${row.stadtteil}",
    "rundgang_name": "${row.rundgang_name}"
  },
    "geometry":${row.punkt_geom}
  }`;
}


/*--------------------------------------------

GET CUSTOM-POIS 

--------------------------------------------*/

app.get('/getcustomPOIs', async(req,res,next)=> {
  try{
    const query = "SELECT id, poi_name, station_nr, stadtteil, added_by, ST_AsGeoJSON(punkt_geom) as punkt_geom FROM custom_poi";
    let items = []; 

    const client = await pool.connect(); 
    const result = await client.query(query); 

    for (let row of result.rows) {
      items.push(feature(row)); 
    }
    res.json(JSON.parse(geojson(items))); 
  }
  catch (err){
    next(err); 
  }
});


//Feature CUSTOM POIS
function feature(row) {
  return `{"type": "Feature", 
  "properties": {
    "id":"${row.id}",
    "poi_name": "${row.poi_name}",
    "station_nr": ${row.station_nr},
    "stadtteil": "${row.stadtteil}",
    "added_by": "${row.added_by}"
  },
  "geometry":${row.punkt_geom}
  }`;
}

//Create POI 
app.post('/createPOI', async(req, res, next)=> {
  try{
    const query = `INSERT INTO custom_poi
    (poi_name, station_nr, added_by, punkt_geom)
    VALUES (
      '${req.body.POIname}',
      ${req.body.stationNr},
      '${req.body.addedBy}',
      ST_PointFromText('POINT(${req.body.poiLong} ${req.body.poiLat})', 4326)
    );`;

    const client = await pool.connect(); 
    const result = await client.query(query);
    
    res.send("Datensatz wurde eingefügt")
  } catch(err) {
    res.send("Uh oh. Fehler!"); 
    next(err); 
  }
})

//Delete POI
app.post('/deletecustomPOI', async(req, res, next)=> {
  try{
    console.log("CALLING DELETE POI")
    const query = `DELETE FROM custom_poi
    WHERE id =${req.body.id};`; 

    const client = await pool.connect(); 
    const result = await client.query(query); 

    res.send("Datensatz wurde gelöscht");
  } catch (err) {
    res.send("Uh oh. Fehler!");
    next(err); 
  }
});

/*--------------------------------------------

SERVER: STRECKEN

--------------------------------------------*/

app.get('/getStrecken', async(req,res,next)=> {
    try{
      const query = "SELECT id, strecken_name, stadtteil, ST_AsGeoJSON(geom) as geom, add_by FROM strecken";
      let items = []; 
  
      const client = await pool.connect(); 
      const result = await client.query(query); 
  
      for (let row of result.rows) {
        items.push(feature_l(row)); 
      }
      res.json(JSON.parse(geojson(items))); 
    }
    catch (err){
      next(err); 
    }
  });
  
  
  //Features STRECKEN
  function feature_l(row) {
    return `{"type": "Feature", 
    "properties": {
      "id": "${row.id}",
      "strecken_name": "${row.strecken_name}",
      "stadtteil": "${row.stadtteil}",
      "add_by": "${row.add_by}"
    },
    "id": "${row.id}",
    "geometry": ${row.geom}
    }`;
  }

  //Create STRECKEN
  app.post('/createStrecke', async(req, res, next)=> {
    try{
      const query = `INSERT INTO strecken
      (strecken_name, stadtteil, add_by, geom)
      VALUES (
        '${req.body.strecken_name}',
        '${req.body.stadtteil}',
        '${req.body.add_by}',
        ST_GeomFromText('${req.body.geom}', 4326)
      );`;
  
      const client = await pool.connect(); 
      const result = await client.query(query);
      
      res.send("Datensatz wurde eingefügt")
    } catch(err) {
      res.send("Uh oh. Fehler!"); 
      next(err); 
    }
  });


  //Update Strecke
  app.post('/updateStrecke', async(req, res, next)=> {
    try{
      const query = `UPDATE strecken
      SET strecken_name = '${req.body.strecken_name}',
      add_by ='${req.body.add_by}',
      added = CURRENT_TIMESTAMP,
      stadtteil ='${req.body.stadtteil}',
      geom = ST_GeomFromText('${req.body.geom}', 4326)
      WHERE id = ${req.body.id};`;
  
      const client = await pool.connect(); 
      const result = await client.query(query);
      
      res.send("Datensatz wurde geändert")
    } catch(err) {
      res.send("Uh oh. Fehler!"); 
      next(err); 
    }
  })

 //Strecke löschen
 app.post('/deleteStrecke', async(req, res, next)=> {
  try{
    const query = `DELETE FROM strecken WHERE id = ${req.body.id};`;
    
    console.log(query); 
    
    const client = await pool.connect(); 
    const result = await client.query(query);
    
    res.send("Datensatz wurde gelöscht")
  } catch(err) {
    res.send("Uh oh. Fehler!"); 
    next(err); 
  }
})



/*--------------------------------------------

SERVER: RUNDGÄNGE

--------------------------------------------*/

  app.get('/getRundgang', async(req,res,next)=> {
    try{
      const query = "SELECT id, rundgang_name, stadtteil, ST_AsGeoJSON(poly_geom) as poly_geom, added_by FROM rundgang";
      let items = []; 
  
      const client = await pool.connect(); 
      const result = await client.query(query); 
  
      for (let row of result.rows) {
        items.push(feature_r(row)); 
      }
      res.json(JSON.parse(geojson(items))); 
    }
    catch (err){
      next(err); 
    }
  });
  
  
  //Features RUNDGÄNGE
  function feature_r(row) {
    return `{"type": "Feature", 
    "properties": {
      "id": "${row.id}",
      "rundgang_name": "${row.rundgang_name}",
      "stadtteil": "${row.stadtteil}",
      "added_by": "${row.added_by}"
    },
    "id": "${row.id}",
    "geometry": ${row.poly_geom}
    }`;
  }

  //Create RUNDGÄNGE
  app.post('/createRundgang', async(req, res, next)=> {
    try{
      const query = `INSERT INTO rundgang
      (rundgang_name, stadtteil, added_by, poly_geom)
      VALUES (
        '${req.body.rundgang_name}',
        '${req.body.stadtteil}',
        '${req.body.added_by}',
        ST_GeomFromText('${req.body.poly_geom}', 4326)
      );`;
  
      const client = await pool.connect(); 
      const result = await client.query(query);
      
      res.send("Datensatz wurde eingefügt")
    } catch(err) {
      res.send("Uh oh. Fehler!"); 
      next(err); 
    }
  })

  //Update Rundgang
  app.post('/updateRundgang', async(req, res, next)=> {
    try{
      console.log("inside try");
      console.log(req.body);
      const query = `UPDATE rundgang
      SET 
      rundgang_name = '${req.body.rundgang_name}',
      added_by = '${req.body.added_by}',
      stadtteil ='${req.body.stadtteil}',
      poly_geom = ST_GeomFromText('${req.body.poly_geom}', 4326)
      
      WHERE id = ${req.body.id};`;
      console.log("INSIDE UPDATE");
      console.log(req.body);

      const client = await pool.connect(); 
      const result = await client.query(query);
      
      res.send("Datensatz wurde geändert")
    } catch(err) {
      res.send("Uh oh. Fehler!"); 
      next(err); 
    }
  })

   //Update Rundgang
   app.post('/deleteRundgang', async(req, res, next)=> {
    try{
      const query = `DELETE FROM rundgang WHERE id = '${req.body.id}';`;
      
      console.log(query); 

      const client = await pool.connect(); 
      const result = await client.query(query);
      
      res.send("Datensatz wurde ggelöscht")
    } catch(err) {
      res.send("Uh oh. Fehler!"); 
      next(err); 
    }
  })


//Formattierung (GEOJSON)
function geojson(items) {
  return `{ "type":"FeatureCollection",
  "crs":{  
      "type":"name",
      "properties":{  
          "name":"urn:ogc:def:crs:OGC:1.3:CRS84"
      }
  },
  "features":[
      ${items.join()}
  ] }`;
}


//Listening...
app.listen(port, () => {
  console.log(`
      HH Rundgang-Server v${version} (PostgreSQL) listening on http://localhost:${port}
      DB_HOST  = ${process.env.DB_HOST}:${process.env.DB_PORT}
      DATABASE = ${process.env.DB_DATABASE}
  `);
});
