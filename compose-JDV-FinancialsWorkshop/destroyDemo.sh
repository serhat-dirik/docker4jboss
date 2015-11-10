#!/bin/bash

for container in dv6-server postgres-server dns; do
  echo clearing $container
  docker stop $container
  docker kill $container
  docker rm   $container
done

echo docker ps
docker ps
