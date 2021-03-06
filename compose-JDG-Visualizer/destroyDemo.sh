#!/bin/bash

for container in rhq-server eap-server jdg-node1 jdg-node2; do
  echo clearing $container
  cstate=$(docker inspect -f {{.State.Running}} $container)
  if  [ -z "$cstate" ] || [ ! $cstate ]  ;  then   continue; fi
  c_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container )
  c_ip_esc="$(echo "$c_ip" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
  sudo bash -c "sed -i -e '/^$c_ip_esc/ d' /etc/hosts"
  docker stop $container
  docker kill $container >> /dev/null 2>&1
  docker rm   $container
done

echo docker ps
docker ps
