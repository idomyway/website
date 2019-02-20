# Git常用命令

#### 切换分支
```bash
# 显示所有参数使用方法
git branch -h

# 查看所有分支，参数v显示版本号注释等附加信息，a显示所有
git branch -va
# * 开头的为当前本地分支，origin为远程分支
#   gh-pages                5c3cbe8 Create CNAME
# * master                  20575cc shouye
#   remotes/origin/HEAD     -> origin/master
#   remotes/origin/gh-pages 5c3cbe8 Create CNAME
#   remotes/origin/master   20575cc shouye
#   remotes/origin/test     20575cc shouye

# 切换分支
git checkout gh-pages

# 创建并切换分支
git checkout -b dev
```