# pintos-docker
使用docker搭建的pintos+codeserver开发环境
# how to use
```
  docker run -idt -p 8080:8080 huahuaxiaomuzhu/huahuapintos
```
打开浏览器 127.0.0.1:8080 就可以看到

# 记得把qemu修改为bochs！！
(要不然你make check的时候会全都挂掉的)
## 顺带一提
如果有一些你需要的工具没有安装的话，请使用apt-get自行安装，如：
```
apt-get install git
```
