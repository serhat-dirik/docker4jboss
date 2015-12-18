#!/bin/bash

if  [ -z "$1" ];  then
  echo "sh addNode.sh nodeName"
  exit
fi
#docker run -d -v /var/run/docker.sock:/docker.sock --privileged --name docker-dns --hostname docker-dns crosbymichael/skydock -ttl 30 -environment dev -s /docker.sock -domain docker -name docker-dns
CSTATE=$(docker inspect -f {{.State.Running}} docker-dns)
echo "Is docker-dns started ? $CSTATE"
if  ! $CSTATE  ;  then   exit 1; fi

_DNS_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' docker-dns)
echo Starting JDG Node1...
docker run -d --name $1 --privileged --hostname $1 --link rhq-server:rhq-server -v $(pwd)/jdg:/jdgConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/jdg6 /bin/bash -c "/jdgConfig/runDemo.sh"

echo Done!
