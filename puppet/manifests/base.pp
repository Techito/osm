# -*- mode: ruby -*-
# vi: set ft=ruby :


# Load the global common configuration that all boxes use.
import "_common.pp"

# Load the template that declares all drupaldev boxes.
import "_osm_template.pp"

# Apply the OSM template.
node default inherits osm_template { }
