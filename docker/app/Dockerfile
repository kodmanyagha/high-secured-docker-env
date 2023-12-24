FROM alpine:3.19

LABEL maintainer="Emir Buğra Köksalan <emir@rust.tc>"

ARG DOCKER_UID
ARG DOCKER_GID
ARG DOCKER_USER
ARG DOCKER_GROUP
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD

ENV DOCKER_UID=${DOCKER_UID}
ENV DOCKER_GID=${DOCKER_GID}
ENV DOCKER_USER=${DOCKER_USER}
ENV DOCKER_GROUP=${DOCKER_GROUP}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD}

RUN apk update
RUN apk upgrade
RUN apk add wget curl ca-certificates tini
RUN update-ca-certificates

RUN addgroup -g ${DOCKER_GID} ${DOCKER_GROUP}
RUN adduser -D -G ${DOCKER_GROUP} -u ${DOCKER_UID} ${DOCKER_USER}

RUN apk add php82 \
  php82-bcmath \
  php82-brotli \
  php82-bz2 \
  php82-calendar \
  php82-common \
  php82-ctype \
  php82-curl \
  php82-dom \
  php82-enchant \
  php82-exif \
  php82-ffi \
  php82-fileinfo \
  php82-gd \
  php82-gettext \
  php82-gmp \
  php82-iconv \
  php82-imap \
  php82-intl \
  php82-ldap \
  php82-mbstring \
  php82-mysqli \
  php82-mysqlnd \
  php82-opcache \
  php82-openssl \
  php82-pcntl \
  php82-pdo \
  php82-pdo_dblib \
  php82-pdo_mysql \
  php82-pdo_pgsql \
  php82-pdo_sqlite \
  php82-pear \
  php82-pecl-imagick \
  php82-pecl-memcache \
  php82-pecl-memcached \
  php82-pecl-mongodb \
  php82-pecl-protobuf \
  php82-pecl-redis \
  php82-pecl-ssh2 \
  php82-pecl-swoole \
  php82-pecl-uploadprogress \
  php82-pecl-uuid \
  php82-pecl-yaml \
  php82-pgsql \
  php82-phar \
  php82-posix \
  php82-pspell \
  php82-tokenizer \
  php82-session \
  php82-shmop \
  php82-simplexml \
  php82-soap \
  php82-sockets \
  php82-sodium \
  php82-sqlite3 \
  php82-xml \
  php82-xmlreader \
  php82-xmlwriter \
  php82-xsl \
  php82-zip

RUN rm /usr/bin/php
RUN ln -s /usr/bin/php82 /usr/bin/php

RUN apk add nodejs-current npm
RUN apk add mysql mysql-client
#RUN apk add postgresql15-client

# https://github.com/uNetworking/uWebSockets.js/discussions/158#discussioncomment-796551
RUN apk add --no-cache gcompat

RUN apk add supervisor

RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
RUN npm install -g npm
RUN npm install -g yarn

COPY supervisord.ini.example /etc/supervisord.ini.example
COPY php.ini /etc/php82/conf.d/99-app.ini
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# When you done clear apk cache.
RUN rm -f /var/cache/apk/*

USER ${DOCKER_USER}

RUN mkdir -p /home/${DOCKER_USER}/app
WORKDIR /home/${DOCKER_USER}/app

EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

ENTRYPOINT ["/sbin/tini", "--"]

CMD /bin/sh /usr/local/bin/start.sh
