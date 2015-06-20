#!/bin/bash -e

DIR="`dirname \"$0\"`" && cd $DIR

docker rm -f $(docker ps -a -q)
docker rmi -f docker-symfony2/single-container
docker rmi -f docker-symfony2/{apache,mysql,app}
docker rmi -f dockercompose_app