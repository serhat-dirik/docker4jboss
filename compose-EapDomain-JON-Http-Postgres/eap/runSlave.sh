#!/bin/bash
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')

/opt/jboss/jon/rhq-agent/bin/rhq-agent-wrapper.sh start
$JBOSS_HOME/bin/domain.sh  -b $IPADDR -bmanagement $IPADDR  -Djboss.domain.master.address=eap-master
