#!/bin/bash -e

DIR="`dirname \"$0\"`" && cd $DIR

docker rm -f $(docker ps -a -q)
docker rmi -f docker-symfony2/single-container

docker build --rm -t docker-symfony2/single-container single-container/

# docker run -P -d -ti --name test1 docker-symfony2/single-container
# docker ps
# docker exec -ti test1 bash
# echo "test" > /var/www/symfony/index.html

docker run \
    --name=test1 \
    -P \
    -v $PWD/../src:/var/www/symfony \
    -ti \
    -d \
    docker-symfony2/single-container

docker ps | grep docker-symfony2/single-container