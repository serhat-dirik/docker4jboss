#!/bin/bash

sudo cp -r -a /eapConfig/slave/configuration/*  $HOME/eap/jboss-eap-6.4/domain/configuration
sudo cp -a /eapConfig/*Slave.sh $HOME/eap/jboss-eap-6.4/domain
sudo chown -R jboss:jboss $HOME/eap/jboss-eap-6.4/domain
LOCAL_NAME=$(cat /etc/hostname)
sudo sed -i -e "s/^<host name=.*/<host name=\"$LOCAL_NAME\" xmlns=\"urn:jboss:domain:1.7\"> /" $HOME/eap/jboss-eap-6.4/domain/configuration/host.xml
#######
#change agent config
_HOST_NAME="$(cat /etc/hostname)"
_RHQSERVER_IP="$(cat /etc/hosts|grep rhqserver|sed -n '1p'|cut -d$'\t' -f1)"
_RHQSERVER_IP_ESC="$(echo "$_RHQSERVER_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
sed -i -e "s/<entry key=\"rhq\.agent\.server\.bind-address\".*/<entry key=\"rhq\.agent\.server\.bind-address\" value=\"$_RHQSERVER_IP_ESC\"\/>  /" /opt/jboss//jon/rhq-agent/conf/agent-configuration.xml

#########
sh $HOME/eap/jboss-eap-6.4/domain/runSlave.sh
#if our master server fails somehow, we need to leave the container alive.
#The routine below is written to keep the container alive
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
