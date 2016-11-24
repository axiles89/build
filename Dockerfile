FROM ubuntu:latest
MAINTAINER Dmitry Kushnerev <dkushnerev@avito.ru>

RUN apt-get update && apt-get -y install python-software-properties \
    && apt-get -y install software-properties-common \
    && add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get -y --force-yes install \
	curl \
	mysql-client \
    supervisor \
    php7.0-fpm \
    php7.0-amqp \
    php7.0-curl \
    php7.0-gd \
    php7.0-geoip \
    php7.0-gmp \
    php7.0-imagick \
    php7.0-intl \
    php7.0-json \
    php7.0-mbstring \
    php7.0-mcrypt \
    php7.0-memcached \
    php7.0-mongodb \
    php7.0-mysql \
    php7.0-opcache \
    php7.0-pgsql \
    php7.0-readline \
    php7.0-redis \
    php7.0-soap \
    php7.0-sqlite3 \
    php7.0-xml \
    php7.0-yaml \
    php7.0-zip \
    php7.0-xdebug \
    vim

RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/2/ubuntu/xenial/ xenial contrib" > /etc/apt/sources.list.d/treasure-data.list
RUN apt-get update && apt-get install -y --force-yes td-agent
RUN mkdir -p /var/run/php


WORKDIR /var/www/project

RUN apt-get -y --force-yes install php-pear && pear channel-discover pear.phing.info && pear install phing/phing
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

