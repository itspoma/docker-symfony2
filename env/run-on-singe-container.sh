#!/bin/bash -e

DIR="`dirname \"$0\"`" && cd $DIR

docker rm -f $(docker ps -a -q)
docker rmi -f docker-symfony2/single-container

docker build --rm -t docker-symfony2/single-container single-container/
docker run -p 80:8080 -ti docker-symfony2/single-container bash

echo "navigate your browser to: http://$(boot2docker ip)/"

#$ docker rm -f $(docker ps -a -q)
#$ docker rmi -f docker-symfony2/single-container