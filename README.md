#  Scrappie using Docker
A quick guide to setup a work environment for Scrappie and Scrappie Python. Since this software is native to Linux-based systems, we will use [Docker](https://www.docker.com/get-started) to create a lightweight Virtual Machine (VM) that runs on MacOS and Windows. Though this guide is focused on MacOS, analogous Docker commands may be used for Windows.

## Dockerfile
The Dockerfile was inspired from `https://github.com/nanoporetech/scrappie/blob/master/docker/ubuntu/ubuntu_18_04/Dockerfile`, and then modified to include python3, pip3, and Scrappie Python.
Hence, the Docker environment will be ready to run the Pythonised version of Scrappie at startup.

```
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
```


## Build
Go to the directory with the downloaded Dockerfile and build the Docker container.

```bash
docker build . -t scrappie
```

## Run
Run your Docker container.

```bash
docker run -it scrappie
```

If you want to run Scrappie core, go to `/scrappie/build/` and run it with `./scrappie` (rather than `scrappie` as used in the official Scrappie demos). To run a Python script using Scrappie Python, see the next section.

## Mount
You will want to mount a folder from your native OS to the Docker container so that you can bidirectionally transfer data by a shared folder. Specify the directory of a folder to share, relative to your current working directory `${PWD}`, and a directory in your Docker container to be coupled with.

```bash
docker run -it -v ${PWD}/path/to/shared/folder:/data scrappie
```

For example, `${PWD}/path/to/shared/folder` in your native OS is coupled with `/data` in the Docker container.


## Alias
To save time for run and mount, you can create an alias `scrappie` in your bash profile.

1. Open your bash profile. 
```bash
  open ~/.bash_profile
```

2. Append the following line to the file and save.
```bash
alias scrappie="docker run -it -v ${PWD}/path/to/shared/folder:/data scrappie"
```

3. Reload your bash profile.
```bash
source ~/.bash_profile
```
From now on, just open Docker and run command `scrappie` in your native OS.


---

# Flappie using Docker
Follow the previous instructions using Dockerfile from `flappie/` instead. The Docker container allows you to run Flappie core by command `flappie` as in the official demos.

## Dockerfile
```
FROM ubuntu:16.04
RUN apt update && apt install -y git libcunit1 libopenblas-base cmake libcunit1-dev libhdf5-dev libopenblas-dev parallel ca-certificates apt-utils gcc make curl
ENV PATH="/flappie:${PATH}"
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && apt install git-lfs && git clone https://github.com/nanoporetech/flappie --branch v1.1.0 && cd flappie && git lfs install && make flappie
SHELL ["/bin/bash", "-ce"]
```

---

# Bonito using Docker
A Dockerfile to install the Bonito basecaller in `https://github.com/nanoporetech/bonito` from source. Beware that the Docker image will use around 12GB.

## Dockerfile
```
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
```
Enter the virtual environment with `. venv/bin/activate` while inside `/bonito`, and then the `bonito` command will be available as in their documentation. 
