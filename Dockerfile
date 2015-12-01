FROM ahumaro/grav-php-nginx
MAINTAINER hank.he <hank.sunday@gmail.com>

RUN rm -rf /usr/share/nginx/html/user
ADD . /usr/share/nginx/html/user
