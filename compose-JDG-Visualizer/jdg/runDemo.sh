#!/bin/bash
#Copy jdg config
rm -rf $JDG_HOME/standalone/configuration/clustered.xml
cp -r -a /jdgConfig/config/clustered.xml  $JDG_HOME/standalone/configuration

#######
#change JON agent config
_HOST_NAME="$(cat /etc/hostname)"
_RHQSERVER_IP="$(cat /etc/hosts|grep rhq-server|sed -n '1p'|cut -d$'\t' -f1)"
_RHQSERVER_IP_ESC="$(echo "$_RHQSERVER_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
sed -i -e "s/<entry key=\"rhq\.agent\.server\.bind-address\".*/<entry key=\"rhq\.agent\.server\.bind-address\" value=\"$_RHQSERVER_IP_ESC\"\/>  /" /opt/jboss//jon/rhq-agent/conf/agent-configuration.xml
#Start sshd
sudo /usr/sbin/sshd -D >> /dev/null &
#Start JON Agent
/opt/jboss/jon/rhq-agent/bin/rhq-agent-wrapper.sh start
#Start EAP
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
$JBOSS_HOME/bin/clustered.sh -b $IPADDR -bmanagement $IPADDR -Djboss.node.name=$HOSTNAME

#if our master server fails somehow, we need to leave the container alive.
#The routine below is written to keep the container alive
for (( ; ; ))
do
   sleep 10000
done
