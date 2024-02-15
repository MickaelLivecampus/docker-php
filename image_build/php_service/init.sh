#!/bin/bash

# -1 MOVE SOURCES FILES INTO BASE WORKDIR OF THE APP
cp -r /app/. /var/www/html

# -2 MIGRATIONS + FEATURES + CACHE CLEAR

php bin/console d:m:m --no-interaction
php bin/console d:f:l --env=dev --no-interaction --group=user
php bin/console c:c

# -3 START SERVER
php-fpm