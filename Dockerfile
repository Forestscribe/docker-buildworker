# please follow docker best practices
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
# Dockerfile customizations for building GDP CI.

FROM        buildbot/buildbot-worker:master
MAINTAINER  Forestscribe Maintainers

# Switch to root to be able to install stuff
USER root

# This will make apt-get install without question
ARG         DEBIAN_FRONTEND=noninteractive

# Switch to root to be able to install stuff
USER root

# on debian postgresql sets default encoding to the one of the distro, so we need to force it for utf8
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.utf8

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common && \
    apt-get update && \
    apt-get install -y \
        gawk \
        wget \
        git \
        diffstat \
        unzip \
        texinfo \
        gcc-multilib \
        build-essential \
        chrpath \
        socat \
        libsdl1.2-dev \
        xterm && \
    \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    curl -o /usr/bin/oe-git-proxy http://git.yoctoproject.org/cgit.cgi/poky/plain/scripts/oe-git-proxy && \
    chmod a+x /usr/bin/oe-git-proxy && \
    rm -rf /var/lib/apt/lists/*

# Switch to regular user for security reasons
USER buildbot
