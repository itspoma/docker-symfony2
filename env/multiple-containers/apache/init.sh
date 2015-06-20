#!/bin/bash -e

if [ -d "/var/www/symfony/demo/" ]; then
    rm -rf /var/www/symfony/demo/app/{cache,logs}

    mkdir /tmp/symfony-{cache,logs}

    ln -s /tmp/symfony-cache /var/www/symfony/demo/app/cache
    ln -s /tmp/symfony-logs /var/www/symfony/demo/app/logs

    /bin/chmod -R 0777 /tmp/symfony-{cache,logs}/

    echo "the symfone cache/log dirs were refreshed"
fi

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf