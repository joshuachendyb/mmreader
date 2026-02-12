# MermaidReader 构建工具使用说明

**创建时间**: 2026-02-02 14:45:00  
**更新时间**: 2026-02-02 14:50:00

---

## 可用构建脚本一览

| 脚本文件 | 适用环境 | 使用场景 | 版本控制 | 编码支持 | 推荐使用 |
|---------|----------|----------|----------|----------|----------|
| `build-dev.sh` | **Git Bash** | 日常开发构建 | 自动升级 (Patch+1) | ✅ UTF-8 | ⭐⭐⭐⭐⭐ |
| `build-dev.bat` | CMD/PowerShell | 开发构建备选 | 自动升级 (依赖 sed) | ⚠️ 需 Git | ⭐⭐⭐ |
| `build-release.bat` | CMD/PowerShell | **正式发布** | **手动控制** | ✅ (已修复) | ⭐⭐⭐⭐⭐ |
| `build.sh` | Git Bash | 纯 Go 程序 | 日期版本 | ✅ UTF-8 | ⭐⭐ (备用) |

---

## 一、日常开发构建 (推荐)

### build-dev.sh (Git Bash)

**适用场景**: 日常开发、Bug修复、小优化

**使用方式**:
```bash
cd /d/2bktest/MDview/MermaidReader/gobuild
./build-dev.sh
```

**功能特点**:
- ✅ 自动读取 version.txt 当前版本
- ✅ 自动升级 Patch 版本号 (+1)
- ✅ 同时更新 version.txt 和 main.go
- ✅ 执行 Wails Build
- ✅ 复制到 bin 目录
- ✅ 完整 UTF-8 中文支持

**示例流程**:
```
当前: 1.5.9 → 执行后 → 新版本: 1.5.10
```

---

## 二、正式发布构建

### build-release.bat (CMD/PowerShell)

**适用场景**: 正式发布、打包分发

**使用方式**:
```cmd
cd D:\2bktest\MDview\MermaidReader\gobuild
build-release.bat
```

**功能特点**:
- ⚠️ **版本号手动控制** (第17行，默认 1.5.6)
- ✅ 清理旧构建文件
- ✅ 创建发布目录 (`release_YYYYMMDD_vX.Y.Z`)
- ✅ 生成 VERSION.txt 说明文件
- ✅ 自动打包 ZIP 文件
- ✅ 打开发布目录

**版本号设置** (手动修改):
```batch
REM 第17行 - 由用户控制，不自动升级
set VERSION=1.5.6
```

**升级第2位(MINOR)需先征得用户同意**，请参考《软件版本号变更管理规定》

---

## 三、备用构建脚本

### build-dev.bat (CMD/PowerShell)

**适用场景**: 当 Git Bash 不可用时

**注意**: 依赖 Git Bash 的 sed 命令，请确保 Git for Windows 已安装

### build.sh (Git Bash)

**适用场景**: 编译纯 Go 程序（不依赖 Wails 框架）

**注意**: 此脚本使用 `go build` 而非 `wails build`，**不适用于 MermaidReader**

**保留原因**: 备用脚本，用于其他纯 Go 项目

---

## 四、版本号管理规则

### 当前版本 vs 下次版本

| 文件 | 作用 | 当前值 | 说明 |
|------|------|--------|------|
| `version.txt` | 记录**当前**已发布的版本 | 1.5.9 | 作为下次构建的基准 |
| `main.go` | 应用运行时返回的版本 | 1.5.9 | 应与 version.txt 一致 |
| `build-dev.sh` | 自动生成下次版本 | 1.5.10 | Patch + 1 |
| `build-release.bat` | **手动控制发布版本** | 1.5.6 | 第17行手动设置 |

### 版本升级流程 (build-dev.sh)

```
当前状态:
  version.txt: 1.5.9
  main.go: return "1.5.9"

执行 ./build-dev.sh 后:
  version.txt: 1.5.10  (自动升级)
  main.go: return "1.5.10"  (自动更新)
  输出文件: MermaidReader.exe (v1.5.10)
```

