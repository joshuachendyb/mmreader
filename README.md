# MermaidReader

一个专业的Markdown文件查看器应用程序，支持Mermaid图表渲染。

## 📋 简介

MermaidReader 是一个专门用于读取和渲染 Markdown 文件的桌面应用程序，核心功能是准确、完整地显示 MD 文件内容，尤其是包含 Mermaid 图表的文档。

## ✨ 核心功能

- **📄 文件读取**: 通过文件选择器打开本地 Markdown 文件
- **📝 内容显示**: 完整准确地显示 MD 文件的全部内容
- **📊 图表渲染**: 将 Mermaid 代码块渲染为 SVG 图形
- **📈 表格渲染**: 将 Markdown 表格渲染为 HTML 表格

## 🚀 快速开始

### 便携版启动 (推荐)

1. 下载 `MermaidReader-portable.zip` 并解压
2. 打开解压后的 `MermaidReader-portable` 目录
3. 双击 `app.html` 使用默认浏览器打开

### 浏览器环境启动

直接在浏览器中打开 `web/app.html` 文件即可运行应用。

## 📖 使用说明

### 基本使用流程

1. **打开文件**: 点击界面上的"选择文件"按钮，选择目标 MD 文件
2. **自动渲染**: 应用将自动读取文件内容并渲染 Mermaid 图表
3. **查看结果**: 渲染完成后，内容将显示在主面板中

### 支持的图表类型

MermaidReader 支持所有 Mermaid 图表类型：

- 流程图 (flowchart)
- 时序图 (sequence diagram)
- 状态图 (state diagram)
- 类图 (class diagram)
- ER 图 (entity relationship)
- 甘特图 (gantt)
- 等等...

## 🏗️ 技术架构

### 多架构实现

MermaidReader 采用多种技术架构：

- **Go + Wails** (`gobuild/`): 桌面应用程序，支持 Windows 平台
- **Rust + Tauri** (`rustbuild/`): 独立架构，支持多平台
- **Web版本** (`web/`): 基于 HTML 的轻量级版本

### 详细文档

- [APP使用说明](productDoc/APP使用说明.md)
- [APP架构设计](productDoc/APP架构设计.md)
- [开发文档索引](devDoc/)

## 📁 项目结构

```
MermaidReader/
├── .gitignore          # Git忽略规则
├── README.md           # 本文档
├── productDoc/         # 产品文档
│   ├── APP使用说明.md
│   ├── APP架构设计.md
│   └── 需求及问题记录.txt
├── devDoc/            # 开发文档
│   ├── Mermaid错误处理代码详解.md
│   ├── 三层防御体系详细分析与方案.md
│   └── 更多开发文档...
├── notes/             # 调试笔记
├── tests/            # 测试用例
├── web/              # Web版本
│   ├── app.html
│   └── release/
├── gobuild/          # Go + Wails 核心代码
└── rustbuild/        # Rust + Tauri 架构代码
```

## 🛠️ 开发

### 环境要求

- Go 1.21+
- Node.js 18+
- Wails 框架

### 构建命令

```bash
# Go+Wails 版本
cd gobuild
./build-dev.bat    # 开发构建
./build-release.bat # 发布构建

# Web版本
cd web
# 直接使用浏览器打开 app.html
```

## 📄 许可证

本项目仅供学习和个人使用。

## 📞 联系方式

如有问题，请通过 GitHub Issues 反馈。

---

**最后更新**: 2026-02-12
