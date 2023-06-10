ARG VERSION

FROM php:${VERSION} AS app_php

# Copy common config files
COPY ./common/conf.d /usr/local/etc/php/conf.d
COPY ./common/php-fpm.d /usr/local/etc/php/conf.d

WORKDIR /app

# Check image health
HEALTHCHECK --interval=5s --timeout=3s --start-period=1s \
    CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1

FROM app_php AS app_php_local

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

LABEL 'env'='php-local'
