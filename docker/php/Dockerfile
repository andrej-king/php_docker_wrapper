ARG PHP_FPM_VERSION
ARG PHP_CLI_VERSION

# ================================== PHP FPM ==================================
FROM php:${PHP_FPM_VERSION} AS app_fpm_php

# Copy common config files
COPY ./common/conf.d /usr/local/etc/php/conf.d
COPY ./common/php-fpm.d /usr/local/etc/php/conf.d

WORKDIR /app

# Check image health
HEALTHCHECK --interval=5s --timeout=3s --start-period=1s \
    CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1

FROM app_fpm_php AS app_php_fpm_local

# Add xdebug layer
ARG XDEBUG_VERSION
RUN apk add --no-cache fcgi git linux-headers \
    && git clone --branch $XDEBUG_VERSION --depth 1 https://github.com/xdebug/xdebug.git /usr/src/php/ext/xdebug \
    && docker-php-ext-configure xdebug --enable-xdebug-dev \
    && docker-php-ext-install xdebug \
    && apk del git

RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

# Copy local config files
COPY ./local/conf.d /usr/local/etc/php/conf.d

LABEL 'env'='php-fpm-local'

# ================================== PHP CLI ==================================

FROM php:${PHP_CLI_VERSION} AS app_cli_php

# Install basic apps
RUN apk add --no-cache unzip

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
#ENV COMPOSER_ALLOW_SUPEUSER 1
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --quiet

# Copy common config files
COPY ./common/conf.d /usr/local/etc/php/conf.d

WORKDIR /app

FROM app_cli_php AS app_php_cli_local

ARG XDEBUG_VERSION
RUN apk add --no-cache fcgi git linux-headers \
    && git clone --branch $XDEBUG_VERSION --depth 1 https://github.com/xdebug/xdebug.git /usr/src/php/ext/xdebug \
    && docker-php-ext-configure xdebug --enable-xdebug-dev \
    && docker-php-ext-install xdebug \
    && apk del git

RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

# Copy local config files
COPY ./local/conf.d /usr/local/etc/php/conf.d

LABEL 'env'='php-cli-local'
