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
ENV MYSQL_ROOT_HOST="%"
ENV MYSQL_ALLOW_EMPTY_PASSWORD: 1

RUN apk update
RUN apk upgrade
RUN apk add wget curl ca-certificates tini
RUN update-ca-certificates

RUN addgroup -g ${DOCKER_GID} ${DOCKER_GROUP}
RUN adduser -D -G ${DOCKER_GROUP} -u ${DOCKER_UID} ${DOCKER_USER}

RUN apk add mariadb mariadb-client

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# When you done clear apk cache.
RUN rm -f /var/cache/apk/*

USER ${DOCKER_USER}

RUN mkdir -p /home/${DOCKER_USER}/.mysql/log
RUN mkdir -p /home/${DOCKER_USER}/.mysql/data
RUN mkdir -p /home/${DOCKER_USER}/.mysql/tmp
RUN mkdir -p /home/${DOCKER_USER}/.mysql/share/mysql

WORKDIR /home/${DOCKER_USER}/.mysql
COPY my.cnf /home/${DOCKER_USER}/.mysql/my.cnf
RUN sed -i 's/DOCKER_USER/'"$DOCKER_USER"'/g' /home/${DOCKER_USER}/.mysql/my.cnf

EXPOSE 3306
EXPOSE 33060
EXPOSE 33061

ENTRYPOINT ["/sbin/tini", "--"]

CMD /bin/sh /usr/local/bin/start.sh
