#!/bin/bash
echo "******CREATING DOCKER DATABASE******"
gosu postgres postgres --single <<- EOSQL
    CREATE EXTENSION hstore;
    CREATE EXTENSION postgis;
    CREATE EXTENSION postgis_topology;
    CREATE EXTENSION fuzzystrmatch;
EOSQL
echo ""
echo "******DOCKER DATABASE CREATED******