FROM php:5.4-apache


MAINTAINER hank.sunday <hank.sunday@gmail.com>

RUN apt-get update -q -y
RUN apt-get install git-core  -y
RUN apt-get clean -q && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/getgrav/grav.git /var/www/html/
WORKDIR /var/www/html/
RUN bin/grav install

#Install datahub docs
RUN rm -fR /var/www/html/user/
COPY . /var/www/html/user/

