#!/bin/bash
sudo /usr/sbin/sshd -D >> /dev/null &

/home/postgres/jon/rhq-agent/bin/rhq-agent-wrapper.sh start

PGDATA=/var/lib/pgsql/9.3/data

/usr/pgsql-9.3/bin/pg_ctl start -D $PGDATA

#The routine below is written to keep the container alive
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
