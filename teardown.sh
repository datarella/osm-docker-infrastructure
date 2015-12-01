#! bin/bash
# remove container
docker stop $(docker ps -aq)
docker rm -v $(docker ps -aq)

