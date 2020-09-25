# Docker memo

## install
https://qiita.com/tkyonezu/items/0f6da57eb2d823d2611d


## image download
```
#sudo docker pull ros:kinetic #rvizやgitが使えない？
docker run -p 6080:80 --shm-size=512m tiryoh/ros-desktop-vnc:kinetic
docker run -p 6080:80 --shm-size=512m tiryoh/ros-desktop-vnc:melodic
```

##build from Dockerfile
```
cd /path/to/Dockerfile
docker build --tag <NAME> .
docker build --tag <NAME> --network host .
```

##run image as a container
```
docker run -it <NAME>
docker run --p 6080:80 --shm-size=1024m --privileged <NAME>
```

http://127.0.0.1:6080/

##remove container
```
docker rm <ID>
docker rm `docker ps -a -q` #all
```

##others
"WARNING: apt does not have a stable CLI interface. Use with caution in scripts."のエラーは木にしなくても良さそう。


# DNSの設定
/etc/resolv.confのnameserverをHOSTと同じネットワークのゲートウェイ/DNSserverにするとうまく行った



