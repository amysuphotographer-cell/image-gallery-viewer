# 同步脚本使用指南

## 📦 包含的脚本

### 1. `sync.sh` - 完整同步脚本（推荐）
功能完整的同步脚本，包含交互式确认和详细输出。

**使用方法：**

```bash
# 基本用法（会提示输入提交信息）
./sync.sh

# 带提交信息的用法
./sync.sh "添加了新功能：XXX"

# 或者
./sync.sh "修复了bug：XXX"
```

**特点：**
- ✅ 自动复制最新版本
- ✅ 显示修改详情
- ✅ 可选查看差异
- ✅ 自定义提交信息
- ✅ 彩色输出，清晰易读
- ✅ 错误处理完善

---

### 2. `quick-sync.sh` - 快速同步脚本
一键完成同步，无需输入，适合快速更新。

**使用方法：**

```bash
./quick-sync.sh
```

**特点：**
- ⚡ 无需交互，快速完成
- 📅 自动生成时间戳
- 🚀 一键推送到GitHub

---

## 🚀 快速开始

### 第一次使用前的设置

1. **确保已添加GitHub远程仓库**
   ```bash
   cd /Users/aishuxiao/image-gallery-viewer
   git remote add origin https://github.com/YOUR-USERNAME/image-gallery-viewer.git
   ```

2. **测试连接**
   ```bash
   git remote -v
   ```

### 日常使用流程

#### 方式一：完整同步（推荐用于重要更新）

```bash
cd /Users/aishuxiao/image-gallery-viewer
./sync.sh "添加了XXX功能"
```

#### 方式二：快速同步（推荐用于小改动）

```bash
cd /Users/aishuxiao/image-gallery-viewer
./quick-sync.sh
```

---

## 📝 工作流程示例

### 场景1：添加新功能后同步

```bash
# 1. 在外面修改了 image-viewer.html
# 2. 运行同步脚本
cd /Users/aishuxiao/image-gallery-viewer
./sync.sh "新增画笔颜色选择功能"

# 完成！代码已推送到GitHub
```

### 场景2：修复bug后快速同步

```bash
cd /Users/aishuxiao/image-gallery-viewer
./quick-sync.sh

# 完成！自动生成提交信息并推送
```

### 场景3：批量修改后详细同步

```bash
cd /Users/aishuxiao/image-gallery-viewer
./sync.sh

# 会提示：
# - 是否查看详细差异? (y/n)
# - 请输入提交说明:
#   输入：重构代码结构，优化性能
#
# 完成！
```

---

## 🔧 常见问题

### Q: 脚本提示"权限被拒绝"
**A:** 运行以下命令添加执行权限：
```bash
chmod +x sync.sh quick-sync.sh
```

### Q: 推送失败，提示认证错误
**A:** 需要设置GitHub认证：
```bash
# 方法1: 使用GitHub CLI
gh auth login

# 方法2: 使用Personal Access Token
# 在GitHub生成token后，首次push时输入token作为密码
```

### Q: 提示"未设置远程仓库"
**A:** 添加远程仓库：
```bash
git remote add origin https://github.com/YOUR-USERNAME/image-gallery-viewer.git
```

### Q: 如何修改默认的源文件路径？
**A:** 编辑脚本，修改这一行：
```bash
cp /Users/aishuxiao/image-viewer.html ./index.html
```
改为你的实际路径。

### Q: 想要撤销上一次提交怎么办？
**A:**
```bash
# 撤销提交但保留修改
git reset --soft HEAD~1

# 或者撤销提交并丢弃修改（谨慎使用！）
git reset --hard HEAD~1
```

---

## 🎯 最佳实践

1. **重要更新使用 `sync.sh`**
   - 可以写清楚提交说明
   - 方便以后查看历史

2. **小改动使用 `quick-sync.sh`**
   - 快速方便
   - 自动记录时间

3. **定期同步**
   - 建议每次修改后及时同步
   - 避免积累太多改动

4. **提交信息规范**
   ```
   ✅ 好的提交信息：
   - "添加图片放大功能"
   - "修复评分统计错误"
   - "优化报告生成性能"

   ❌ 不好的提交信息：
   - "update"
   - "修改"
   - "123"
   ```

---

## 📚 Git基础命令参考

```bash
# 查看状态
git status

# 查看修改
git diff

# 查看提交历史
git log --oneline

# 查看远程仓库
git remote -v

# 拉取最新代码
git pull

# 强制推送（谨慎使用！）
git push -f
```

---

## 💡 高级技巧

### 创建别名（快捷命令）

在 `~/.bashrc` 或 `~/.zshrc` 中添加：

```bash
# 快速进入项目目录
alias cdgallery='cd /Users/aishuxiao/image-gallery-viewer'

# 快速同步
alias gsync='cd /Users/aishuxiao/image-gallery-viewer && ./quick-sync.sh'

# 完整同步
alias gsyncfull='cd /Users/aishuxiao/image-gallery-viewer && ./sync.sh'
```

然后就可以在任何地方使用：
```bash
gsync  # 快速同步
gsyncfull "添加新功能"  # 完整同步
```

---

## 🆘 需要帮助？

如果遇到问题：
1. 查看脚本输出的错误信息
2. 运行 `git status` 查看当前状态
3. 查看本文档的常见问题部分
4. 在GitHub Issues中提问

---

Happy Coding! 🎉
