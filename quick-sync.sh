#!/bin/bash

# 快速同步脚本 - 一键完成所有操作
# 用法: ./quick-sync.sh

cd "$(dirname "$0")"

# 复制最新版本
cp /Users/aishuxiao/image-viewer.html ./index.html 2>/dev/null || true

# 检查是否有修改
if git diff --quiet && git diff --cached --quiet; then
    echo "✨ 没有修改，无需同步"
    exit 0
fi

# 添加所有修改
git add .

# 自动生成提交信息
COMMIT_MSG="Update: $(date '+%Y-%m-%d %H:%M') 功能更新

🤖 Generated with Claude Code https://claude.com/claude-code

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

# 提交并推送
git commit -m "$COMMIT_MSG"
git push

echo "🎉 同步完成！"
