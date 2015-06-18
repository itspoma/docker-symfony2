preparation.. coding.. and testing! :)To run a demo Symfony app in a single container:

```bash
$ cd docker-symfony2/.
$ docker build --rm -t docker-symfony2/single-container env/single-container
$ docker run -p 80:8080 -ti docker-symfony2/single-container bash
$ open http://$(boot2docker ip)/
$ docker rm -f $(docker ps -a -q)
```
