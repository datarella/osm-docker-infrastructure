FROM ubuntu

#schedule cron run-parts
COPY update_procedure /etc/cron.weekly/
COPY load_data.exp .

RUN mkdir raw_data \
&& apt-get -qq update \
&& apt-get install --yes wget bzip2 expect \
&& chmod +x /etc/cron.weekly/update_procedure


# Install osm2pgsql, build from source
# Reference https://github.com/openstreetmap/osm2pgsql

RUN apt-get install -y git-core

RUN git clone git://github.com/openstreetmap/osm2pgsql.git


RUN sudo apt-get install --yes make cmake g++ libboost-dev libboost-system-dev \
    libboost-filesystem-dev libboost-thread-dev libexpat1-dev zlib1g-dev \
    libbz2-dev libpq-dev libgeos-dev libgeos++-dev libproj-dev lua5.2 \
    liblua5.2-dev

RUN cd osm2pgsql \
    && mkdir build \ 
    && cd build \
    && cmake .. \
    && make \
    && make install


# Clean up
RUN rm -rf /var/lib/apt/lists/*

CMD ["cron", "-f"]
