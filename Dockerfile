FROM debian:8
MAINTAINER Marcel Boogert <marcel@mtdb.nl>

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i nl_NL -c -f UTF-8 -A /usr/share/locale/locale.alias nl_NL.UTF-8
ENV LANG nl_NL.utf8

RUN apt-get update && apt-get install -y apache2 supervisor php5 php5-gd php5-mcrypt mcrypt php5-mysql php5-intl php5-curl ca-certificates
RUN a2enmod rewrite expires headers 
RUN php5enmod mcrypt
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor          
                           
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf                                  

EXPOSE 80
CMD ["/usr/bin/supervisord"]
