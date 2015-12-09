#!/bin/bash

echo "Removing host names"
for container in rhqserver httpdserver eap-slave2 eap-slave1 eap-master; do
  echo clearing $container
  cstate=$(docker inspect -f {{.State.Running}} $container)
  if  [ -z "$cstate" ] || [ ! $cstate ]  ;  then   continue; fi
  c_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container )
  c_ip_esc="$(echo "$c_ip" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
  sudo bash -c "sed -i -e '/^$c_ip_esc/ d' /etc/hosts"
done
echo "Destroying Containers"
docker-compose stop
docker-compose rm -f
echo docker ps
docker ps
