FROM nvcr.io/nvidia/l4t-base:r32.7.1

ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8"

ARG DEBIAN_FRONTEND=noninteractive
ARG CUDA="10.2"
ARG RELEASE="r32.7"

# Get apt utilities and man pages. You can comment this section out if you don't need those.
RUN apt-get update && apt-get install -y \
    apt-utils \
    man-db 

# Update & upgrade all packages, and get dependencies
RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y \
    gnupg2 \
    ca-certificates \
    curl \
    apt-transport-https \
    less \
    neovim

# Add apt source key and update the source list
COPY ./jetson-ota-public.key /etc/jetson-ota-public.key
RUN apt-key add /etc/jetson-ota-public.key && \
    echo "deb https://repo.download.nvidia.com/jetson/common $RELEASE main" >> /etc/apt/sources.list
# The below two sources have been commented out as they were creating issues in installing ffmpeg. It seems that the above jetson/common $RELEASE main repo also has ffmpeg, which installs successfully.
#    echo "deb https://repo.download.nvidia.com/jetson/ffmpeg main main" | tee -a /etc/apt/sources.list && \
#    echo "deb-src https://repo.download.nvidia.com/jetson/ffmpeg main main" | tee -a /etc/apt/sources.list

# Install CUDA runtime libraries, ffmpeg, and Gstreamer
RUN CUDAPKG=$(echo $CUDA | sed 's/\./-/'); \
    apt-get update && apt-get install -y \
	cuda-libraries-$CUDAPKG \
	cuda-nvtx-$CUDAPKG \
	cuda-libraries-dev-$CUDAPKG \
	cuda-minimal-build-$CUDAPKG \
	cuda-license-$CUDAPKG \
	cuda-command-line-tools-$CUDAPKG \
	ffmpeg \
	gstreamer1.0-tools gstreamer1.0-alsa \
	gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
	gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
	gstreamer1.0-libav \
        make \
	g++ && \
	ln -s /usr/local/cuda-$CUDA /usr/local/cuda 

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

# Cleanup
RUN apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

CMD ["/bin/bash"]
