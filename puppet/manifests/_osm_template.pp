# -*- mode: puppet -*-
# vi: set ft=puppet :

###
# Template for an OSM dev box.
###
node osm_template {

  ###
  # Sensible utilities.
  ###

  package { 'curl': }
  package { 'unzip': }
  package { 'vim': }
  package { 'vim-puppet': }
  package { 'git': }
  package { 'subversion': }
  package { 'gcc': }
  package { 'make': }



  ###
  # Rails port.
  ###
  
  # Precise: ruby-1.8.7.
  package {'ruby': }
  # Precise: rubygems-1.8.15
  package {'rubygems': }
  # Precise: PostgreSQL 9.1
  package {'postgresql': }

  package {'imagemagick': }
  package {'ruby-bundler': }

  # @TODO: Install bundler from LATEST rather than Ubuntu packages.
  # @see http://wiki.openstreetmap.org/wiki/Rails_port/Ubuntu
  # package {'osmosis': }


}
