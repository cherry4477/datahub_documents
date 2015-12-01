FROM ahumaro/grav-php-nginx
MAINTAINER hank.he <hank.sunday@gmail.com>

RUN rm -rf /usr/share/nginx/html/user
COPY . /usr/share/nginx/html/user
RUN chmod -R u+s /usr/share/nginx/html/user && chmod -R g+s /usr/share/nginx/html/user && chmod -R g+w /usr/share/nginx/html/user