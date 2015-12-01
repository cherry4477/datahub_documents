FROM garywiz/docker-grav
MAINTAINER hank.he <hank.sunday@gmail.com>

RUN rm -rf /apps/var/grav/user/*
COPY . /apps/var/grav/user