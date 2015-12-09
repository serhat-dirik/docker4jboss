#!/bin/bash
IMAGE=docker-registry.usersys.redhat.com/docker4jboss/jon3-server
#Build
echo "Building image $IMAGE"
docker build --force-rm=true --rm=true -t $IMAGE .
#Compress
echo "Compressing image $IMAGE"
docker run -d --name tcnt $IMAGE
docker export tcnt | docker import - timg:latest
docker stop tcnt
docker rm tcnt

mkdir -p /tmp/timg
echo 'FROM timg' > /tmp/timg/Dockerfile
cat Dockerfile | grep -E '(^\s*(ENV|CMD|EXPOSE|VOLUME|USER|MAINTAINER|LABEL|ENTRYPOINT|ONBUILD)\s+)' >> /tmp/timg/Dockerfile
cd /tmp/timg
docker build --force-rm=true -t $IMAGE .
rm -rf /tmp/timg
docker rmi timg
echo "Cleaning up temporary images for you"
for i in ` docker images|grep \<none\>|awk '{print $3}'`;do docker stop $i; docker rm $i; docker rmi $i;done
