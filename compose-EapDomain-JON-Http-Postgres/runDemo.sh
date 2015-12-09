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
docker run -d --name rhqserver --hostname rhqserver --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/jon3-server /bin/bash -c "/opt/jboss/jon/startJON.sh"
echo Starting HTTPD ....
docker run -d --name httpdserver --privileged --hostname httpdserver --link rhqserver:rhqserver -v $(pwd)/apache:/apacheConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/httpd-ews2 /bin/bash -c "/apacheConfig/setup.sh"
echo Starting EAP Master...
docker run -d --name eap-master --privileged --hostname eap-master --link rhqserver:rhqserver -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/eap6 /bin/bash -c "/eapConfig/setupMaster.sh"
echo Starting EAP Slave1...
docker run -d --name eap-slave1 --privileged --hostname eap-slave1 --link rhqserver:rhqserver -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/eap6 /bin/bash -c "/eapConfig/setupSlave.sh"
echo Starting EAP Slave2...
docker run -d --name eap-slave2 --privileged --hostname eap-slave2 --link rhqserver:rhqserver -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/eap6 /bin/bash -c "/eapConfig/setupSlave.sh"
echo 'Provisioning is done, adding host names !'
for container in rhqserver httpdserver eap-slave2 eap-slave1 eap-master ; do
  cstate=$(docker inspect -f {{.State.Running}} $container)
  if  [ -z "$cstate" ] || [ ! $cstate ]  ;  then   continue; fi
  c_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container )
  sudo bash -c "echo $c_ip $container >> /etc/hosts"
done
echo Done!
