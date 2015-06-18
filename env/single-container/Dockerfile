FROM centos:6
MAINTAINER itspoma <itspoma@gmail.com>

ENV MYSQL_USER "root"
ENV MYSQL_PASSWORD ""

# install required packages, with php 5.6
RUN yum clean all \
 && yum -y install git curl mc \
 && yum -y install php php-dom php-pdo php-mysql php-intl \
 && yum -y install mysql mysql-server \
 && yum -y install httpd

WORKDIR "/var/www"

# configure the php (php.ini)
RUN echo "" >> /etc/php.ini \
 && sed 's/;date.timezone.*/date.timezone = Europe\/London/' -i /etc/php.ini \
 && sed 's/^display_errors.*/display_errors = On/' -i /etc/php.ini \
 && sed 's/^display_startup_errors.*/display_startup_errors = On/' -i /etc/php.ini

# configure the apache (httd.conf)
RUN sed 's/#ServerName.*/ServerName demo/' -i /etc/httpd/conf/httpd.conf

# put vhost config for httpd
ADD ./demo.conf /etc/httpd/conf.d/demo.conf

# setup the mysql
RUN echo "" > ~/.bash_profile \
 && echo "service mysqld restart" >> ~/.bash_profile \
 && echo "service httpd restart" >> ~/.bash_profile \
 && echo "source ~/.bash_profile" >> ~/.bashrc

RUN service mysqld restart

# install Composer
RUN curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

# download Symfony
RUN composer create-project --no-interaction symfony/framework-standard-edition demo "2.6.*" \
 && chmod 0777 -R demo/app/cache \
 && chmod 0777 -R demo/app/logs \
 && php demo/app/console cache:warmup \
 && php demo/app/check.php | grep "[OK]"

RUN sed 's/header..HTTP.1.. 403.*//g' -i demo/web/app_dev.php \
 && sed 's/exit..You are not allowed.*//g' -i demo/web/app_dev.php

VOLUME ["/var/www/demo"]

EXPOSE 3306
EXPOSE 80 8080