#!/bin/bash
docker run --name dns -d -v /var/run/docker.sock:/docker.sock phensley/docker-dns  --domain example.com
_DNS_IP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns)
_DNS_IP_ESC="$(echo "$_DNS_IP" | sed 's/[^-A-Za-z0-9_]/\\&/g')"
sed -i -e "s/dns:.*/dns: $_DNS_IP_ESC /" ./docker-compose.yml

docker-compose up -d
