# docker source-galera
源码编译galera <br>
version: mysql5.6_provider25v

# 使用说明
1.启动master节点
```$xslt
  docker run  --net=host \
  -v {{home_dir}}/galera/logs:/var/log/mysql/ \
  -v {{home_dir}}/galera/data:/usr/local/mysql/data \
  -v {{home_dir}}/galera/my.cnf:/usr/local/mysql/my.cnf \
  -v /etc/localtime:/etc/localtime:ro \
  -d kolibri-galera:v2 initCluster
```
2.启动其余的node节点
```$xslt
  docker run  --net=host \
  -v {{home_dir}}/galera/logs:/var/log/mysql/ \
  -v {{home_dir}}/galera/data:/usr/local/mysql/data \
  -v {{home_dir}}/galera/my.cnf:/usr/local/mysql/my.cnf \
  -v /etc/localtime:/etc/localtime:ro \
  -d kolibri-galera:v2 initNode
```

3.参数说明
```$xslt
/var/log/mysql/ 日志路径
/usr/local/mysql/data 数据路径
/usr/local/mysql/my.cnf 数据库配置文件
```

