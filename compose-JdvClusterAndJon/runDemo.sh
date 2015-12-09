#!/bin/bash
CSTATE=$(docker inspect -f {{.State.Running}} docker-dns)

if  [ -z "$CSTATE" ];  then
  docker run --privileged --name docker-dns --hostname docker-dns -d -v /var/run/docker.sock:/docker.sock  phensley/docker-dns  --domain docker;
elif [! $CSTATE  ]; then
  docker start docker-dns
fi
CSTATE=$(docker inspect -f {{.State.Running}} docker-dns)
echo "Is docker-dns started ? $CSTATE"
if  ! $CSTATE  ;  then   exit 1; fi

_DNS_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' docker-dns)
echo Starting JON - RHQServer...
docker run --privileged -d --name rhq-server --hostname rhq-server --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/jon3-server /bin/bash -c "/opt/jboss/jon/startJON.sh"
echo Starting HTTPD ....
docker run --privileged -d --name httpd-server --hostname httpd-server --link rhq-server:rhq-server -v $(pwd)/apache:/apacheConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/httpd-ews2 /bin/bash -c "/apacheConfig/setup.sh"
echo Starting DV Master...
docker run --privileged -d --name dv-master --hostname dv-master --link rhq-server:rhq-server -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/dv6 /bin/bash -c "/eapConfig/setupMaster.sh"
echo Starting DV Slave1...
docker run --privileged -d --name dv-slave1 --hostname dv-slave1 --link rhq-server:rhq-server -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/dv6 /bin/bash -c "/eapConfig/setupSlave.sh"
echo Starting DV Slave2...
docker run --privileged -d --name dv-slave2 --hostname dv-slave2 --link rhq-server:rhq-server -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search docker docker-registry.usersys.redhat.com/docker4jboss/dv6 /bin/bash -c "/eapConfig/setupSlave.sh"
#echo 'Provisioning is done, adding host names !'
for container in rhq-server httpd-server dv-slave2 dv-slave1 dv-master ; do
  cstate=$(docker inspect -f {{.State.Running}} $container)
  if  [ -z "$cstate" ] || [ ! $cstate ]  ;  then   continue; fi
  c_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container )
  sudo bash -c "echo $c_ip $container >> /etc/hosts"
done
echo Done!
