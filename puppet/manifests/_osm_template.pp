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
  #   Dev:  openstreetmap
  #   Test: osm_test
  #   Prod: osm
  file {'/srv/rails_port/config/database.yml':
    ensure => 'file',
    source => '/srv/rails_port/config/example.database.yml',
    require => Mount['/srv/rails_port'],
  }
  # @TODO: create databases and populate DB credentials.

  # Populate rails_port/config/application.yml.
  file {'/srv/rails_port/config/application.yml':
    ensure => 'file',
    source => '/srv/rails_port/config/example.application.yml',
    require => Mount['/srv/rails_port'],
  }
  # @TODO: reconfigure the URL.



  ###
  # PostgreSQL configuration.
  ###

  # Create 'vagrant' superuser for easy access.
  exec {'createuser vagrant -s':
    user => 'postgres',
    path => '/usr/bin',
    # Only create the user if there isn't a vagrant user already.
    onlyif => "[ -z `psql -tqc \"SELECT rolname FROM pg_roles WHERE rolname='vagrant';\"` ]",
    require => Package['postgresql'],
  }

  # Create 'osm' user.
   exec {'createuser osm -RSd':
     user => 'postgres',
     path => '/usr/bin',
     # Only create the user if there isn't a vagrant user already.
     onlyif => "[ -z `psql -tqc \"SELECT rolname FROM pg_roles WHERE rolname='osm';\"` ]",
     require => Package['postgresql'],
   }

  # Create databases.
  #
  # The databases used are:
  #   Dev:  openstreetmap
  #   Test: osm_test
  #   Prod: osm
  exec {'createdb -O osm openstreetmap "OSM Dev database."':
    user => 'postgres',
    path => '/usr/bin',
    # Only create the DB if it doesn't already exist.
    onlyif => "[ -z `psql template1 -tqc \"SELECT 1 FROM pg_database WHERE datname='openstreetmap';\"` ]",
    require => [
      Package['postgresql'],
      Exec['createuser osm -RSd'],
    ],
  }
  exec {'createdb -O osm osm_test "OSM Test database."':
    user => 'postgres',
    path => '/usr/bin',
    # Only create the DB if it doesn't already exist.
    onlyif => "[ -z `psql template1 -tqc \"SELECT 1 FROM pg_database WHERE datname='osm_test';\"` ]",
    require => [
      Package['postgresql'],
      Exec['createuser osm -RSd'],
    ],
  }
  exec {'createdb -O osm osm "OSM Prod database."':
    user => 'postgres',
    path => '/usr/bin',
    # Only create the DB if it doesn't already exist.
    onlyif => "[ -z `psql template1 -tqc \"SELECT 1 FROM pg_database WHERE datname='osm';\"` ]",
    require => [
      Package['postgresql'],
      Exec['createuser osm -RSd'],
    ],
  }



}
