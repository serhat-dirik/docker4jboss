#!/bin/bash

echo "Starting postgresql server..."

PGDATA=/var/lib/pgsql/9.3/data
su - postgres -c "/usr/pgsql-9.3/bin/pg_ctl start -D $PGDATA"


exec /usr/sbin/sshd -D >> /dev/null &

HADOOP_PREFIX=/opt/hadoop

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

_HOST_NAME="$(cat /etc/hostname)"

rm -rf /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
sed -i -e "s/localhost/$_HOST_NAME/" /opt/hadoop/etc/hadoop/core-site.xml
#sed -i -e "s/localhost/$_HOST_NAME/" /opt/hadoop/etc/hadoop/mapred-site.xml
#$HADOOP_PREFIX/bin/hdfs namenode -format
$HADOOP_PREFIX/sbin/start-dfs.sh
#$HADOOP_PREFIX/sbin/start-all.sh
$HADOOP_PREFIX/bin/hdfs dfsadmin -safemode leave
#$HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root
#$HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop/ input
$HADOOP_PREFIX/sbin/start-yarn.sh

# start hive metastore server
$HIVE_HOME/bin/hive --service metastore &

sleep 5
echo "Starting hive server"
# start hive server
$HIVE_HOME/bin/hive --service hiveserver2 &

#The routine below is written to keep the container alive
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
