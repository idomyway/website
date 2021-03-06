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
./configure --user=nginx --group=nginx --prefix=/opt/nginx-1.15.8-01/ --with-http_v2_module --with-http_ssl_module --with-http_sub_module --with-http_stub_status_module --with-http_gzip_static_module --with-pcre

# 6、编译安装
make && make install

# 7、创建nginx命令软链接到环境变量
ln -s /opt/nginx-1.15.8-01/sbin/* /usr/local/sbin/

# 开机自动启动，/etc/rc.local中加入
vim /etc/rc.local

nginx
```

#### location相关

```bash
# location表达式类型
~  表示执行一个正则匹配，区分大小写
~* 表示执行一个正则匹配，不区分大小写
^~ 表示普通字符匹配。使用前缀匹配。如果匹配成功，则不再匹配其他location。
=  进行普通字符精确匹配。也就是完全匹配。
@  它定义一个命名的 location，使用在内部定向时，例如 error_page, try_files

# location优先级
(location =) > (location 完整路径) > (location ^~ 路径) > (location ~,~* 正则顺序) > (location 部分起始路径) > (/)
# 1、等号类型（=）的优先级最高。一旦匹配成功，则不再查找其他匹配项。
# 2、^~类型表达式。一旦匹配成功，则不再查找其他匹配项。
# 3、正则表达式类型（~ ~*）的优先级次之。如果有多个location的正则能匹配的话，则使用正则表达式最长的那个。
# 4、常规字符串匹配类型。按前缀匹配。
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
        # ^~ 表示以某前缀开头
        location ^~ /admin/ {  
            proxy_pass   http://admin;
        } 
    }
}
```

#### HTML5 History模式

```bash
# 访问路径 / 为根目录，如果非根目录则为 /具体路径
location /path {
    root html; # webapp的根目录，如果有具体访问路径，也写根目录
    index index.html index.htm; # 默认首页
    try_files $uri $uri/ /path; # 此处解决刷新404，如果找不到资源会callback 到/path/
}
```

#### 负载均衡

> tomcat 为例  
> 反向代理
> 负载均衡后获取客户端真实IP

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
            proxy_cookie_domain domino_server nginx_server; # 解决反向代理后Cookie不一致的问题
        }
        # 带有基础路径请求设置
        location ^~ /api/ {
            # host 修改为真实的域名和端口
            proxy_set_header Host $http_host;
            # 客户端真实ip
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            # 客户端真实协议(http/https)
            proxy_set_header X-Forwarded-Proto $scheme;
            # 负载均衡upstream
            proxy_pass http://tomcat_pool/api/; # 转向tomcat处理
            proxy_cookie_domain domino_server nginx_server; # 解决反向代理后Cookie不一致的问题
        }
    }
}
```

> 负载均衡后获取客户端真实IP，java代码

```java
// 负载均衡后获取客户端真实IP地址
public String getClientIp(HttpServletRequest request) {
    String ip = request.getHeader("x-forwarded-for");
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
        ip = request.getHeader("Proxy-Client-IP");
    }
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
        ip = request.getHeader("WL-Proxy-Client-IP");
    }
    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
        ip = request.getRemoteAddr();
    }
    if(ip.trim().contains(",")){
        //为什么会有这一步，因为经过多层代理后会有多个代理，取第一个ip地址就可以了
        String [] ips = ip.split(",");
        ip = ips[0];
    }
    return ip;
}
```

#### gzip

```bash
http  {
    # gzip模块设置
    gzip on; # 开启gzip压缩输出
    gzip_min_length 1k; # 最小压缩文件大小
    gzip_buffers 4 16k; # 压缩缓冲区
    gzip_http_version 1.1; # 用了反向代理的话，末端通信是HTTP/1.0，默认是HTTP/1.1
    gzip_comp_level 2; # 压缩等级
    gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png; # 压缩类型
    gzip_vary off; # 跟Squid等缓存服务有关，on的话会在Header里增加"Vary: Accept-Encoding"
    gzip_disable "MSIE [1-6]\."; # ie6不压缩
}
```

#### 修改nginx.conf、html位置

```bash
# 修改nginx.conf位置
# 移动nginx.conf
mv /opt/nginx-1.15.8-01/conf/nginx.conf /opt/

# 创建软连接
ln -s /opt/nginx.conf /opt/nginx-1.15.8-01/conf/nginx.conf/


# 修改html位置
# 创建目录
mkdir /opt/nginx-app

# 修改配置文件
vim /opt/nginx.conf

# 顶部加入
user root;

html {
    server {
        location / {
            root /opt/nginx-app;
        }
    }
}

# 重启服务
nginx -s reload
```