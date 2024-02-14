# Stage 1: Dependencies php installation
FROM php:8.2-fpm-alpine AS backend-builder
# Install necessary below packages and clear
RUN apk update && apk add --no-cache \
        nano \
        libzip-dev \
        libpq \
        libxml2-dev \
        libgd \
        icu-dev \
        zlib-dev \
    && rm -rf /var/cache/apk/*
# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli intl xml ctype dom

# ----------------------------------------------------------------

# Stage 2: Composer Install
FROM composer:2.7 AS composer_builder
WORKDIR /deps
# Copy only the composer files to avoid unnecessary cache invalidation
COPY src/composer.json src/composer.lock ./
RUN composer install --no-scripts --no-autoloader --no-progress --no-interaction --prefer-dist

# ----------------------------------------------------------------

# Stage 3: Yarn Builder
FROM node:alpine AS yarn_builder
WORKDIR /yarn_build
# Copy only the yarn files to avoid unnecessary cache invalidation
COPY src/package.json src/yarn.lock ./
# Install JavaScript dependencies
RUN yarn install --frozen-lockfile --non-interactive
# Copy entire project
COPY /src .
# Build assets
RUN yarn encore production

# ----------------------------------------------------------------

# Stage 4: Runner
FROM backend-builder AS runner

WORKDIR /app

# Copy project files from Composer Builder, Yarn Builder and source code (yarn have it)
COPY --from=composer_builder /deps /app
COPY --from=yarn_builder /yarn_build /app

# Switch to www-data
USER www-data

# Run PHP-FPM
CMD ["php-fpm"]