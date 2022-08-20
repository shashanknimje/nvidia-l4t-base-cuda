#!/bin/sh

# This file needs to be sourced. As in run it like so, "source ./plex-start.sh"

export PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/var/lib/plexmediaserver/Library/Application Support"
export PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver"
export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6

/usr/bin/test -d "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}" || /bin/mkdir -p "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}"

export PLEX_MEDIA_SERVER_INFO_VENDOR="$(grep ^NAME= /etc/os-release | awk -F= "{print \$2}" | tr -d \")"
export PLEX_MEDIA_SERVER_INFO_DEVICE="PC"
export PLEX_MEDIA_SERVER_INFO_MODEL="$(uname -m)"
export PLEX_MEDIA_SERVER_INFO_PLATFORM_VERSION="$(grep ^VERSION= /etc/os-release | awk -F= "{print \$2}" | tr -d \")"
exec "/usr/lib/plexmediaserver/Plex Media Server"

# This is required in order to pass the execution to the CMD arguement at the end of the Dockerfile.
exec "$@"
