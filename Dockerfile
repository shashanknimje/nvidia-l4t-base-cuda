FROM nvcr.io/nvidia/l4t-base:r32.7.1

ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8"

COPY ./plex-start.sh /plex-start.sh

RUN \

# Update and upgrade all packages
    apt update && \
    apt dist-upgrade -y \
    && \
    \

# Update and get dependencies
    apt update && \
    apt install -y \
      curl \
      apt-transport-https \
      gnupg \
      less \
      neovim \
    && \
    \

# Fetch and install plexmediaserver
    curl https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add - && \
    echo deb https://downloads.plex.tv/repo/deb public main | tee /etc/apt/sources.list.d/plexmediaserver.list && \
    \

    apt update && \
    apt install -y \
      plexmediaserver \
    && \
    \

# Add user
#    useradd -U -d /config -s /bin/false plex && \
#    usermod -G users plex && \
#    \

# Setup directories
    mkdir -p \
      /config \
      /transcode \
      /data \
    && \
    \

# Cleanup
    apt -y autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

EXPOSE 32400/tcp 8324/tcp 32469/tcp 1900/udp 32410/udp 32412/udp 32413/udp 32414/udp

VOLUME /config /transcode /data

CMD ["source /plex-start.sh"]




#CMD ["/bin/bash"]

# When you do docker run with bash as the command, the init system (e.g. SystemD) doesn’t get started (nor does your start script, since the command you pass overrides the CMD in th
e Dockerfile). Try to change the command you use to /sbin/init, start the container in daemon mode with -d, and then look around in a shell using docker exec -it <container id> sh.

#CMD ["/usr/sbin/init"]

#COPY docker-systemctl-replacement/files/systemctl3.py /usr/bin/systemctl
#COPY docker-systemctl-replacement/files/journalctl3.py /usr/bin/journalctl

#RUN test -L /bin/systemctl || ln -sf /usr/bin/systemctl /bin/systemctl
#RUN test -L /bin/journalctl || ln -sf /usr/bin/journalctl /bin/journalctl

#CMD ["/usr/bin/systemctl"]
