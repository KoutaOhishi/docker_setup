FROM tiryoh/ros-desktop-vnc:kinetic

LABEL maintainer="Kota Oishi<bigbasketball568@yahoo.co.jp>"

# Do NOT rewrite manually
ENV CUDA_VERSION 9.0.176
ENV CUDA_PKG_VERSION 9-0=$CUDA_VERSION-1
ENV NVIDIA_REQUIRE_CUDA "cuda>=9.0"
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all
ENV CUDNN_VERSION 7.6.4.38

#install apps
RUN apt-get update &&\
    apt-get install -y \
        apt-utils \
        iputils-ping \
        wget \
        git \
        libhdf5-dev \
        g++ \
        vim

#install curl
RUN apt-get update &&\
    apt-get install -y curl

#install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py
RUN pip install -U pip

##### nvidia driver setting #####
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates apt-transport-https gnupg-curl && \
    NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get purge --auto-remove -y gnupg-curl \
    && rm -rf /var/lib/apt/lists/*

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-$CUDA_PKG_VERSION \
    && ln -s cuda-9.0 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
LABEL com.nvidia.volumes.needed="nvidia_driver"
LABEL com.nvidia.cuda.version="${CUDA_VERSION}"
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-libraries-$CUDA_PKG_VERSION \
    cuda-npp-$CUDA_PKG_VERSION \
    cuda-cublas-9-0=9.0.176.4-1 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-nvml-dev-$CUDA_PKG_VERSION \
    cuda-command-line-tools-$CUDA_PKG_VERSION \
    cuda-npp-dev-$CUDA_PKG_VERSION \
    cuda-libraries-dev-$CUDA_PKG_VERSION \
    cuda-minimal-build-$CUDA_PKG_VERSION \
    cuda-core-9-0=9.0.176.3-1 \
    cuda-cublas-dev-9-0=9.0.176.4-1 \
    && rm -rf /var/lib/apt/lists/*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn7=$CUDNN_VERSION-1+cuda9.0 \
    libcudnn7-dev=$CUDNN_VERSION-1+cuda9.0 \
    && apt-mark hold libcudnn7 && \
    rm -rf /var/lib/apt/lists/*

##### finish nvidia driver setting #####

RUN echo "### Build OpenCV ###"
ARG OPENCV_VERSION="3.4.2"

# Build tools
RUN apt-get update && \
    apt-get install -y \
    sudo \
    tzdata \
    git \
    cmake \
    wget \
    unzip \
    build-essential

# Media I/O:
RUN apt-get install -y \
    zlib1g-dev \
    libjpeg-dev \
    libwebp-dev \
    libpng-dev \
    libtiff5-dev \
    libopenexr-dev \
    libgdal-dev \
    libgtk2.0-dev

# Video I/O:
RUN apt-get install -y \
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
RUN apt-get install -y \
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
    make -j4 && make install
RUN rm -rf /home/ubuntu/opencv && rm -rf /home/ubuntu/opencv_contrib

RUN echo "### Build OpenCV SUCCESS ###"

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

#set time zone
ENV TZ Asia/Tokyo

#clean cache
RUN rm -rf /var/lib/apt/lists/
RUN apt-get clean

######### initial position ##########
WORKDIR /home/ubuntu/
