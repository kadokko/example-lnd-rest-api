#!/bin/bash

set -eu -o pipefail

NETWORK=lnd-local-network
SUBNET=172.16.0.0/16
DRIVER=bridge

# network
if [ "$(docker network ls | awk '{print $2}' | grep $NETWORK)" == "" ]; then
  NETWORK_ID=$(docker network create --driver=$DRIVER --subnet=$SUBNET $NETWORK)
  echo "docker network was created."
  echo " name : $NETWORK"
  echo " id   : $NETWORK_ID"
fi

# user id
user_id_file=jupyter/conf/host_user_id.tmp
echo -n "$(id -u)" > $user_id_file

# containers
docker-compose down
docker-compose build;
docker-compose up -d --force-recreate --remove-orphans;

# setup lnd wallet
docker exec -i lnd1 /bin/bash -c "./setup.sh"
docker exec -i lnd2 /bin/bash -c "./setup.sh"
docker exec -i lnd3 /bin/bash -c "./setup.sh"

# copy config to host directory
docker exec -u root -i lnd1 /bin/bash -c "./share.sh"
docker exec -u root -i lnd2 /bin/bash -c "./share.sh"
docker exec -u root -i lnd3 /bin/bash -c "./share.sh"

# clean
rm $user_id_file
