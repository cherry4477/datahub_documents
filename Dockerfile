FROM garywiz/docker-grav
MAINTAINER hank.he <hank.sunday@gmail.com>

RUN rm -rf /apps/www/grav/user/*
COPY . /apps/www/grav/user
RUN chmod -R u+s /apps/www/grav/user && chmod -R g+s /apps/www/grav/user && chmod -R g+w /apps/www/grav/user