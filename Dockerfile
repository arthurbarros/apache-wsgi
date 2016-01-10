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

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www

ADD httpd-foreground /usr/local/bin/
ADD apache_vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

ADD requirements.txt /
RUN pip install -r requirements.txt
RUN mkdir -p /app

# Apache gets grumpy about PID files pre-existing
RUN rm -f /usr/local/apache2/logs/httpd.pid

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80
ENTRYPOINT ["apache2"]
CMD ["-DFOREGROUND"]