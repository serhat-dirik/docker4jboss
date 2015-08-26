#!/bin/bash
 #######
#change agent config
_HOST_NAME="$(cat /etc/hostname)"
_RHQSERVER_IP="$(cat /etc/hosts|grep rhqserver|sed -n '1p'|cut -d$'\t' -f1)"
_RHQSERVER_IP_ESC="$(echo "$_RHQSERVER_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
sed -i -e "s/<entry key=\"rhq\.agent\.server\.bind-address\".*/<entry key=\"rhq\.agent\.server\.bind-address\" value=\"$_RHQSERVER_IP_ESC\"\/>  /" /opt/apache/jon/rhq-agent/conf/agent-configuration.xml

#########
# Get the IP address
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')

# Adjust the IP addresses in the mod_cluster.conf file
sed -i "s|[0-9\.\*]*:6666|$IPADDR:6666|g" /opt/apache/jboss-ews-2.1/httpd/conf.d/mod_cluster.conf
sed -i "s|[0-9\.\*]*:80|$IPADDR:80|g" /opt/apache/jboss-ews-2.1/httpd/conf.d/mod_cluster.conf

#########
 cp /apacheConfig/start.sh /opt/apache

sh /opt/apache/start.sh
#if our master server fails somehow, we need to leave the container alive.
#The routine below is written to keep the container alive
for (( ; ; ))
do
   sleep 10000
done
