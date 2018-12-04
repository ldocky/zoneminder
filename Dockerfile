FROM ubuntu:bionic
MAINTAINER ldocky 

VOLUME ["/config", "/var/cache/zoneminder"]

ENV DEBIAN_FRONTEND=noninteractive

RUN 	apt-get update
RUN	apt-get install -y software-properties-common 
RUN	add-apt-repository -y ppa:iconnor/zoneminder-1.32
RUN	apt-get update
RUN 	apt-get install -y mariadb-server \
    	apache2 \
    	php \
    	libapache2-mod-php \
    	php-mysql \
	nano \
    	curl \ 
        zoneminder

RUN 	adduser www-data video
RUN 	chmod 775 /etc/zm/zm.conf
RUN 	chown root:www-data /etc/zm/zm.conf
RUN 	chown -R www-data:www-data /usr/share/zoneminder
RUN 	a2enconf zoneminder  && \
    	a2enmod cgi && \
    	a2enmod rewrite && \
    	a2enmod ssl && \
	a2enmod expires && \
	a2enmod headers
	


EXPOSE 80 443

RUN 	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY 	scripts/startup.sh /startup.sh
COPY 	scripts/zoneminder /etc/init.d/
RUN 	chmod 755 /etc/init.d/zoneminder && \
	update-rc.d zoneminder defaults && \
	update-rc.d zoneminder enable

RUN 	chmod 777 /startup.sh
ENTRYPOINT ["/startup.sh"]
