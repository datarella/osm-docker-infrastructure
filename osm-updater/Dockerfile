FROM ubuntu

#schedule cron run-parts
COPY update_procedure /etc/cron.weekly/
COPY load_data.exp .

RUN mkdir raw_data \
&& apt-get -qq update \
&& apt-get install --yes wget bzip2 expect \
&& chmod +x update_procedure.sh


# Install osm2pgsql, build from source
# Reference https://github.com/openstreetmap/osm2pgsql

RUN apt-get install -y git-core

RUN git clone git://github.com/openstreetmap/osm2pgsql.git


RUN apt-get install -y autoconf automake libtool make g++ pkg-config libboost-dev \
            libboost-system-dev libboost-filesystem-dev libboost-thread-dev libexpat1-dev \
            libgeos-dev libgeos++-dev libpq-dev libbz2-dev libproj-dev zlib1g-dev \
            protobuf-compiler libprotobuf-dev lua5.2 liblua5.2-dev

RUN cd osm2pgsql \
    && ./autogen.sh \
    && ./configure && make && make install

# Clean up
RUN rm -rf /var/lib/apt/lists/*

CMD ["cron", "-f"]
