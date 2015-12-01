FROM php:5.6-apache


MAINTAINER hank.sunday <hank.sunday@gmail.com>

RUN apt-get update -q -y
RUN apt-get install git-core php5 php5-cli php5-fpm php5-gd php5-curl  -y
RUN apt-get clean -q && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/getgrav/grav.git /var/www/html/
WORKDIR /var/www/html/
RUN bin/composer.phar self-update && bin/grav install

#Install datahub docs
RUN rm -fR /var/www/html/user/
COPY . /var/www/html/user/

