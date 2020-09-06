# 简介
FastDFS 是一个开源的高性能分布式文件系统（DFS）。 它的主要功能包括：文件存储，文件同步和文件访问，以及高容量和负载平衡。
主要解决了海量数据存储问题，特别适合以中小文件（建议范围：4KB < file_size <500MB）为载体的在线服务。

FastDFS开源地址: https://hub.docker.com/r/season/fastdfs/

FastDFS 系统有三个角色：跟踪服务器(Tracker Server)、存储服务器(Storage Server)和客户端(Client)。

docker pull season/fastdfs
查看fastdfs的端口是否被占用
netstat -aon | grep 22122

## 创建tracker服务器的容器
```
docker run -ti -d --name trakcer -v /opt/fastdfs/tracker_data:/fastdfs/tracker/data --net=host season/fastdfs:1.2 tracker
```
## 创建storage存储服务器
```
docker run -ti -d --name storage -v /opt/fastdfs/storage_data:/fastdfs/storage/data -v /opt/fastdfs/store_path:/fastdfs/store_path --net=host -e TRACKER_SERVER:192.168.125.14:22122 season/fastdfs:1.2 storage
```

## 修改配置
```
docker exec -it storage bash
docker cp storage:/fdfs_conf/storage.conf /opt/fastdfs
```

docker exec -it fastdfs-storage bash

fdfs_monitor storage.conf


for name in $(docker ps -a | awk '{print $1}' | grep -v CONTAINER); do docker inspect $name | grep LogPath | awk '{print $NF}' | tr -d '",' |xargs du -sh;done

Linux中查看各文件夹大小命令：du -h --max-depth=1


## 清理Docker占用的磁盘空间

* 查看Docker的磁盘使用情况
```bash
docker system df
```
* 清理
```bash
docker system prune -a
```

* 清理不用的卷
```bash
docker volume prune 
```
