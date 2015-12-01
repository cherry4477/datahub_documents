FROM garywiz/docker-grav
MAINTAINER hank.he <hank.sunday@gmail.com>

WORKDIR /usr/share/nginx/html/
ADD . /usr/share/nginx/html/user
