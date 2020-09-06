# 创建和使用Redis集群

## 修改配置，依次启动

## 进入任一节点容器，执行创建命令
```bash
redis-cli -a rn1234 --cluster create 192.168.211.138:6379 192.168.211.138:6380 192.168.211.138:6381 192.168.211.138:6382 192.168.211.138:6383 192.168.211.138:6384 --cluster-replicas 1

```

## 客户端登录，查看集群信息
注：默认设置密码为rn1234

```bash
redis-cli -c -a rn1234 -p 6379
cluster info
cluster nodes
```