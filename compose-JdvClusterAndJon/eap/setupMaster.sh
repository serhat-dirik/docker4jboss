#!/bin/bash
export MAVEN_VERSION=3.2.5
export JAVA_HOME=/usr/lib/jvm/java
export M2_HOME=/usr/share/maven
export JBOSS_HOME=/opt/jboss/eap/jboss-eap-6.4
export RHQ_JAVA_HOME=$JAVA_HOME
echo $JBOSS_HOME
whoami
sudo cp -r -a /eapConfig/master/configuration/*  $JBOSS_HOME/domain/configuration
sudo cp -a /eapConfig/*Master.sh $JBOSS_HOME/domain
sudo chown -R jboss:jboss $JBOSS_HOME/domain
#######
#change agent config
_HOST_NAME="$(cat /etc/hostname)"
_RHQSERVER_IP="$(cat /etc/hosts|grep rhq-server|sed -n '1p'|cut -d$'\t' -f1)"
_RHQSERVER_IP_ESC="$(echo "$_RHQSERVER_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
sed -i -e "s/<entry key=\"rhq\.agent\.server\.bind-address\".*/<entry key=\"rhq\.agent\.server\.bind-address\" value=\"$_RHQSERVER_IP_ESC\"\/>  /" /opt/jboss/jon/rhq-agent/conf/agent-configuration.xml

sh $JBOSS_HOME/domain/runMaster.sh
#if our master server fails somehow, we need to leave the container alive.
#The routine below is written to keep the container alive

for (( ; ; ))
do
   sleep 10000
done
