#!/bin/bash
sudo /usr/sbin/sshd -D >> /dev/null &

su - mysql -c "mysqld --user=root"

#The routine below is written to keep the container alive
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
