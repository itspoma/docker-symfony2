#!/bin/bash -e

DIR="`dirname \"$0\"`" && cd $DIR

docker rm -f $(docker ps -a -q)
docker rmi -f docker-symfony2/{apache,mysql,app}

docker build --rm -t docker-symfony2/apache env/multiple-containers/apache
docker build --rm -t docker-symfony2/mysql env/multiple-containers/mysql
docker build --rm -t docker-symfony2/app env/multiple-containers/app

# docker run --name=apache -tid docker-symfony2/apache
# docker exec -ti apache bash

docker run --name=apache -p 80:8080 -p 9001:9001 -v $PWD/src:/var/www/symfony -ti -d docker-symfony2/apache
docker run --name=mysql -p 3306:3306 -ti -d docker-symfony2/mysql

docker run -ti -d \
    --link apache:apache \
    --link mysql:mysql \
    --volumes-from apache \
    -p 8000:8000 \
    --name=app docker-symfony2/app bash

docker exec -ti app bash
docker exec -ti app symfony demo /var/www/symfony/demo
docker exec -ti app php /var/www/symfony/demo/app/check.php
docker exec -ti app php /var/www/symfony/demo/app/console server:run 0.0.0.0:8000