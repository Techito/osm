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


  # The rails_port will be exported to /mnt/osm_project/rails_port by the
  # Vagrantfile.
  # Mount this to /srv/rails_port.
  file {'/srv/rails_port':
    ensure => 'directory',
  }
  mount {'/srv/rails_port':
    ensure => 'mounted',
    name => '/srv/rails_port',
    device => '/mnt/osm_project/rails_port',
    fstype => 'none',
    options => 'rw,bind',
    require => File['/srv/rails_port'],
  }

  # Populate rails_port/config/database.yml.
  #
  # The databases used are:
  # Dev:  openstreetmap
  # Test: osm_test
  # Prod: osm
  file {'/srv/rails_port/config/database.yml':
    ensure => 'file',
    source => '/srv/rails_port/config/example.database.yml',
    require => Mount['/srv/rails_port'],
  }

  # Populate rails_port/config/application.yml.
  file {'/srv/rails_port/config/application.yml':
    ensure => 'file',
    source => '/srv/rails_port/config/example.application.yml',
    require => Mount['/srv/rails_port'],
  }
  # @TODO: reconfigure the URL.


}
