FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies. 
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

ADD . /repo
WORKDIR /repo
RUN ./configure
RUN make -j8

RUN mkdir -p /deps
RUN ldd /repo/jimsh | tr -s '[:blank:]' '\n' | grep '^/' | xargs -I % sh -c 'cp % /deps;'

FROM ubuntu:20.04 as package

COPY --from=builder /deps /deps
COPY --from=builder /repo/jimsh /repo/jimsh
ENV LD_LIBRARY_PATH=/deps
