FROM garywiz/docker-grav
MAINTAINER hank.he <hank.sunday@gmail.com>

RUN rm -rf /apps/war/grav/user
COPY . /apps/war/grav/user