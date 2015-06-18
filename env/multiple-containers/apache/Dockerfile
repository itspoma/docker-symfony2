FROM php:5.6
MAINTAINER itspoma <itspoma@gmail.com>

RUN apt-get -y update \
 && apt-get -y install mc supervisor \
 && apt-get -y install apache2 \
 && apt-get -y install libapache2-mod-php5 \
 && apt-get clean \
 && echo "alias ll='ls -la'" >> ~/.bashrc

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./apache2-app.conf /etc/apache2/sites-available/app.conf

RUN sed -i -e"s/^;date.timezone.*/date.timezone = Europe\/Kiev/" /etc/php5/apache2/php.ini \
 && touch /usr/local/etc/php/conf.d/php.ini \
 && echo "date.timezone = Europe/Kiev" > /usr/local/etc/php/conf.d/php.ini

RUN ln -s /etc/apache2/sites-available/app.conf /etc/apache2/sites-enabled/app.conf \
 && mkdir -p /var/www/symfony \
 && echo "welcome to app directory" > /var/www/symfony/index.html \
 && echo "\nServerName $(hostname)" >> /etc/apache2/apache2.conf

RUN ln -sf /dev/stdout /var/log/apache2/access.log \
 && ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80 8080
EXPOSE 9001

VOLUME ["/var/www", "/etc/apache2/", "/etc/supervisor/"]

WORKDIR "/var/www"

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]