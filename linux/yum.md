# yum 命令相关

> yum，是Yellow dog Updater, Modified 的简称，是杜克大学为了提高RPM 软件包安装性而开发的一种软件包管理器。  
> 以Centos 7.4 为例  

#### 配置阿里源

```bash
# 备份原centos源
cd /etc/yum.repos.d
mv CentOS-Base.repo CentOS-Base.repo_bk

# 下载阿里源http://mirrors.aliyun.com/repo/Centos-7.repo
# 重命名
# Centos-7.repo -> CentOS-Base.repo

# 上传阿里源到/etc/yum.repos.d/

# 更新源
yum clean all
yum makecache
```