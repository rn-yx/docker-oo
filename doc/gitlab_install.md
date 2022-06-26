前提要求
docker
如果使用的是cetos7虚拟机的话，虚拟机内存至少2G（本文使用的虚拟机内存为2.9G）
会基本使用docker、vim命令
如果使用的是苹果m1芯片的电脑，需要装一个桌面版的docker（博主自己现在也用过 macbook air m1 16G的电脑通过桌面版的docker成功搭建gitlab）
建议第一次部署的时候完完全全按照文档的命令直接复制粘贴，等成功部署并熟练后再自行修改对应的端口号等信息
步骤
1、拉取镜像
centos7
执行命令：docker pull gitlab/gitlab-ce

mac m1
执行命令：docker pull yrzr/gitlab-ce-arm64v8:latest

2、创建三个文件（建议创建在home目录下，防止后续出现权限不足的问题）
centos7（可以直接创建在home下）
命令：mkdir -p /home/gitlab/config
命令：mkdir -p /home/gitlab/logs
命令：mkdir -p /home/gitlab/data


mac m1（建议放在文档目录下）
命令：mkdir -p /Users/你的用户名/Documents/gitlab/config
命令：mkdir -p /Users/你的用户名/Documents/gitlab/logs
命令：mkdir -p /Users/你的用户名/Documents/gitlab/data

3、启动容器
centos7
执行命令：docker run -d -p 443:443 -p 80:80 -p 32:22 --name gitlab --restart always -v /home/gitlab/config:/etc/gitlab -v /home/gitlab/logs:/var/log/gitlab -v /home/gitlab/data:/var/opt/gitlab --privileged=true gitlab/gitlab-ce

mac m1
执行命令：sudo docker run -d -p 8443:443 -p 8888:80 -p 8822:22 --name gitlab --restart always -v /Users/你的用户名/Documents/gitlab/config:/etc/gitlab -v /Users/你的用户名/Documents/gitlab/logs:/var/log/gitlab -v /Users/你的用户名/Documents/gitlab/data:/var/opt/gitlab --privileged=true yrzr/gitlab-ce-arm64v8:latest

查看启动日志（可能需要等待比较长的时间才能看到如下图）
命令：docker logs -f gitlab
大概看到以下类似内容即可执行下一步


4、编辑容器配置文件
centos7
执行命令：vim /home/gitlab/config/gitlab.rb

mac m1
执行命令：vim /Users/你的用户名/Documents/gitlab/config/gitlab.rb

填写以下内容：（该内容与启动命令绑定的端口相关）
centos7
#配置http协议所使用的访问地址,不加端口号默认为80
external_url ‘http://localhost’
#配置ssh协议所使用的访问地址和端口
gitlab_rails[‘gitlab_ssh_host’] = ‘localhost’
#此端口是run时22端口映射的32端口
gitlab_rails[‘gitlab_shell_ssh_port’] = 32

mac m1
#配置http协议所使用的访问地址,不加端口号默认为80
external_url ‘http://localhost:8888’
#配置ssh协议所使用的访问地址和端口
gitlab_rails[‘gitlab_ssh_host’] = ‘localhost’
#此端口是run时22端口映射的32端口
gitlab_rails[‘gitlab_shell_ssh_port’] = 8822

5、重启
执行命令：docker restart gitlab

查看启动日志
命令：docker logs -f gitlab
大概看到以下类似内容即可执行下一步


6、查看初始root密码（记得拷贝下来）
执行命令： sudo docker exec -it gitlab grep ‘Password:’ /etc/gitlab/initial_root_password

7、启动成功后，进入容器
命令：docker exec -it gitlab bash
执行如下命令（可能需要等待）

命令：gitlab-ctl status
命令：gitlab-ctl reconfigure
命令：gitlab-ctl restart
查看启动日志
命令：docker logs -f gitlab
大概看到以下类似内容即可执行下一步


8、访问当前部署gitlab所在的服务器ip地址

账号：root
密码：拷贝上面的初始密码

9、登录成功后的界面


注意
至此，docker部署gitlab完成
注意：第一次启动时需要等待以及多查看日志
