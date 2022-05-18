FROM --platform=linux/amd64 ubuntu:20.04

## Install build dependencies.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

ADD . /repo
WORKDIR /repo
RUN ./configure
RUN make -j8
