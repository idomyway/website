#!/usr/bin/env sh

# 当发生错误时中止脚本
set -e

# 构建
gitbook build

# 部署到自定义域域名
echo 'blog.wdg.pub' > _book/CNAME

git add .

read -p "comment: " comment

git commit -m "$comment"

git push && git push origin --delete gh-pages && git subtree push --prefix _book origin gh-pages
