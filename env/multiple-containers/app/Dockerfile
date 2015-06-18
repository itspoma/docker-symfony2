FROM docker-symfony2/apache
MAINTAINER itspoma <itspoma@gmail.com>

RUN apt-get -y update -qq \
 && apt-get install -y mc curl \
 && apt-get clean

RUN curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

RUN curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony \
 && chmod a+x /usr/local/bin/symfony

WORKDIR /var/www/symfony

CMD ["composer", "--help"]