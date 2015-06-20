#!/bin/bash -e

docker rm -f $(docker ps -a -q)
docker rmi -f example/nginx

docker build -t example/nginx .

docker run -td -P example/nginx

docker ps