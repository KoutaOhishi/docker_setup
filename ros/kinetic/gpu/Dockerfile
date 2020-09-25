FROM tiryoh/ros-desktop-vnc:kinetic

LABEL maintainer="Kota Oishi<bigbasketball568@yahoo.co.jp>"

#create catkin_ws
RUN echo "### create catkin_ws ###"
RUN mkdir -p /home/ubuntu/catkin_ws/src
RUN cd /home/ubuntu/catkin_ws/src && \
	/bin/bash -c /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_init_workspace"
RUN cd /home/ubuntu/catkin_ws/ && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"

RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc &&\
	echo "source /home/ubuntu/catkin_ws/devel/setup.bash" >> ~/.bashrc &&\
	echo "export ROS_PACKAGE_PATH=\${ROS_PACKAGE_PATH}:/home/ubuntu/catkin_ws" >> ~/.bashrc &&\
	echo "export ROS_WORKSPACE=/home/ubuntu/catkin_ws" >> ~/.bashrc

#set to the same Gateway or DNS server as the host pc
#RUN echo "nameserver 150.37.224.1" >> /etc/resolv.conf 

#install apps
RUN apt update
RUN apt install -y iputils-ping #install ping

#install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python2 get-pip.py
RUN pip install -U pip

RUN echo "### Build OpenCV ###"
ARG OPENCV_VERSION="3.4.2"

# Build tools
RUN apt update && \
    apt install -y \
    sudo \
    tzdata \
    git \
    cmake \
    wget \
    unzip \
    build-essential

# Media I/O:
RUN apt install -y \
    zlib1g-dev \
    libjpeg-dev \
    libwebp-dev \
    libpng-dev \
    libtiff5-dev \
    libopenexr-dev \
    libgdal-dev \
    libgtk2.0-dev

# Video I/O:
RUN apt install -y \
    libdc1394-22-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtheora-dev \
    libvorbis-dev \
    libxvidcore-dev \
    libx264-dev \
    yasm \
    libopencore-amrnb-dev \
    libopencore-amrwb-dev \
    libv4l-dev \
    libxine2-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    ffmpeg

# Parallelism and linear algebra libraries:
RUN apt install -y \
    libtbb-dev \
    libeigen3-dev

RUN cd /home/ubuntu/ &&\
    git clone https://github.com/opencv/opencv.git &&\
    cd opencv &&\ 
    git checkout ${OPENCV_VERSION} &&\
    cd /home/ubuntu/ &&\
    git clone https://github.com/opencv/opencv_contrib.git &&\
    cd opencv_contrib &&\
    git checkout ${OPENCV_VERSION} &&\
    cd /home/ubuntu/opencv &&\
    mkdir build &&\
    cd build &&\
    cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=/home/ubuntu/opencv_contrib/modules \
    .. &&\
    make && make install 
RUN rm -rf /home/ubuntu/opencv && rm -rf /home/ubuntu/opencv_contrib

RUN echo "### Build OpenCV SUCCESS ###"

RUN echo "### Install CUDA & cuDNN ###"
#ARG CUDA_VERSION="8.0"
#ARG CUDNN_VERSION="6.0"
RUN apt update && apt install -y --no-install-recommends ca-certificates apt-transport-https gnupg-curl && \
    rm -rf /var/lib/apt/lists/* && \
    NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list

ENV CUDA_VERSION 8.0.61
ENV CUDA_PKG_VERSION 8-0=$CUDA_VERSION-1
LABEL com.turlucode.ros.cuda="${CUDA_VERSION}"

## CUDA Runtime-packages
RUN apt update && apt install -y --no-install-recommends \
        cuda-nvrtc-$CUDA_PKG_VERSION \
        cuda-nvgraph-$CUDA_PKG_VERSION \
        cuda-cusolver-$CUDA_PKG_VERSION \
        cuda-cublas-8-0=8.0.61.2-1 \
        cuda-cufft-$CUDA_PKG_VERSION \
        cuda-curand-$CUDA_PKG_VERSION \
        cuda-cusparse-$CUDA_PKG_VERSION \
        cuda-npp-$CUDA_PKG_VERSION \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-8.0 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

### nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
#ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_DRIVER_CAPABILITIES all
ENV NVIDIA_REQUIRE_CUDA "cuda>=8.0"

## CUDA Devel-packages
RUN apt update && apt install -y --no-install-recommends \
        cuda-core-$CUDA_PKG_VERSION \
        cuda-misc-headers-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION \
        cuda-nvrtc-dev-$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_PKG_VERSION \
        cuda-nvgraph-dev-$CUDA_PKG_VERSION \
        cuda-cusolver-dev-$CUDA_PKG_VERSION \
        cuda-cublas-dev-8-0=8.0.61.2-1 \
        cuda-cufft-dev-$CUDA_PKG_VERSION \
        cuda-curand-dev-$CUDA_PKG_VERSION \
        cuda-cusparse-dev-$CUDA_PKG_VERSION \
        cuda-npp-dev-$CUDA_PKG_VERSION \
        cuda-cudart-dev-$CUDA_PKG_VERSION \
        cuda-driver-dev-$CUDA_PKG_VERSION && \
    rm -rf /var/lib/apt/lists/*




#clean cache
RUN rm -rf /var/lib/apt/lists/
RUN apt clean

######### initial position ##########
WORKDIR /home/ubuntu/
