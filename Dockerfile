FROM ubuntu:14.04
MAINTAINER Matt Duren <matthewduren@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
    apt-get install -y software-properties-common && \
    apt-get update && \
    apt-get -y dist-upgrade

RUN apt-get -y install php5 \
                       php5-fpm \
                       php5-gd \
                       php-pear \
                       php5-mysql \
                       php5-memcached \
                       php5-mcrypt \
                       php5-xmlrpc \
                       php5-curl \
                       mono-complete \
                       php5-xdebug 

RUN php5enmod mcrypt
RUN sed -i 's/^;opcache.enable=0/opcache.enable=1/' /etc/php5/fpm/php.ini

RUN sed -i '/daemonize /c \
daemonize = no' /etc/php5/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf

RUN sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php5/fpm/pool.d/www.conf

ADD startup.sh /usr/sbin/startup.sh
ADD xdebug.ini /etc/php5/mods-available/xdebug.ini
ADD xdebug.ini.tmpl /etc/php5/mods-available/xdebug.ini.tmpl

WORKDIR /app/

EXPOSE 9000
VOLUME ["/var/apps", "/var/logs/web"]
ENTRYPOINT ["bash", "/usr/sbin/startup.sh"]
