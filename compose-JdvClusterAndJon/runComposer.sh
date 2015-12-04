#!/bin/bash
docker run --privileged --name dns -d -v /var/run/docker.sock:/docker.sock phensley/docker-dns  --domain example.com
_DNS_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns)
_DNS_IP_ESC="$(echo "$_DNS_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
sed -i -e "s/dns:.*/dns: $_DNS_IP_ESC /" ./docker-compose.yml

docker-compose up -d

echo 'Provisioning is done, adding host names !'
for container in rhq-server httpd-server dv-slave2 dv-slave1 dv-master dns; do
  c_ip=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container )
  #sudo bash -c "echo $c_ip $container >> /etc/hosts"
done
