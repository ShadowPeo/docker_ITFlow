#FROM alpine:3.16
FROM ghcr.io/linuxserver/baseimage-alpine:3.16

LABEL description="Alpine image for ITFlow"
LABEL maintainer="ShadowPeo"

#Install Apache2, PHP and other dependencies
RUN \
 echo "**** install packages ****" && \
    apk --no-cache --update \
    add git \
    apache2 \
    apache2-ssl \
    curl \
    php8-apache2 \
    php8-bcmath \
    php8-bz2 \
    php8-intl \
    php8-calendar \
    php8-common \
    php8-ctype \
    php8-curl \
    php8-dom \
    php8-gd \
    php8-iconv \
    php8-mbstring \
    php8-mysqli \
    php8-mysqlnd \
    php8-openssl \
    php8-pdo_mysql \
    php8-phar \
    php8-session \
    php8-xml \
    mariadb-client
#    && mkdir htdocs

#Pull App from Github
RUN \
 echo "**** Installing Application ****" && \
  git clone https://github.com/itflow-org/itflow.git app

#Create Config file in /config and link it to the app directory
RUN \
  echo "**** Create Config file in /config and link it to the app directory ****" && \
    touch /config/config.php && \
    ln -s /config/config.php /app/config.php


#Ports
EXPOSE 80 443

#Volumes
VOLUME /config /data

#Copy Files
ADD docker-entrypoint.sh /

#Healthchecks
HEALTHCHECK CMD wget -q --no-cache --spider localhost

#Entrypoint
ENTRYPOINT ["sh","docker-entrypoint.sh"]
