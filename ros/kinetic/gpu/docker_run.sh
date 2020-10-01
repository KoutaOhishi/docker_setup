#! /bin/bash
docker run -p 6080:80 \
     ---gpus all \
     --device /dev/dri:/dev/dri \
     --device /dev/video0:/dev/video0:mwr \
     --shm-size=512m \
     --name kinetic_gpu #container_name\
     --previleged \
     kinetic_gpu #image_name
