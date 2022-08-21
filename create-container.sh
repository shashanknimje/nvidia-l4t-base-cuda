#!/bin/sh

docker build -t l4t-plex ./ && \
docker-compose up -d
