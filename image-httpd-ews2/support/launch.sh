#/bin/bash

exec /usr/sbin/sshd -D >> /dev/null &

# Get the IP address
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')

# Adjust the IP addresses in the mod_cluster.conf file
sed -i "s|[0-9\.\*]*:80|$IPADDR:80|g" /opt/apache/jboss-ews-2.1/httpd/conf.d/mod_cluster.conf

# Run Apache
/opt/apache/jboss-ews-2.1/httpd/sbin/apachectl start

#The routine below is written to keep the container alive
while true; do  echo -e "Enter  exit to stop container :"; read value; if [ $value = "exit" ];then break; fi;  done
