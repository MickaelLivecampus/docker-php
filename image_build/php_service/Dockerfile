# Stage 1: Dependencies php installation
FROM php:8.2-fpm-buster AS backend-builder
# Install necessary below packages and clear
RUN apt-get update && apt-get install -y \
        gnupg \
        g++ \
        nano \
        procps \
        openssl \
        unzip \
        zlib1g-dev \
        libzip-dev \
        libfreetype6-dev \
        libpng-dev \
        libjpeg-dev \
        libicu-dev  \
        libonig-dev \
        libxslt1-dev \
        acl \
    && rm -rf /var/cache/apt/*

RUN docker-php-ext-configure gd --with-jpeg --with-freetype 
# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip xsl gd intl opcache exif mbstring

# ----------------------------------------------------------------

# Stage 2: Composer Install
FROM composer:2.7 AS composer_builder
WORKDIR /deps
# Copy only the composer files to avoid unnecessary cache invalidation
COPY src/composer.json src/composer.lock ./
RUN composer install --no-scripts --no-autoloader --no-progress --no-interaction --prefer-dist

COPY src/config           ./config
COPY src/public/index.php ./public/
COPY src/src              ./src
COPY src/templates        ./templates
COPY src/translations     ./translations

RUN composer dump-autoload

# ----------------------------------------------------------------

# Stage 3: Yarn Builder
FROM node:alpine AS yarn_builder
WORKDIR /yarn_build
# Copy only the yarn files to avoid unnecessary cache invalidation
COPY src/package.json src/yarn.lock ./
# Install JavaScript dependencies
RUN yarn install --frozen-lockfile --non-interactive
# Copy entire project
COPY src .
# Build assets
RUN yarn encore production

# ----------------------------------------------------------------

# Stage 4: Runner
FROM backend-builder AS runner

WORKDIR /var/www/html

# Copy project files from Composer Builder, Yarn Builder and source code (yarn have it)
COPY --from=composer_builder /deps .
COPY --from=yarn_builder /yarn_build .