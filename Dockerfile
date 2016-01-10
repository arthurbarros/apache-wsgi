FROM ubuntu:14.04
MAINTAINER Arthur Barros <arthbarros@gmail.com>

RUN apt-get update && \
        apt-get -y install \
             git \
             apache2 \
             python-pip \
             build-essential \
             libmysqlclient-dev \
             python-dev \
             libjpeg-dev \
             libfreetype6 \
             libfreetype6-dev \
             zlib1g-dev \
             libapache2-mod-wsgi \
             libffi-dev

ADD httpd-foreground /usr/local/bin/
ADD apache_vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

RUN mkdir -p /app

EXPOSE 80
CMD ["httpd-foreground"]