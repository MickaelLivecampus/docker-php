FROM php:8.2-fpm-alpine

# Install necessary below packages and clear
RUN apk update && apk add --no-cache \
        unzip \
        git \
        nano \
        sudo \
        libzip-dev \
        libpq \
        libxml2-dev \
        freeradius-utils \
        libgd \
        icu-dev \
        zlib-dev \
        nodejs \
        npm \
    && rm -rf /var/cache/apk/*

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli intl xml ctype dom

# Install Symfony CLI
RUN apk add --no-cache bash
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Install Yarn
RUN npm i -g yarn

ARG GIT_REPO_URL

# Check if the Git repository URL is provided
RUN if [ -z "$GIT_REPO_URL" ]; then echo "URL not found !"; exit 1; fi

# Clone the Git repository
RUN git clone $GIT_REPO_URL /var/www/html

# Change the owner of the /var/www/html directory to www-data (PHP-FPM user)
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Copy Apache configuration file (if needed)
# COPY apache.conf /etc/apache2/sites-enabled/000-default.conf

# Install dependencies if composer.json exists
WORKDIR /var/www/html

# Switch to www-data
USER www-data

# Install composer dependencies if composer.json exists
RUN if [ -f "composer.json" ]; \ 
        then composer install -q --no-ansi --no-interaction --no-scripts --no-progress --prefer-dist; \
    fi

# Create a .env file
ARG APP_ENV APP_SECRET MESSENGER_TRANSPORT_DSN MAILER_DSN SOCIETY
ARG DB_TYPE DB_HOST DB_USER DB_PASSWORD DB_DATABASE DB_PORT

RUN echo "\
APP_ENV=$APP_ENV\n\
APP_SECRET=$APP_SECRET\n\
MESSENGER_TRANSPORT_DSN=$MESSENGER_TRANSPORT_DSN\n\
MAILER_DSN=$MAILER_DSN\n\
SOCIETY=$SOCIETY\n\
DATABASE_URL=$DB_TYPE://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_DATABASE" > .env.local

# Run PHP-FPM
CMD ["php-fpm"]