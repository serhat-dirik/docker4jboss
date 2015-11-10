#!/bin/bash
sudo /usr/sbin/sshd -D >> /dev/null &
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
$HOME/eap/jboss-eap-6.4/bin/standalone.sh -b $IPADDR -bmanagement 0.0.0.0 --debug 8787
