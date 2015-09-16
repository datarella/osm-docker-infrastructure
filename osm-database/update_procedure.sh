#!/bin/bash

# download data
apt-get update
apt-get install --yes wget bzip2
wget -P /raw_data/ https://s3.amazonaws.com/metro-extracts.mapzen.com/munich_germany.osm.bz2
cd raw_data

# extract data
today=`date '+%Y_%m_%d'`
filebase="munich_germany_$today.osm"
filesuffix="bz2"
filename="$filebase.$filesuffix"
mv munich_germany.osm.bz2 $filename
bzip2 -d $filename

# load data
export PGPASS=$OSM_DATABASE_ENV_POSTGRES_PASSWORD
osm2pgsql -s -l -d postgres -U postgres -H $OSM_DATABASE_PORT_5432_TCP_ADDR -P 5432 --hstore $filebase