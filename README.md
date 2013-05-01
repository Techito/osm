OpenStreetMap
=============

This Vagrant image creates a dev environment to develop applications using    
Open Street Map, or to develop OSM itself.

This VM gives a complete OSM setup, excluding the full OSM data. It    
provides a very basic default dataset, so that global-level outlines can be    
provided without further downloads.


Key Components
==============

* **OSM Rails application**    
  'slippy map'    

* **Apache / mod-tile / renderd**    
  tile-server    

* **Mapnik**    
  tile-renderer    

* **PostgreSQL / PostGIS**    
  data-source to store the OSM dataset    

