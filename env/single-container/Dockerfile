FROM centos:6
MAINTAINER itspoma <itspoma@gmail.com>

# install required packages, with php
RUN yum clean all \
 && yum -y install git curl mc \
 && yum -y install php php-dom php-pdo php-mysql php-intl \
 && yum -y install mysql mysql-server \
 && yum -y install httpd

WORKDIR "/var/www"

# configure the php.ini
RUN echo "" >> /etc/php.ini \
 && sed 's/;date.timezone.*/date.timezone = Europe\/London/' -i /etc/php.ini \
 && sed 's/^display_errors.*/display_errors = On/' -i /etc/php.ini \
 && sed 's/^display_startup_errors.*/display_startup_errors = On/' -i /etc/php.ini

# configure the httd.conf
RUN sed 's/#ServerName.*/ServerName demo/' -i /etc/httpd/conf/httpd.conf

# put vhost config for httpd
ADD ./demo.conf /etc/httpd/conf.d/demo.conf

# install Composer
RUN curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

VOLUME ["/var/www/symfony"]

EXPOSE 3306
EXPOSE 80 8080

# add entrypoint shell script
ADD ./run.sh /var/www/run.sh

CMD ["/bin/bash", "/var/www/run.sh"]