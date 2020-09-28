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
docker run -p 6080:80 --name <CONTAINER_NAME> --shm-size=1024m --privileged <IMAGE_NAME>
```

http://127.0.0.1:6080/

docker run の際に”--device /dev/dri:/dev/dri --device /dev/video0:/dev/video0:mwr”をつければ指定したデバイスがコンテナ内でも使える



##remove container
```
docker rm <ID>
docker rm `docker ps -a -q` #all
```

##others
"WARNING: apt does not have a stable CLI interface. Use with caution in scripts."のエラーは木にしなくても良さそう。


# DNSの設定
/etc/resolv.confのnameserverをHOSTと同じネットワークのゲートウェイ/DNSserverにするとうまく行った
ホストPCの/etc/docker/daemon.jsonに、
```
{
	"dns":["x.x.x.x","x.x.x.y"]
}
```
を記述し、
```
sudo systemctl daemon-reload
sudo systemctl restart docker
```


#pythonのopencvの設定
```
import sys
sys.path.remove("/opt/ros/kinetic/lib/python2.7/dist-packages")
import cv2
```
とすることで、デフォルトの3.3.1-devではなく、新しく入れた方のopencvをimportできるようになる

#"WARNING: apt does not have a stable CLI interface. Use with caution in scripts."と出る場合
"apt"から"apt-get"にすると消える。
ターミナルのようなインタラクティブなCLIでは"apt"を、スクリプト内では"apt-get"を使うのがルールっぽい。
https://wp.tekapo.com/2019/07/15/difference-between-apt-and-apt-get/



https://kazuhira-r.hatenablog.com/entry/2020/04/12/194225
https://qiita.com/frost-tb-voo/items/fcc0c0fe7561b9101bf4
https://github.com/turlucode/ros-docker-gui
