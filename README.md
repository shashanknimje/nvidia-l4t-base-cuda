# nvidia-l4t-base-plex
Running Plex Media Server on Nvidia L4T (Linux for Tegra)  docker container.


# Setup

After running the create-container.sh file successfully, follow the below steps.

Run the plex-start.sh file located at "/" inside the docker container.

To begin configuring the Plex Media Server, browse to http://localhost:32400/web/.

To configure Plex Media Server remotely, you can first create an SSH tunnel (setup can only be done from localhost)

$ ssh ip.address.of.server -L 8888:localhost:32400
and then browse to http://localhost:8888/web/.

# References

https://github.com/NVIDIA/nvidia-docker/wiki/NVIDIA-Container-Runtime-on-Jetson
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/user-guide.html
https://catalog.ngc.nvidia.com/orgs/nvidia/containers/l4t-base
https://gitlab.com/nvidia/container-images/l4t-base/-/tree/master/
https://repo.download.nvidia.com/jetson/
https://wiki.archlinux.org/title/Plex
https://github.com/plexinc/pms-docker/blob/master/Dockerfile.arm64
https://github.com/plexinc/pms-docker/blob/master/docker-compose-host.yml.template

