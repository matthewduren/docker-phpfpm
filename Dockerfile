FROM ubuntu:14.04
MAINTAINER Matt Duren <matthewduren@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list && \
    apt-get install -y software-properties-common && \
<<<<<<< HEAD
=======
    add-apt-repository -y ppa:sjinks/phalcon && \
>>>>>>> 74a24699c58e1cf5d1c1c7d15bdc9026f7d8c43f
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
<<<<<<< HEAD
                       php5-curl \
                       mono-complete \
                       php5-xdebug 

RUN php5enmod mcrypt
=======
                       php5-phalcon \
					   php5-curl

RUN ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/fpm/conf.d/20-mcrypt.ini
>>>>>>> 74a24699c58e1cf5d1c1c7d15bdc9026f7d8c43f
RUN sed -i 's/^;opcache.enable=0/opcache.enable=1/' /etc/php5/fpm/php.ini

RUN sed -i '/daemonize /c \
daemonize = no' /etc/php5/fpm/php-fpm.conf

RUN sed -i '/^listen /c \
listen = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf

RUN sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php5/fpm/pool.d/www.conf

<<<<<<< HEAD
ADD startup.sh /usr/sbin/startup.sh
ADD xdebug.ini /etc/php5/mods-available/xdebug.ini
ADD xdebug.ini.tmpl /etc/php5/mods-available/xdebug.ini.tmpl
=======

ADD startup.sh /usr/sbin/startup.sh
>>>>>>> 74a24699c58e1cf5d1c1c7d15bdc9026f7d8c43f

WORKDIR /app/

EXPOSE 9000
VOLUME ["/var/apps", "/var/logs/web"]
ENTRYPOINT ["bash", "/usr/sbin/startup.sh"]
