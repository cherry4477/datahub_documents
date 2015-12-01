FROM php:5.6-apache


MAINTAINER hank.sunday <hank.sunday@gmail.com>

RUN apt-get update -q -y && apt-get install -y \
        git-core \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring
RUN apt-get clean -q && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/getgrav/grav.git /var/www/html/
WORKDIR /var/www/html/
RUN bin/composer.phar self-update && bin/grav install

#Install datahub docs
RUN rm -fR /var/www/html/user/
COPY . /var/www/html/user/

#权限
RUN chown www-data:www-data /var/www/html/ 
RUN chown -R www-data:www-data /var/www/html/
RUN find /var/www/html/ -type f | xargs chmod 664 
RUN find /var/www/html/bin -type f | xargs chmod 775 
RUN find /var/www/html/ -type d | xargs chmod 775 
RUN find /var/www/html/ -type d | xargs chmod +s 
RUN umask 0002

