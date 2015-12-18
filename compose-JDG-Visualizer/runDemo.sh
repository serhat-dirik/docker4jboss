#!/bin/bash
CSTATE=$(docker inspect -f {{.State.Running}} docker-dns)

if  [ -z "$CSTATE" ];  then
  docker run --privileged --name docker-dns --hostname docker-dns -d -v /var/run/docker.sock:/docker.sock  phensley/docker-dns  --domain docker;
elif [! $CSTATE  ]; then
  docker start docker-dns
fi
#docker run -d -v /var/run/docker.sock:/docker.sock --privileged --name docker-dns --hostname docker-dns crosbymichael/skydock -ttl 30 -environment dev -s /docker.sock -domain docker -name docker-dns
CSTATE=$(docker inspect -f {{.State.Running}} docker-dns)
echo "Is docker-dns started ? $CSTATE"
if  ! $CSTATE  ;  then   exit 1; fi

_DNS_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' docker-dns)
echo Starting JON -  RHQServer...
docker run -d --name rhq-server --hostname rhq-server --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/jon3-server /bin/bash -c "/opt/jboss/jon/startJON.sh"
echo Starting JDG Node1...
docker run -d --name jdg-node1 --privileged --hostname jdg-node1 --link rhq-server:rhq-server -v $(pwd)/jdg:/jdgConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/jdg6 /bin/bash -c "/jdgConfig/runDemo.sh"
echo Starting JDG Node2...
docker run -d --name jdg-node2 --privileged --hostname jdg-node2 --link rhq-server:rhq-server -v $(pwd)/jdg:/jdgConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/jdg6 /bin/bash -c "/jdgConfig/runDemo.sh"
echo Starting EAP ...
docker run -d --name eap-server --privileged --hostname eap-server --link rhq-server:rhq-server --link jdg-node1:jdg-node1 --link jdg-node2:jdg-node2 -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/eap6 /bin/bash -c "/eapConfig/runDemo.sh"

echo 'Provisioning is done, adding host names !'
for container in rhq-server eap-server jdg-node1 jdg-node2 ; do
  cstate=$(docker inspect -f {{.State.Running}} $container)
  if  [ -z "$cstate" ] || [ ! $cstate ]  ;  then   continue; fi
  c_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container )
  sudo bash -c "echo $c_ip $container >> /etc/hosts"
done
echo Done!
