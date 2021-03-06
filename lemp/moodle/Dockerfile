FROM php:7.2-apache
MAINTAINER Gonzalo Yarvi <gonzalo.yarvi@unc.edu.ar>

ENV MOODLE_VERSION=3.9.8
ENV UPLOAD_MAX_FILESIZE=20M
ENV PHP_MEMORY_LIMIT=128M
ENV PHP_MAX_EXECUTION_TIME=30

ENV MYSQL_DATABASE=onboarding
ENV MYSQL_USER=us_onboarding
ENV MYSQL_PASSWORD=onboarding  

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /var/www/html

RUN apt-get update \
    && apt-get -qq install graphviz aspell ghostscript libpspell-dev libpng-dev libicu-dev libxml2-dev libldap2-dev sudo netcat unzip libssl-dev zlib1g-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) pspell gd intl xml xmlrpc ldap zip soap mbstring mysqli opcache \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && curl -L https://github.com/moodle/moodle/archive/v${MOODLE_VERSION}.tar.gz | tar xz --strip=1 \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && mkdir -p /moodledata /var/local/cache \
    && chown -R www-data /moodledata \
    && chmod -R 777 /moodledata /var/local/cache \
    && chmod -R 0755 /var/www/html \
    && chown -R www-data /var/www/html \
    && mkdir /docker-entrypoint.d


#VOLUME /moodledata
EXPOSE 80

#ENTRYPOINT ["docker-entrypoint.sh"]
#CMD ["-e", "info", "-D", "FOREGROUND"]
