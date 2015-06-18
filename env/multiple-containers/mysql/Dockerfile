FROM mysql:5.7
MAINTAINER itspoma <itspoma@gmail.com>

ENV MYSQL_ROOT_PASSWORD "toor"
ENV MYSQL_DATABASE "testdb"

ENV MYSQL_USER "symfony"
ENV MYSQL_PASSWORD "symfonysecret"

RUN sed -i -e"s/^#bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf