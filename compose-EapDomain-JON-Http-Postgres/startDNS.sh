#!/bin/bash
docker run --name dns -d -v /var/run/docker.sock:/docker.sock phensley/docker-dns  --domain example.com
