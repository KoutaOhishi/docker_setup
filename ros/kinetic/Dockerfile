FROM tiryoh/ros-desktop-vnc:kinetic

#create catkin_ws
RUN mkdir -p /home/ubuntu/catkin_ws/src
RUN cd /home/ubuntu/catkin_ws/src && \
	/bin/bash -c /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_init_workspace"
RUN cd /home/ubuntu/catkin_ws/ && /bin/bash -c "source /opt/ros/kinetic/setup.bash; catkin_make"

RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc &&\
	echo "source /home/ubuntu/catkin_ws/devel/setup.bash" >> ~/.bashrc &&\
	echo "export ROS_PACKAGE_PATH=\${ROS_PACKAGE_PATH}:/home/ubuntu/catkin_ws" >> ~/.bashrc &&\
	echo "export ROS_WORKSPACE=/home/ubuntu/catkin_ws" >> ~/.bashrc

#set to the same Gateway as the host pc
RUN echo "nameserver 150.37.224.1" >> /etc/resolv.conf 

RUN apt update

#install apps
RUN apt install -y iputils-ping
RUN rm -rf /var/lib/apt/lists/


######### initial position ##########
WORKDIR /home/ubuntu/
