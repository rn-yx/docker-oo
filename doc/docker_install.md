docker环境步骤
1、Docker 要求 CentOS 系统的内核版本高于 3.10 ，查看本页面的前提条件来验证你的CentOS 版本是否支持 Docker

uname -r
2、使用 root 权限登录 Centos。确保 yum 包更新到最新

yum update
3、卸载旧版本(如果安装过旧版本的话)

yum remove docker  docker-common docker-selinux docker-engine
4、安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

yum install -y yum-utils device-mapper-persistent-data lvm2
5、设置yum源

阿里云：（推荐）
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
docker 官网

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

6、可以查看所有仓库中所有docker版本，并选择特定版本安装

yum list docker-ce --showduplicates | sort -r
7、安装Docker，命令：yum install docker-ce-版本号，我选的是3:20.10.5-3.el8

yum install docker-ce-3:20.10.9-3.el8
8、验证安装是否成功

docker version
docker安装可能出现问题
1、因为之前已经安装过旧版本的docker，在安装的时候报错如下：

Transaction check error:

file /usr/bin/docker from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64

file /usr/bin/docker-containerd from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64

file /usr/bin/docker-containerd-shim from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64

file /usr/bin/dockerd from install of docker-ce-17.12.0.ce-1.el7.centos.x86_64 conflicts with file from package docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64

解决问题：

（1）卸载旧版本的包

yum erase docker-common-2:1.12.6-68.gitec8512b.el7.centos.x86_64

（2）再次安装docker

yum install docker-ce-3:20.10.9-3.el8

2、执行yum update 出现/var/run/yum.pid 已被锁定，PID 为 49901 的另一个程序正在运行

解决问题：

rm -f /var/run/yum.pid 将该文件删除，然后再次运行yum update

3、CentOS 8 中安装Docker出现和Podman冲突 problem with installed package podman-1.4.2-5.module_el8.1.0+237+63e26edc.x86_64

解决问题：

（1）查看是否安装 Podman

rpm -q podman

podman-1.4.2-5.module_el8.1.0+237+63e26edc.x86_64

删除Podman

dnf remove podman

(2)centos8默认使用podman代替docker

yum erase podman buildah

docker-compose环境安装
1、安装pip

yum -y install epel-release

yum install python3-pip

pip3 install --upgrade pip

2、安装docker-compose

pip3 install docker-compose
3、查看版本

docker-compose version