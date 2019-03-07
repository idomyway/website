# GitLab

> 以Centos 7.4，GitLab 11.8.1 (ce社区版) 为例  

#### 安装

```bash
# 依赖，系统自带，可以忽略该步
#sudo yum install -y curl policycoreutils-python openssh-server
# 在防火墙打开http和ssh访问
#sudo systemctl enable sshd
#sudo systemctl start sshd
#sudo firewall-cmd --permanent --add-service=http
#sudo systemctl reload firewalld

# 添加GitLab包存储库
# gitlab-ee企业版
# gitlab-ce社区版
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash

# 安装GitLab包
yum install -y gitlab-ce
```

#### 修改配置文件

```bash
# 修改配置文件
vim /etc/gitlab/gitlab.rb

# 云服务器记得开放端口
# line.13，用户访问路径IP或域名
external_url 'http://gitlab.example.com:9876'
# line.1021，默认nginx是80端口，防止冲突，和上面端口相同
nginx['listen_port'] = 9876
# line.677，默认端口8080，防止冲突
unicorn['port'] = 9875

# 发送邮件
# line.53 - 54
# 发件箱邮箱
gitlab_rails['gitlab_email_from'] = 'youemail@163.com'
# 发件箱发件人姓名
gitlab_rails['gitlab_email_display_name'] = 'GitLab'
# line.508 - 516，以163邮箱为例
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.163.com"
gitlab_rails['smtp_port'] = 465 # 云服务器记得开放465端口
gitlab_rails['smtp_user_name'] = "youemail@163.com" # 发件箱
gitlab_rails['smtp_password'] = "stmp password" # stmp密码
gitlab_rails['smtp_domain'] = "163.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
```

```bash
# 修改完配置后
# 重新装配
gitlab-ctl reconfigure
# 重启服务
gitlab-ctl restart

# 测试发送邮件
# 进入gitlab控制台
gitlab-rails console
# 发送测试邮件
Notify.test_email('收件箱', '标题', '内容').deliver_now
```

#### 运行

```bash
# 重新装配
gitlab-ctl reconfigure

# 启动服务
gitlab-ctl start

# 重启服务
gitlab-ctl restart

# 停止服务
gitlab-ctl stop
```
