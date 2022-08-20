#!/bin/sh

# cuda samples will be included in the docker image in order to test if the nvidia-container-toolkit - nvidia-docker2 has been setup correctly. Thus allowing Tegra GPU passthrough to the docker container in question.
tar -xvzf ./cuda-samples.tar.gz

docker build -t l4t-plex ./ && \
docker-compose up -d
