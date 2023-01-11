# nvidia-l4t-base-cuda
A ready to go nvidia jetson linux for tegra cuda enabled image && container generator.
There is also a separate "plex" branch for those of you who wish to use this container for that purpose. Please be warned that I have not been able to successfully harness the GPU of Jetson Nano to power plex transcoding, which happened to be the goal of this project. However in the process I ended up creating some automation scripts so someone can perhaps build upon in the future. Anywho, if you wish to be a colloborator on the project feel free to rech out.

# Setup
Just run the ./create-container.sh file in order to build the docker image and the container.

# References

https://github.com/NVIDIA/nvidia-docker/wiki/NVIDIA-Container-Runtime-on-Jetson

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/user-guide.html

https://catalog.ngc.nvidia.com/orgs/nvidia/containers/l4t-base

https://gitlab.com/nvidia/container-images/l4t-base/-/tree/master/

https://repo.download.nvidia.com/jetson/

https://wiki.archlinux.org/title/Plex

https://stackoverflow.com/questions/60485743/how-to-use-docker-entrypoint-with-shell-script-file-combine-parameter

https://stackoverflow.com/questions/71878197/what-are-arg-and-label-in-a-dockerfile

https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3261/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/multimedia.html#wwpID0E0GC0HA

https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3261/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/multimedia.html#wwpID0EQHA

https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3261/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/accelerated_gstreamer.html#wwpID0E0R40HA

https://repo.download.nvidia.com/jetson/

https://gitlab.com/nvidia/container-images/l4t-base
