FROM ubuntu:16.04
RUN apt update && apt install -y git libcunit1 libopenblas-base cmake libcunit1-dev libhdf5-dev libopenblas-dev parallel ca-certificates apt-utils gcc make curl
ENV PATH="/flappie:${PATH}"
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt install git-lfs && git clone https://github.com/nanoporetech/flappie --branch v1.1.0 && cd flappie && git lfs install && make flappie
SHELL ["/bin/bash", "-ce"]