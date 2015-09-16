#!/bin/bash

# download data
#wget -P /raw_data/ https://s3.amazonaws.com/metro-extracts.mapzen.com/munich_germany.osm.bz2
wget -P /raw_data/ https://s3.amazonaws.com/metro-extracts.mapzen.com/bruges_belgium.osm.bz2

# enter into raw_data directory
cd /raw_data

#locate the latest file
# file example bruges_belgium.osm.bz2
today=`date '+%Y_%m_%d'`
latestfile=$(ls -rt | tail -1)
# parse full filename
filebase="$(echo $latestfile | tr . '\n' | head -1)_$today"
filesuffix=$(echo $latestfile | tr . '\n' | head -2 | tail -1)
compsuffix=$(echo $latestfile | tr . '\n' | head -3 | tail -1) 
# for the purpose of communicating with load_data.exp
export filename="$filebase.$filesuffix"

# extract data
mv $latestfile "$filename.$compsuffix"
bzip2 -d "$filename.$compsuffix"

# load data
../load_data.exp
