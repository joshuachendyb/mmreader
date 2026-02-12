# MermaidReader - 图表阅读器

## 项目概述

MermaidReader 是一个基于 Go + WebView2 技术的桌面应用程序，用于查看和编辑 Mermaid 图表。它提供了一个现代化的编辑器界面，支持实时预览、主题切换、文件操作等功能。

## 主要特性

- **实时预览**: 所见即所得的图表编辑体验
- **多主题支持**: 支持浅色和深色主题切换
- **文件操作**: 打开、保存和最近文件管理
- **导出功能**: 支持导出 SVG 和 PNG 格式
- **响应式设计**: 自适应不同屏幕尺寸
- **单文件应用**: 编译为单个可执行文件

## 技术栈

- **后端**: Go 1.19+
- **前端**: HTML5 + CSS3 + JavaScript
- **UI 框架**: 原生 WebView2
- **图表库**: Mermaid.js
- **打包工具**: UPX 压缩

## 快速开始

### 1. 环境准备

确保您的系统满足以下要求：
- Windows 10 1903 或更高版本
- Go 1.19 或更高版本
- WebView2 运行时

### 2. 安装依赖

```bash
# 安装 WebView2 Go 绑定
go get github.com/webview/webview

# 安装 UPX (可选，用于压缩可执行文件)
# 从 https://github.com/upx/upx/releases 下载并安装
```

### 3. 构建项目

```bash
# 进入项目目录
cd MermaidReader

# 构建开发版本
go build -o bin/MermaidReader.exe main.go

# 构建生产版本（去除调试信息）
go build -ldflags="-s -w" -o bin/MermaidReader.exe main.go

# 构建窗口化版本（无控制台）
go build -ldflags="-s -w -H windowsgui" -o bin/MermaidReader.exe main.go

# 压缩可执行文件
upx bin/MermaidReader.exe
```

### 4. 运行应用

```bash
# 直接运行
go run main.go

# 或运行构建后的可执行文件
bin/MermaidReader.exe
```

## 项目结构

```
MermaidReader/
├── main.go              # 主程序入口
├── package.json         # Node.js 配置文件（可选）
├── README.md            # 项目说明文档
├── bin/                 # 构建输出目录
├── static/              # 静态资源目录
│   ├── css/
│   │   ├── mermaid.css    # Mermaid 图表样式
│   │   └── style.css      # 应用样式
│   ├── js/
│   │   ├── app.js         # 应用逻辑
│   │   └── mermaid.min.js # Mermaid 库（简化版）
│   └── index.html       # 主页面
└── resources/           # 资源文件（嵌入使用）
```

## 功能说明

### 编辑器功能

- **语法高亮**: 支持 Mermaid 语法高亮
- **实时预览**: 输入内容实时更新预览
- **主题切换**: 浅色/深色主题
- **缩放功能**: 支持字体大小调整
- **快捷键**: Ctrl+O (打开), Ctrl+R (重新加载), F5 (刷新)

### 文件操作

- **打开文件**: 支持 .md 和 .txt 格式
- **最近文件**: 自动记录最近打开的文件
- **保存功能**: 支持文件保存（浏览器限制）

### 导出功能

- **SVG 导出**: 导出高质量 SVG 格式
- **PNG 导出**: 导出 PNG 图片格式

## 配置选项

### Go 构建参数

- `-s`: 去除符号表
- `-w`: 去除调试信息
- `-H windowsgui`: 构建窗口化应用

### Mermaid 配置

可在 `main.go` 中修改 Mermaid 初始化参数：

```go
mermaid.initialize({
    startOnLoad: false,
    theme: "default",
    flowchart: {
        useMaxWidth: true,
        htmlLabels: true
    }
});
```

## 开发指南

### 添加新功能

1. **修改前端**: 编辑 `static/js/app.js`
2. **修改样式**: 编辑 `static/css/style.css`
3. **修改后端**: 编辑 `main.go`
4. **重新构建**: `go build -o bin/MermaidReader.exe main.go`

### 调试技巧

```bash
# 启用调试模式
go build -gcflags="all=-N -l" -o bin/MermaidReader.exe main.go

# 运行调试器
dlv debug main.go
```

## 性能优化

### 包体积优化

1. **编译优化**: 使用 `-ldflags="-s -w"`
2. **压缩**: 使用 UPX 压缩
3. **资源嵌入**: 使用 `//go:embed` 嵌入资源

### 内存优化

- 使用 `sync.Once` 确保资源只加载一次
- 及时关闭 HTTP 服务器
- 使用 `defer` 释放资源

## 常见问题

### Q: 应用无法启动

**A**: 确保已安装 WebView2 运行时。从 [Microsoft Edge WebView2](https://developer.microsoft.com/en-us/microsoft-edge/webview2/) 下载并安装。

### Q: 图表无法显示

**A**: 检查浏览器控制台是否有错误。确保 Mermaid.js 正确加载。

### Q: 包体积过大

**A**: 使用 UPX 压缩，并确保使用了编译优化参数。

## 发布说明

### 版本 1.0.0 (2026-01-31)

- 初始版本发布
- 基础图表编辑功能
- 实时预览支持
- 主题切换功能
- 文件操作支持

## 许可证

MIT License

## 贡献指南

欢迎提交 Issue 和 Pull Request！

---

**MermaidReader** - 让图表编辑变得简单高效！