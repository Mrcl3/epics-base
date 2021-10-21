FROM debian:buster-slim

RUN apt-get update \
## install dependencies of EPICS
      && apt-get install -qqy --no-install-recommends \
        build-essential \
        libncurses-dev \
        libreadline-dev \
        git \
## clean up apt's cache
      && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt \
## create directories for epics
      && mkdir /epics \
      && mkdir /epics/base \
      && mkdir /epics/src \
## turn off the detached message from git and SSL verification
      && git config --global advice.detachedHead false \
      && git config --global http.sslVerify false \
## download sources and build Epics base
      && git clone --recursive --branch R7.0.3.1 --depth 1 https://git.launchpad.net/epics-base /epics/src/base \
      && cd /epics/src/base \
      && export EPICS_HOST_ARCH=$(/epics/src/base/startup/EpicsHostArch) \
      && echo "INSTALL_LOCATION=/epics/base" > configure/CONFIG_SITE.local \
      && make -j \
      && echo "/epics/base/lib/${EPICS_HOST_ARCH}" > /etc/ld.so.conf.d/epics.conf \
      && echo "export EPICS_HOST_ARCH=${EPICS_HOST_ARCH}" > /etc/profile.d/epics.sh \
      && echo "export PATH=\${PATH}:/epics/base/bin/${EPICS_HOST_ARCH}" >> /etc/profile.d/epics.sh \
      && ldconfig \
## delete sources
      && cd /epics \
      && rm -rf /epics/src/base

EXPOSE 5064-5065 5064-5065/udp 5075 5076/udp

CMD ["/bin/bash"]

