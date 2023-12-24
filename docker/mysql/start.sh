#!/usr/bin/env sh

if [ ! -f "/home/$DOCKER_USER/.mysql/data/ibdata1" ]; then
  mysql_install_db --defaults-file=/home/$DOCKER_USER/.mysql/my.cnf --user=$DOCKER_USER --ldata=/home/$DOCKER_USER/.mysql/data --basedir=/usr
  sleep 2
fi

nohup mysqld --defaults-file=/home/$DOCKER_USER/.mysql/my.cnf --user=$DOCKER_USER --basedir=/home/$DOCKER_USER/.mysql --datadir=/home/$DOCKER_USER/.mysql/data > /home/$DOCKER_USER/.mysql/log/nohup.out 2>&1 &

sleep 10

mysql --defaults-file=/home/$DOCKER_USER/.mysql/my.cnf <<-EOSQL
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';

    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
    CREATE DATABASE IF NOT EXISTS testing;
    CREATE DATABASE IF NOT EXISTS db_export_temp;

    GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';
    FLUSH PRIVILEGES;
EOSQL

tail -f /home/$DOCKER_USER/.mysql/log/nohup.out
