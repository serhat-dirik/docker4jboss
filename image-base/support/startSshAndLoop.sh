#!/bin/bash
exec /usr/sbin/sshd -D >> /dev/null &
#The routine below is written to keep the container alive in daemon mode
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
