#!/bin/bash

for container in rhq-server httpd-server dv-slave2 dv-slave1 dv-master dns; do
  echo clearing $container
  docker stop $container
  docker kill $container
  docker rm   $container
done

echo docker ps
docker ps
