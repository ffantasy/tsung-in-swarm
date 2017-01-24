#!/bin/bash

if [ $# != 2 ]; then
echo "USAGE: $0 TsungConfigFile ClientAmount"
echo "e.g.: $0 config.xml 1"
exit 1;
fi

IMAGE_NAME=ffantasy/tsung-in-swarm:17011601
PREFIX=ff-tsung-
NETWORK_NAME=${PREFIX}network
CONTROLER_NAME=${PREFIX}controler
CLIENT_NAME=${PREFIX}client

echo -e "\e[33mcreate tsung network...\e[0m"
docker network create -d overlay $NETWORK_NAME

echo -e "\e[33mcreate tsung controler...\e[0m"
docker service create --name $CONTROLER_NAME --replicas=1 -p8091:8091 --network $NETWORK_NAME --mount type=bind,source=$1,destination=/tmp/config.xml $IMAGE_NAME sleep infinity
controlerId=''
while [ -z $controlerId ]; do
    sleep 1s
    controlerId=$(docker ps -qf "name=$CONTROLER_NAME")
done

echo -e "\e[33mcreate tsung clients...\e[0m"
docker service create --name $CLIENT_NAME --replicas=$2 --network $NETWORK_NAME $IMAGE_NAME bash runclient.sh $CONTROLER_NAME

echo -e "\e[33mrun contorler...\e[0m"
docker exec -it $controlerId bash runcontroler.sh $2

echo -e "\e[33mremove service...\e[0m"
docker service rm $CLIENT_NAME $CONTROLER_NAME
#make sure remove controler container
docker rm -f $(docker ps -aqf "name=$CONTROLER_NAME") > /dev/null

