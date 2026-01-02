#!/bin/bash

# Image Gallery Viewer - 自动同步脚本
# 用法: ./sync.sh "提交说明信息"

set -e  # 遇到错误立即退出

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Image Gallery Viewer - 自动同步到GitHub${NC}"
echo "================================================"

# 进入项目目录
cd "$(dirname "$0")"
PROJECT_DIR=$(pwd)

# 1. 复制最新版本
echo -e "\n${YELLOW}📋 步骤 1/5: 复制最新版本...${NC}"
if [ -f "/Users/aishuxiao/image-viewer.html" ]; then
    cp /Users/aishuxiao/image-viewer.html "$PROJECT_DIR/index.html"
    echo "✅ 已复制最新版本"
else
    echo -e "${RED}⚠️  警告: 未找到源文件，跳过复制步骤${NC}"
fi

# 2. 检查是否有修改
echo -e "\n${YELLOW}🔍 步骤 2/5: 检查修改...${NC}"
if git diff --quiet && git diff --cached --quiet; then
    echo -e "${GREEN}✨ 没有检测到修改，无需同步${NC}"
    exit 0
fi

echo "检测到以下修改:"
git status --short

# 3. 显示详细差异
echo -e "\n${YELLOW}📝 步骤 3/5: 查看修改详情...${NC}"
echo "是否要查看详细差异? (y/n)"
read -t 5 -n 1 show_diff || show_diff="n"
echo
if [ "$show_diff" = "y" ]; then
    git diff
fi

# 4. 添加修改
echo -e "\n${YELLOW}➕ 步骤 4/5: 添加修改...${NC}"
git add .
echo "✅ 已添加所有修改"

# 5. 提交和推送
echo -e "\n${YELLOW}💾 步骤 5/5: 提交并推送...${NC}"

# 获取提交信息
if [ -n "$1" ]; then
    COMMIT_MSG="$1"
else
    echo "请输入提交说明 (留空使用默认信息):"
    read -r COMMIT_MSG
    if [ -z "$COMMIT_MSG" ]; then
        COMMIT_MSG="Update: 更新功能和样式优化"
    fi
fi

# 添加时间戳和署名
FULL_COMMIT_MSG="${COMMIT_MSG}

🤖 Generated with Claude Code https://claude.com/claude-code

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# 提交
git commit -m "$FULL_COMMIT_MSG"
echo "✅ 已提交修改"

# 推送
echo -e "\n正在推送到GitHub..."
if git push; then
    echo -e "\n${GREEN}🎉 同步成功！${NC}"
    echo "================================================"

    # 显示提交信息
    echo -e "\n最新提交:"
    git log -1 --pretty=format:"%h - %s (%ar)" --abbrev-commit
    echo -e "\n"

    # 显示仓库URL
    REPO_URL=$(git remote get-url origin 2>/dev/null || echo "未设置远程仓库")
    echo "仓库地址: $REPO_URL"

else
    echo -e "\n${RED}❌ 推送失败${NC}"
    echo "请检查:"
    echo "1. 是否已设置远程仓库 (git remote -v)"
    echo "2. 是否有网络连接"
    echo "3. 是否有推送权限"
    exit 1
fi
