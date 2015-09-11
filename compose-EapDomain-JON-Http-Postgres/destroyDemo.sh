#!/bin/bash

for container in rhqserver httpdserver eap-slave2 eap-slave1 eap-master dns; do
  echo clearing $container
  docker stop $container
  docker kill $container
  docker rm   $container
done

echo docker ps
docker ps
