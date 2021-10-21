### docker-cepics-base


This repository contains the Dockerfile to create the image via the github workflow:

* [mbajdel/epics-base][] on Docker Hub
    * **EPICS Base** 7.0.4 in a Docker container

## epics-base

The epics\_base image contains a the EPICS base installation.

To start the example IOC in background (-d), run:

```bash
docker run \
  --rm -it -d \
  --name my-ioc \
  mbajdel/epics-base:latest
```

To attach to the IOC shell, run:

    docker attach my-ioc

Enter <kbd>Ctrl + p</kbd> <kbd>Ctrl + q</kbd> to detach from the shell or <kbd>Ctrl + d</kbd> to quit the IOC.


