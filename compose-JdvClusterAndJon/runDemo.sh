#!/bin/bash
echo Starting DNS...
docker run --privileged --name dns -d -v /var/run/docker.sock:/docker.sock phensley/docker-dns  --domain example.com
_DNS_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns)
echo Starting JON - RHQServer...
docker run --privileged -d --name rhq-server --hostname rhq-server --dns $_DNS_IP --dns-search example.com docker4jboss/jon3-server /bin/bash -c "/opt/jboss/jon/startJON.sh"
echo Starting HTTPD ....
docker run --privileged -d --name httpd-server --hostname httpd-server --link rhq-server:rhq-server -v $(pwd)/apache:/apacheConfig --dns $_DNS_IP --dns-search example.com docker4jboss/httpd-ews2 /bin/bash -c "/apacheConfig/setup.sh"
echo Starting DV Master...
docker run --privileged -d --name dv-master --hostname dv-master --link rhq-server:rhq-server -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search example.com docker4jboss/dv6 /bin/bash -c "/eapConfig/setupMaster.sh"
echo Starting DV Slave1...
docker run --privileged -d --name dv-slave1 --hostname dv-slave1 --link rhq-server:rhq-server -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search example.com docker4jboss/dv6 /bin/bash -c "/eapConfig/setupSlave.sh"
echo Starting DV Slave2...
docker run --privileged -d --name dv-slave2 --hostname dv-slave2 --link rhq-server:rhq-server -v $(pwd)/eap:/eapConfig --dns $_DNS_IP --dns-search example.com docker4jboss/dv6 /bin/bash -c "/eapConfig/setupSlave.sh"
#echo 'Provisioning is done, adding host names !'
for container in rhq-server httpd-server dv-slave2 dv-slave1 dv-master dns; do
  c_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container )
  #sudo bash -c "echo $c_ip $container >> /etc/hosts"
done
echo Done!
