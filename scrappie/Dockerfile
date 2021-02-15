FROM ubuntu:18.04
RUN apt update && apt install -y git libcunit1 libopenblas-base cmake libcunit1-dev libhdf5-dev libopenblas-dev parallel ca-certificates apt-utils gcc make curl python3
RUN apt-get install python3-pip -y
RUN pip3 install scrappie && pip3 install fast5_research && pip3 install h5py && pip3 install numpy && pip3 install dtw-python
RUN git clone --depth 1 https://github.com/nanoporetech/scrappie.git

RUN cd scrappie && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make test
