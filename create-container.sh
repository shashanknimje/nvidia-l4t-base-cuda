#!/bin/sh

docker build -t l4t-base-cuda ./ && \
docker-compose up -d
