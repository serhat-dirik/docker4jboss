#!/bin/bash
sudo /usr/sbin/sshd -D >> /dev/null &
/opt/jboss/jon/rhq-agent/bin/rhq-agent-wrapper.sh start
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
$HOME/eap/jboss-eap-6.4/bin/domain.sh -b $IPADDR -bmanagement $IPADDR
