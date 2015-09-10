#!/bin/bash

exec /usr/sbin/sshd -D >> /dev/null &
su - jboss -c "/opt/jboss/jon/rhq-agent/bin/rhq-agent-wrapper.sh start"

IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')

su - jboss -c " /opt/jboss/dv/jboss-eap-6.3/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 --debug 8787"
