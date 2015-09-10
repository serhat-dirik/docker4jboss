#!/bin/bash
sudo /usr/sbin/sshd -D >> /dev/null &

PGDATA=/var/lib/pgsql/9.3/data

/usr/pgsql-9.3/bin/pg_ctl start -D $PGDATA

#The routine below is written to keep the container alive
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
