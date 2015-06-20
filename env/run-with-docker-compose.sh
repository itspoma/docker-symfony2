#!/bin/bash -e

DIR="`dirname \"$0\"`" && cd $DIR

docker rm -f $(docker ps -a -q)
docker rmi -f dockercompose_app

FILE=./docker-compose/docker-compose.yml

docker-compose --file $FILE up -d
docker-compose --file $FILE ps

# need to fix some permissions
docker exec -ti dockercompose_web_1 rm -rf /app/demo/app/{cache,logs} > /dev/null
docker exec -ti dockercompose_web_1 mkdir /tmp/symfony-{cache,logs} > /dev/null
docker exec -ti dockercompose_web_1 ln -s /tmp/symfony-cache /app/demo/app/cache > /dev/null
docker exec -ti dockercompose_web_1 ln -s /tmp/symfony-logs /app/demo/app/logs > /dev/null
docker exec -ti dockercompose_web_1 chmod -R 0777 /tmp/symfony-{cache,logs}/ > /dev/null