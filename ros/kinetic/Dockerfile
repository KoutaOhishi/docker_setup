FROM tiryoh/ros-desktop-vnc:kinetic

LABEL maintainer="Kota Oishi<bigbasketball568@yahoo.co.jp>"

#create catkin_ws
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

RUN apt update

#install apps
RUN apt install -y iputils-ping #install ping
RUN rm -rf /var/lib/apt/lists/

#install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python2 get-pip.py
RUN pip install -U pip


#install openCV



######### initial position ##########
WORKDIR /home/ubuntu/
