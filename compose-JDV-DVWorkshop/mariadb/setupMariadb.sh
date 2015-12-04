#!/bin/bash
sudo /usr/sbin/sshd -D >> /dev/null &

mysqld_safe  --user=root --basedir='/usr' --datadir='/var/lib/mysql/'  &

sleep 5s
tail -n 30 /var/log/mariadb/mariadb.log

mysql --user=root --password=mariadb < /tmp/mariadbConfig/demo/financials-mysql.sql

#The routine below is written to keep the container alive
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