### 版本升级权限规定

根据《软件版本号变更管理规定》：

| 版本位 | 变更场景 | 决策权限 | 变更前必须 |
|--------|----------|----------|------------|
| **第1位(MAJOR)** | 重大架构变更 | ❌ **绝对禁止** - 必须由用户授意 | 用户明确指令："升级到X.0.0" |
| **第2位(MINOR)** | 新功能模块、重大改进 | ⚠️ **建议权在我，决定权在用户** | 必须先问："是否需要升级第2位？" |
| **第3位(PATCH)** | Bug修复、小优化 | ✅ **我可以自主决定** | 无需询问，直接+1 |

---

## 五、常见问题

### Q1: 使用哪个脚本？

**日常开发**: 使用 `build-dev.sh` (Git Bash)
- 自动升级版本号
- UTF-8 编码支持

**正式发布**: 使用 `build-release.bat` (CMD)
- 手动控制版本号
- 自动打包发布

### Q2: build-dev.bat 和 build-dev.sh 的区别？

| 特性 | build-dev.sh | build-dev.bat |
|------|--------------|---------------|
| 环境 | Git Bash | CMD/PowerShell |
| 编码 | ✅ 完美支持 | ⚠️ 依赖 sed |
| 可靠性 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| 推荐度 | **首选** | 备选 |

**建议**: 优先使用 build-dev.sh，仅在 Git Bash 不可用时使用 build-dev.bat

### Q3: 版本号没有自动更新？

**检查事项**:
1. 确认 main.go 第 49 行格式正确：
   ```go
   return "X.Y.Z" // 当前版本，由build脚本自动更新
   ```
2. 确认 version.txt 存在且格式为 `X.Y.Z`
3. 使用 build-dev.sh (Git Bash) 而非 build-dev.bat

### Q4: 如何手动设置版本号？

直接编辑文件：

```bash
# 设置 version.txt
echo "1.5.10" > version.txt

# 编辑 main.go 第 49 行
# 修改: return "1.5.10" // 当前版本，由build脚本自动更新
```

### Q5: build-release.bat 的版本号怎么改？

编辑第17行：
```batch
set VERSION=1.5.6  ← 修改这里的版本号
```

**注意**: 修改第2位(MINOR)前必须先征得用户同意！

### Q6: build.sh 什么时候用？

**不适用 MermaidReader** (它使用 `go build` 而非 `wails build`)

**适用场景**: 
- 其他纯 Go 项目（不依赖 Wails 框架）
- 需要压缩可执行文件（使用 UPX）

---

## 六、文件结构

```
gobuild/
├── build-dev.sh          # Git Bash 开发构建 ⭐推荐日常使用
├── build-dev.bat         # CMD 开发构建 (备选)
├── build-release.bat     # 正式发布构建 (版本号手动控制)
├── build.sh              # 纯 Go 构建 (备用)
├── build工具使用说明.md   # 本文档
├── version.txt           # 当前版本号记录
├── main.go               # 应用代码 (包含版本号)
├── build/
│   └── bin/
│       └── MermaidReader.exe  # Wails 构建输出
└── bin/
    └── MermaidReader.exe      # 最终发布文件
```

---

## 七、构建后检查清单

构建完成后，请检查：

- [ ] `build\bin\MermaidReader.exe` 是否存在
- [ ] `bin\MermaidReader.exe` 是否已更新
- [ ] 版本号是否正确 (通过应用关于页面查看)
- [ ] 文件大小是否正常 (约 15 MB)
- [ ] 如果是发布构建: ZIP 包是否生成

---

## 八、快速参考

### 日常开发流程
```bash
cd /d/2bktest/MDview/MermaidReader/gobuild
./build-dev.sh
```

### 正式发布流程
```cmd
cd D:\2bktest\MDview\MermaidReader\gobuild
REM 1. 先修改 build-release.bat 第17行版本号
REM 2. 执行构建
build-release.bat
```

---

**创建时间**: 2026-02-02 14:45:00  
**更新时间**: 2026-02-02 14:50:00  
**适用版本**: v1.5.9+
