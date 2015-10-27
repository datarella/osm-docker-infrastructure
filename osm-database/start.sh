#!/bin/bash

DATADIR="/var/lib/postgresql/9.3/main"
CONF="/etc/postgresql/9.3/main/postgresql.conf"
POSTGRES="/usr/lib/postgresql/9.3/bin/postgres"
INITDB="/usr/lib/postgresql/9.3/bin/initdb"

# test if DATADIR is existent
if [ ! -d $DATADIR ]; then
  echo "Creating Postgres data at $DATADIR"
  mkdir -p $DATADIR
fi

# test if DATADIR has content
if [ ! "$(ls -A $DATADIR)" ]; then
  echo "Initializing Postgres Database at $DATADIR"
  chown -R postgres $DATADIR
  su postgres sh -c "$INITDB $DATADIR"
  su postgres sh -c "$POSTGRES --single -D $DATADIR -c config_file=$CONF" <<< "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASS';"

fi




# create extensions
#su postgres sh -c "psql -U docker <<EOSQL
#CREATE EXTENSION hstore;
#CREATE EXTENSION postgis;
#CREATE EXTENSION postgis_topology;
#CREATE EXTENSION fuzzystrmatch;
#EOSQL"

echo "------------------------------------------------"


trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM

echo "------------------------------------------------"


su postgres sh -c "$POSTGRES -D $DATADIR -c config_file=$CONF" &

sleep 100

echo "CREATE EXTENSION hstore;
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION fuzzystrmatch;" |
su postgres -c "psql -U postgres"

wait $!


