FROM php:5.4-apache


MAINTAINER hank.sunday <hank.sunday@gmail.com>

RUN apt-get update -q -y
RUN apt-get install git-core  -y
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd
RUN apt-get clean -q && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/getgrav/grav.git /var/www/html/
WORKDIR /var/www/html/
RUN bin/grav install

#Install datahub docs
RUN rm -fR /var/www/html/user/
COPY . /var/www/html/user/

