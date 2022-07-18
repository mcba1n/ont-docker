FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && apt install -y git libbz2-dev liblzma-dev libcunit1 libopenblas-base cmake parallel ca-certificates apt-utils gcc make curl python3
RUN apt-get install python3-pip wget -y 
RUN pip3 install torch && pip3 install h5py && pip3 install numpy && pip3 install dtw-python && pip3 install virtualenv

# install CUDA 11.3 for Ubuntu 20.04
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    wget https://developer.download.nvidia.com/compute/cuda/11.3.0/local_installers/cuda-repo-ubuntu2004-11-3-local_11.3.0-465.19.01-1_amd64.deb && \
    dpkg -i cuda-repo-ubuntu2004-11-3-local_11.3.0-465.19.01-1_amd64.deb && \
    apt-key add /var/cuda-repo-ubuntu2004-11-3-local/7fa2af80.pub && \
    apt-get update && \
    apt-get -y install cuda

# install Bonito from source
RUN git clone https://github.com/nanoporetech/bonito.git && \
    cd bonito && \
    virtualenv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    python setup.py develop
