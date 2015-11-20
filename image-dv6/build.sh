#!/usr/bin/env bash
docker build  --force-rm=true --rm=true -t docker4jboss/dv6 .
docker-compress docker4jboss/dv6 ./Dockerfile
