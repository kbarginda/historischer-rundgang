# WebGIS Projekt 
 
Das Thema dieser WebGIS-Applikation ist „historische Rundgänge“. Hierbei handelt es sich hauptsächlich um die historischen Rundgänge und Sehenswürdigkeiten in Wandsbek und Umgebung. Der Grund hierfür ist, dass es sehr viele „unbekannte“ historische Orte und Sehenswürdigkeiten gibt, die durch „Hauptattraktionen“ wie z.B. das Hamburger Rathaus untergehen.

Innerhalb der Stadtteile Wandsbek und Eilbek gibt es mehrere rote und manchmal auch blaue Plakate, die die Geschichte des Ortes erläutern – z.B. wo jetzt ein Mehrfamilienhaus steht, stand früher ein Schloss. Die Rundgänge bzw. Plakate der einzelnen Orte werden von dem Bürgerverein Wandsbek gepflegt. Ihre Geschichte und Route ist auch auf der Webseite vom Mühlenbek Verlags weiter zu verfolgen.

# Aufbau
## Homepage

Startseite der WebGIS Applikation. Hier sind die Standard-POIs (blau), selbstdefinierte POIs (lila), Strecken (gelb) und Rundgänge (orange) zu sehen.

<img width="630" alt="Bildschirmfoto 2021-10-17 um 19 55 09" src="https://user-images.githubusercontent.com/22305662/137639103-43ddbd46-c522-48c6-bb66-0ab8bc653916.png">

**Menüsektionen:**
1. "Über diese Webseite": kurz Einleitung + Themadarsetllung 
2. "Historische Rundgänge": weitere Infos über die Gesichte von Wandsbek und den Rundgängen 
3. "POI-Manager": Verwaltung von POIs (Punkte), die gespeichert werden sollen
4. "Routenmanger": Verwaltung von Routen (Rundgänge)
5. "Streckenmanager": Verwaltung von Strecken
6. "Probleme Melden": Fehlermeldung. Benutzt eine mailto: Methode

## POIS, Strecken und Rundgänge

### Pop-Ups

Wenn auf einen Punkt, Rundgang oder Strecke geklickt wird, werden die folgende Popups angezeigt:

<img width="238" alt="Bildschirmfoto 2021-10-17 um 19 54 17" src="https://user-images.githubusercontent.com/22305662/137639130-97aa39c2-9675-4820-a987-bed5c8add181.png">

Rundgänge sind nicht gleich Strecken! Rundgänge werden als Polygon gespeichert, Strecken als Linestring! Strecken und Rundgänge können gespeichert, geändert oder gelöscht werden (siehe Bild, unten).

<img width="482" alt="Bildschirmfoto 2021-10-17 um 19 57 18" src="https://user-images.githubusercontent.com/22305662/137639178-2fea3b9f-e813-4ead-9b7c-cd7aae7e71b6.png">

### POIS, Strecken und Rundgänge hinzufügen
<img width="416" alt="Bildschirmfoto 2021-10-17 um 19 53 41" src="https://user-images.githubusercontent.com/22305662/137639052-42ba0f43-1fb2-4b07-b1a7-5a558fcb86a0.png">

## Datenbankaufbau

### PostgreSQL Tabellen
<img width="704" alt="Bildschirmfoto 2021-10-17 um 19 54 53" src="https://user-images.githubusercontent.com/22305662/137639454-3cfd5351-d723-483b-9791-764368bcc344.png">
