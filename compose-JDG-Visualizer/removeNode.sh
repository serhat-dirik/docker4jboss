#!/bin/bash

if  [ -z "$1" ];  then
  echo "sh removeNode.sh nodeName"
  exit
fi
docker stop $1
docker rm $1
echo Done!
