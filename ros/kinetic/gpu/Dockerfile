ARG cuda_version=9.0
ARG cudnn_version=7
ARG distribution=ubuntu16.04
ARG tensorflow-gpu_version=1.12.0

FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel-${distribution}

LABEL maintainer="Kota Oishi<bigbasketball568@yahoo.co.jp>"

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

#install apps
RUN apt-get update &&\
    apt-get install --assume-yes apt-utils 
RUN apt-get install -y \
            iputils-ping #install ping \
            wget \
	    git \
	    libhdf5-dev \
	    g++ 

#install curl
RUN apt-get update &&\
    apt-get install -y curl
    

# install python
RUN apt-get update &&\
    apt-get install -y python2.7

#install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python2.7 get-pip.py
RUN pip install -U pip

#install tensorflow & keras
RUN pip install tensorflow-gpu==${tensorflow-gpu_version} &&\
    pip install keras

#clean cache
RUN rm -rf /var/lib/apt/lists/
RUN apt-get clean

######### initial position ##########
WORKDIR /home/ubuntu/
