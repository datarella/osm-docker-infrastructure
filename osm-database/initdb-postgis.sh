#!/bin/sh

set -e
set -x

# Perform all actions as user 'postgres'
export PGUSER=postgres

# Create extensions
psql <<EOSQL
CREATE EXTENSION hstore;
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION fuzzystrmatch;
EOSQL

# apt-get install -y net-tools
# netstat -anp | grep 5432

# import data
# osm2pgsql -d postgres -U postgres -H localhost -P 5432 -s --hstore /osm-data/munich_germany.osm

