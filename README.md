# nvidia-l4t-base-plex
Running Plex Media Server on Nvidia L4T (Linux for Tegra)  docker container.


# Setup

After running the create-container.sh file successfully, follow the below steps.

Run the plex-start.sh file located at "/" inside the docker container.

To begin configuring the Plex Media Server, browse to http://localhost:32400/web/.

To configure Plex Media Server remotely, you can first create an SSH tunnel (setup can only be done from localhost)

$ ssh ip.address.of.server -L 8888:localhost:32400
and then browse to http://localhost:8888/web/.
