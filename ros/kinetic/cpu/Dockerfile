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
RUN apt-get update &&\
    apt-get install --assume-yes apt-utils &&\
    apt-get install -y iputils-ping #install ping

#install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python2 get-pip.py
RUN pip install -U pip

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
    make && make install 
RUN rm -rf /home/ubuntu/opencv && rm -rf /home/ubuntu/opencv_contrib

RUN echo "### Build OpenCV SUCCESS ###"

#install ros packages
RUN apt-get install ros-kinetic-openni2-*


#clean cache
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/

######### initial position ##########
WORKDIR /home/ubuntu/
