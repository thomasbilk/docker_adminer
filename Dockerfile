FROM debian:8

MAINTAINER Thomas Bilk <thomasbilk@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
      libapache2-mod-php5 \
      php5-pgsql \
      php5-mysql \
      php5-sqlite && \
    apt-get clean

ADD ./adminer.conf /etc/apache2/sites-available/
ADD ./index.php /var/www/index.php
ADD http://www.adminer.org/latest.php /var/www/adminer.php

RUN chown -R www-data:www-data /var/www && \
    chmod 755 /var/www/*.php && \
    rm -rf /var/www/html && \
    rm /etc/apache2/sites-enabled/* && \
    ln -s /etc/apache2/sites-available/adminer.conf /etc/apache2/sites-enabled/

WORKDIR /var/www
EXPOSE 80

CMD apache2ctl -D FOREGROUND
