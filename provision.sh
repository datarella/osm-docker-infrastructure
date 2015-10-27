# build osm-database and osm-updater images
docker build --no-cache=true -t osm-database ./osm-database
docker build --no-cache=true -t osm-updater ./osm-updater
# docker build -t osm-database ./osm-database
# docker build -t osm-updater ./osm-updater


# create data directory at home directory of current user
mkdir "$HOME/OSM_DATA_HOME" 

# within OSM_DATA_HOME create RAW_DATA_DIR and OSM_DATABASE_DATA_DIR
RAW_DATA_DIR="$HOME/OSM_DATA_HOME/RAW_DATA_DIR" 
OSM_DATABASE_DATA_DIR="$HOME/OSM_DATA_HOME/OSM_DATABASE_DATA_DIR" 

mkdir "$HOME/OSM_DATA_HOME/RAW_DATA_DIR" 
mkdir "$HOME/OSM_DATA_HOME/OSM_DATABASE_DATA_DIR" 


# start data-only containers
docker run -d -v $OSM_DATABASE_DATA_DIR:/var/lib/postgresql/data --name osm-database-data osm-database
docker run -d -v $RAW_DATA_DIR:/raw_data --name osm-raw-data osm-database

# start postgres container
docker run -d -e POSTGRES_PASSWORD=docker -p 25432:5432 --volumes-from osm-database-data --name osm-database osm-database

# start osm-update container
docker run -d --link osm-database --volumes-from osm-raw-data --name osm-updater osm-updater


