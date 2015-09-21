FROM postgres:9.3


RUN apt-get -qq update \
      && apt-get install -y --no-install-recommends \
         postgresql-9.3-postgis-2.1 postgis

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
