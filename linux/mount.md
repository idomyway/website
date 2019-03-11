# Linux下永久挂载硬盘到指定目录

> 以Centos 7.4为例

```bash
# 1、查看可挂载硬盘
fdisk -l

# 2、磁盘分区
fdisk /dev/vdb

# 3、参数：输入 n， p， 1， 回车，回车， wq

# 4、格式化硬盘
mkfs.ext4 /dev/vdb1

# 5、挂载到指定目录
mount /dev/vdb1 /home

# 6、写入分区表（自动挂载）
echo '/dev/vdb1  /home ext4 defaults 0  0' >> /etc/fstab

# 7、查看挂载结果
df -h
```



