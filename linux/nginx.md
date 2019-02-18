# Nginx（Linux环境下）

> 以Centos 7.4，Nginx 1.15.8为例

#### 安装

```bash
# 1、编译依赖
yum -y install gcc gcc-c++

# 2、nginx依赖
yum -y install zlib zlib-devel openssl openssl-devel pcre pcre-devel

# 3、下载 解压nginx-1.15.8.tar.gz
tar -xzvf nginx-1.15.8.tar.gz

# 4、创建nginx用户
useradd -s /bin/false -M nginx

# 5、编译
cd nginx-1.15.8
# 生成makefile，指定用户、组、安装路径、相关模块
./configure --user=nginx --group=nginx --prefix=/home/nginx-1.15.8-01/ --with-http_v2_module --with-http_ssl_module --with-http_sub_module --with-http_stub_status_module --with-http_gzip_static_module --with-pcre
make && make install

# 6、创建nginx命令软链接到环境变量
ln -s /home/nginx-1.15.8-01/sbin/* /usr/local/sbin/
```

#### 配置SSL（https）

```bash
# 安装时--with-http_ssl_module，添加ssl模块
http {
    server {
        listen 443 ssl; # 此处加ssl参数，可以不用使用ssl on配置
        server_name www.xxx.com; # 域名
        #ssl on;
        ssl_certificate /opt/ssl/xxx.pem; # crt / pem 文件
        ssl_certificate_key /opt/ssl/xxx.key; # key
        ssl_session_timeout 5m;
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;

        location / {
            root   html;
            index  index.html index.htm;
        }
    }
    server {
        listen 80;
        server_name xxx.com www.xxx.com;
        rewrite ^(.*) https://$host$1 permanent;
    }
}
```

#### 接口代理跨域

```bash
http {
    server {
        location /api/ {
            proxy_pass http://192.168.0.12:8080/api/;
        }
    }
}
```

#### 负载均衡

> tomcat 为例

```bash
html {
    # 添加tomcat列表，真实应用服务器都放在这
    upstream tomcat_pool  {
        # server tomcat地址:端口号 weight表示权值，权值越大，被分配的几率越大;
        server 192.168.0.223:8080 weight=4 max_fails=2 fail_timeout=30s;
        server 192.168.0.224:8080 weight=4 max_fails=2 fail_timeout=30s;
    }
    server {
        # 默认请求设置
        location / {
            proxy_pass http://tomcat_pool; # 转向tomcat处理
        }
    }
}
```

#### gzip

```bash
http  {
    # gzip模块设置
    gzip on; # 开启gzip压缩输出
    gzip_min_length 1k; # 最小压缩文件大小
    gzip_buffers 4 16k; # 压缩缓冲区
    gzip_http_version 1.1; # 压缩版本（默认1.1，前端如果是squid2.5请使用1.0）
    gzip_comp_level 2; # 压缩等级
    gzip_types text/plain application/x-javascript text/css application/xml; # 压缩类型，默认就已经包含textml，所以下面就不用再写了，写上去也不会有问题，但是会有一个warn。
    gzip_vary on;
    gzip_disable "MSIE [1-6]\."; # ie6不压缩
}
```



