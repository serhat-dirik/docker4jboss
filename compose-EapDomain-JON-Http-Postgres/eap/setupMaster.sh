#!/bin/bash

sudo cp -r -a /eapConfig/master/configuration/*  $HOME/eap/jboss-eap-6.4/domain/configuration
sudo cp -a /eapConfig/*Master.sh $HOME/eap/jboss-eap-6.4/domain
sudo chown -R jboss:jboss $HOME/eap/jboss-eap-6.4/domain
#######
#change agent config
_HOST_NAME="$(cat /etc/hostname)"
_RHQSERVER_IP="$(cat /etc/hosts|grep rhqserver|sed -n '1p'|cut -d$'\t' -f1)"
_RHQSERVER_IP_ESC="$(echo "$_RHQSERVER_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
sed -i -e "s/<entry key=\"rhq\.agent\.server\.bind-address\".*/<entry key=\"rhq\.agent\.server\.bind-address\" value=\"$_RHQSERVER_IP_ESC\"\/>  /" /opt/jboss//jon/rhq-agent/conf/agent-configuration.xml

#########
#change domain.xml
  _SLAVE1_IP=$(ping -c 1 eap-slave1.example.com|grep "64 bytes"|sed 's/64 bytes from //'|cut -d':' -f1)
  _SLAVE2_IP=$(ping -c 1 eap-slave2.example.com|grep "64 bytes"|sed 's/64 bytes from //'|cut -d':' -f1)
  _SLAVE1_IP_ESC="$(echo "$_SLAVE1_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
  _SLAVE2_IP_ESC="$(echo "$_SLAVE2_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"

echo s1 ip : "$_SLAVE1_IP s1 ip esc: $_SLAVE1_IP_ESC s2 ip: $_SLAVE2_IP s2 ip esc: $_SLAVE2_IP_ESC" > /tmp/ip.txt

#for (( ; ; ${#_SLAVE1_IP_ESC} > 5 ))
#do
#  _SLAVE1_IP=$(ping -c 1 eap-slave1.example.com|grep "64 bytes"|sed 's/64 bytes from //'|cut -d':' -f1)
#  _SLAVE2_IP=$(ping -c 1 eap-slave2.example.com|grep "64 bytes"|sed 's/64 bytes from //'|cut -d':' -f1)
#  _SLAVE1_IP_ESC="$(echo "$_SLAVE1_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
#  _SLAVE2_IP_ESC="$(echo "$_SLAVE2_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
#   sleep 10000
#done
#
#echo s1 ip : "$_SLAVE1_IP s1 ip esc: $_SLAVE1_IP_ESC s2 ip: $_SLAVE2_IP s2 ip esc: $_SLAVE2_IP_ESC" > /tmp/ip.txt
#sed -i -e "s/eap-slave1\.example\.com/$_SLAVE1_IP_ESC/" /opt/jboss/eap/jboss-eap-6.4/domain/configuration/domain.xml
#sed -i -e "s/eap-slave2\.example\.com/$_SLAVE2_IP_ESC/" /opt/jboss/eap/jboss-eap-6.4/domain/configuration/domain.xml



sh $HOME/eap/jboss-eap-6.4/domain/runMaster.sh
#if our master server fails somehow, we need to leave the container alive.
#The routine below is written to keep the container alive
for (( ; ; ))
do
   sleep 10000
done
