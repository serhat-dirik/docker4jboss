#!/bin/bash

sudo /usr/sbin/sshd -D >> /dev/null &

RHQ_SERVER_HOME="/opt/jboss/jon/jon-server-3.3.0.GA"
PGDATA="/var/lib/pgsql/9.3/data"

#Start postgres
su - postgres -c "/usr/pgsql-9.3/bin/pg_ctl start -D $PGDATA"

#Install JON
if [ ! -f $RHQ_SERVER_HOME/is.installed ]; then
  su - jboss -c "$RHQ_SERVER_HOME/bin/rhqctl install"
  su - jboss -c "touch $RHQ_SERVER_HOME/is.installed"
  su - jboss -c "/opt/jboss/jon-update/jon-server-3.3.0.GA-update-03/apply-updates.sh $RHQ_SERVER_HOME"
  rm -r  /opt/jboss/jon-update
else
  su - jboss -c "$RHQ_SERVER_HOME/bin/rhqctl stop"
fi

#Start JON
su - jboss -c "$RHQ_SERVER_HOME/bin/rhqctl stop"
su - jboss -c "$RHQ_SERVER_HOME/bin/rhqctl start --storage"
su - jboss -c "$RHQ_SERVER_HOME/bin/rhqctl start --agent"
su - jboss -c "$RHQ_SERVER_HOME/bin/rhqctl console --server"


#The routine below is written to keep the container alive
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
