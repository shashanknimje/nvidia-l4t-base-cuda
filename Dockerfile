FROM nvcr.io/nvidia/l4t-base:r32.7.1

ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8"

ARG DEBIAN_FRONTEND=noninteractive
ARG CUDA="10.2"
ARG RELEASE="r32.7"

# Setup directories, and copy & make shell script executable
COPY ./plex-entrypoint.sh /
RUN mkdir -p \
    /config \
    /transcode \
    /data \
    /usr/local/cuda && \
    chmod +x /plex-entrypoint.sh

# Update & upgrade all packages, and get dependencies
RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y \
    apt-utils \
    man-db \
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
#    echo "deb https://repo.download.nvidia.com/jetson/ffmpeg main main" | tee -a /etc/apt/sources.list && \
#    echo "deb-src https://repo.download.nvidia.com/jetson/ffmpeg main main" | tee -a /etc/apt/sources.list

# Install CUDA runtime libraries, ffmpeg, and Gstreamer
COPY ./usr/local/cuda/samples /usr/local/cuda/
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

# Fetch and install plexmediaserver
RUN curl https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add - && \
    echo deb https://downloads.plex.tv/repo/deb public main | tee /etc/apt/sources.list.d/plexmediaserver.list && \
    apt-get update && \
    apt-get install -y \
    plexmediaserver 

# Add user
# RUN useradd -U -d /config -s /bin/false plex && \
# usermod -G users plex 

# Cleanup
RUN apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

EXPOSE 32400/tcp 8324/tcp 32469/tcp 1900/udp 32410/udp 32412/udp 32413/udp 32414/udp

VOLUME /config /transcode /data

ENTRYPOINT ["/plex-entrypoint.sh"]

CMD ["/bin/bash"]


#CMD ["/bin/bash"]

# When you do docker run with bash as the command, the init system (e.g. SystemD) doesn’t get started (nor does your start script, since the command you pass overrides the CMD in the Dockerfile). Try to change the command you use to /sbin/init, start the container in daemon mode with -d, and then look around in a shell using docker exec -it <container id> sh.

#CMD ["/usr/sbin/init"]

#COPY docker-systemctl-replacement/files/systemctl3.py /usr/bin/systemctl
#COPY docker-systemctl-replacement/files/journalctl3.py /usr/bin/journalctl

#RUN test -L /bin/systemctl || ln -sf /usr/bin/systemctl /bin/systemctl
#RUN test -L /bin/journalctl || ln -sf /usr/bin/journalctl /bin/journalctl

#CMD ["/usr/bin/systemctl"]
