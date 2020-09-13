FROM ubuntu:18.04
MAINTAINER Tim Massingham <tim.massingham@nanoporetech.com>
RUN apt-get update && apt-get install -y --no-install-recommends  \
    ca-certificates gcc git libopenblas-dev libhdf5-dev cmake make libcunit1-dev python3
RUN git clone --depth 1 https://github.com/nanoporetech/scrappie.git

RUN cd scrappie && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make test

RUN apt-get install python3-pip -y
RUN pip3 install scrappie