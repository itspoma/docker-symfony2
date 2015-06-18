Cleanup before/after:

```bash
$ docker rm -f $(docker ps -a -q)
$ docker rmi -f $(docker images -q docker-symfony2/*)
```

To run a demo Symfony app in a single container:

```bash
$ cd docker-symfony2/.

$ docker build --rm -t docker-symfony2/single-container env/single-container
$ docker run -p 80:8080 -ti docker-symfony2/single-container bash
$ open http://$(boot2docker ip)/

or
$ bash env/run-on-singe-container.sh
```

To run a demo Symfony app based on multiple containers:

```bash
$ cd docker-symfony2/.

$ docker build --rm -t docker-symfony2/apache env/multiple-containers/apache
$ docker run --name=apache \
    -p 80:8080 -p 9001:9001 \
    -v $PWD/src:/var/www/symfony \
    -ti -d \
    docker-symfony2/apache

$ docker build --rm -t docker-symfony2/mysql env/multiple-containers/mysql
$ docker run --name=mysql \
    -p 3306:3306 \
    -ti -d \
    docker-symfony2/mysql

$ docker build --rm -t docker-symfony2/app env/multiple-containers/app
$ docker run -ti -d \
    --link apache:apache \
    --link mysql:mysql \
    --volumes-from apache \
    -p 8000:8000 \
    --name=app docker-symfony2/app bash

$ open http://$(boot2docker ip):8000/

or
$ bash env/run-on-multiple-container.sh
```
```
