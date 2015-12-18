#!/bin/bash
sudo /usr/sbin/sshd -D >> /dev/null &
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
$JDG_HOME/bin/standalone.sh -b $IPADDR -bmanagement $IPADDR --debug 8787
