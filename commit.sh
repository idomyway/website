#!/usr/bin/env sh

# 当发生错误时中止脚本
set -e

# 构建
gitbook build

# 部署到自定义域域名
echo 'blog.wdg.pub' > _book/CNAME

git add .

# 注释
read -p "comment: " comment

git commit -m "$comment"

# 提交代码
git push

# 删除gh-pages分支
git push origin --delete gh-pages

# 重新提交gh-pages分支
git subtree push --prefix _book origin gh-pages
