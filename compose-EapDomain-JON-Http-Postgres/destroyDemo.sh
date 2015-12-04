#!/bin/bash

for container in rhqserver httpdserver eap-slave2 eap-slave1 eap-master dns; do
  echo clearing $container
#  c_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container )
#  c_ip_esv="$(echo "$c_ip" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
#  sudo bash -c "sed -i -e '/^$c_ip/ d' /etc/hosts"
  docker stop $container
  docker kill $container >> /dev/null 2>&1
  docker rm   $container
done

echo docker ps
docker ps
