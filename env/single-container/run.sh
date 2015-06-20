#!/bin/bash -e

/sbin/service mysqld restart
/sbin/service httpd restart

if [ -d "/var/www/symfony/demo/" ]; then
    # /usr/bin/php /var/www/symfony/demo/app/check.php

    rm -rf /var/www/symfony/demo/app/{cache,logs}

    mkdir /tmp/symfony-{cache,logs}
    ln -s /tmp/symfony-cache /var/www/symfony/demo/app/cache
    ln -s /tmp/symfony-logs /var/www/symfony/demo/app/logs

    # /usr/bin/php /var/www/symfony/demo/app/console cache:warmup

    /bin/chmod -R 0777 /tmp/symfony-{cache,logs}/*
fi

php