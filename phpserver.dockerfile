FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
    apt-utils \
    curl \
    libcurl3 \
    libcurl3-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    zlib1g-dev \
    libicu-dev \
    g++

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure intl

RUN docker-php-ext-enable opcache

RUN docker-php-ext-install pdo_mysql curl gd mcrypt intl

#COPY app/php/php.ini /usr/local/etc/php/

COPY ./ /var/www
