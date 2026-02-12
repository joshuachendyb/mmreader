# MermaidReader 应用程序使用说明

## 一、产品概述

MermaidReader 是一个专门用于读取和渲染 Markdown 文件的桌面应用程序，核心功能是准确、完整地显示 MD 文件内容，尤其是包含 Mermaid 图表的文档。

### 核心功能
1. **文件读取**: 通过文件选择器打开本地 Markdown 文件
2. **内容显示**: 完整准确地显示 MD 文件的全部内容
3. **图表渲染**: 将 Mermaid 代码块渲染为 SVG 图形
4. **表格渲染**: 将 Markdown 表格渲染为 HTML 表格

### 设计目标
- **准确性**: MD 内容显示准确无误，Mermaid 图表渲染精准
- **快速性**: 渲染速度快，用户无需长时间等待
- **易用性**: 操作简单直观，界面清晰明了

---

## 二、快速开始

### 2.1 启动应用

#### 便携版启动 (推荐)
1. 下载 `MermaidReader-portable.zip` 并解压
2. 打开解压后的 `MermaidReader-portable` 目录
3. 双击 `app.html` 使用默认浏览器打开

#### 浏览器环境启动
直接在浏览器中打开 `browser_view.html` 文件即可运行应用。

### 2.2 基本使用流程

#### 步骤1：打开文件
1. 在应用界面找到"选择文件"按钮（位于界面上方）
2. 点击按钮，弹出系统文件选择对话框
3. 导航到目标 MD 文件所在位置
4. 选择文件，点击"打开"

#### 步骤2：自动渲染
- 应用将自动读取文件内容
- 自动解析 Markdown 格式
- 自动渲染 Mermaid 图表
- 自动渲染表格

#### 步骤3：查看结果
- 渲染完成后，内容将显示在主面板中
- 可以滚动查看完整内容
- 可以缩放查看图表细节

---

## 三、功能详细说明

### 3.1 文件打开与浏览功能

#### 支持的文件格式
- **Markdown 文件**: `.md`, `.markdown` - 完全支持，包括其中的 Mermaid 图表
- **文本文件**: `.txt` - 支持纯文本内容显示

#### 文件大小限制
- 默认最大支持 **10MB** 的文件
- 超过限制的文件可能无法正常加载

#### 操作步骤
1. 点击界面上的"选择文件"按钮
2. 在弹出的文件选择对话框中浏览文件
3. 选择目标文件（支持多选）
4. 点击"打开"按钮
5. 等待应用读取并渲染文件内容

### 3.2 Mermaid 图表渲染

#### 支持的图表类型
- **流程图 (flowchart)**: `graph TD`, `graph LR` 等
- **时序图 (sequence diagram)**: `sequenceDiagram`
- **状态图 (state diagram)**: `stateDiagram-v2`
- **类图 (class diagram)**: `classDiagram`
- **ER 图 (entity relationship)**: `erDiagram`
- **旅途图 (journey diagram)**: `journey`
- **甘特图 (gantt)**: `gantt`
- **其他**: Mermaid 支持的所有图表类型

#### 渲染要求
- Mermaid 代码块必须使用标准的 ```mermaid 语法
- 代码块内容必须是有效的 Mermaid 语法
- 渲染时间通常 < 3秒（10个图表以内）

#### 常见问题
**图表未显示**:
- 检查 Mermaid 语法是否正确
- 查看是否有语法错误提示
- 尝试重新打开文件

**图表显示不完整**:
- 检查代码是否有未闭合的标签
- 查看是否有不支持的语法

### 3.3 表格渲染

#### 支持的表格语法
```markdown
| 表头1 | 表头2 |
|-------|-------|
| 内容1 | 内容2 |
| 内容3 | 内容4 |
```

#### 渲染特点
- 自动识别 Markdown 表格语法
- 表格显示整齐，列宽自适应
- 支持中文内容正确显示
- 支持对齐方式（左对齐、居中、右对齐）

### 3.4 特殊字符处理

#### 已处理的特殊字符
- **版权符号**: `©` 和 `(C)` 自动转换
- **换行标签**: `<br/>` 等保留显示
- **特殊箭头**: `-->`、`->` 正常显示
- **中文标点**: 全角标点正确处理

#### 显示效果
- 中文字符正常显示，无乱码
- 特殊符号正确呈现
- 格式保持原文档结构

---

## 四、界面功能说明

### 4.1 顶部命令栏

| 功能按钮 | 说明 |
|---------|------|
| 选择文件 | 打开文件选择对话框，选择要查看的 MD 文件 |
| 渲染 MD | 手动触发渲染（通常自动触发） |

### 4.2 主内容区域

#### 显示内容
- **Markdown 文本**: 正常显示各级标题、段落、列表
- **Mermaid 图表**: 渲染为 SVG 图形
- **表格**: 渲染为 HTML 表格
- **代码块**: 使用等宽字体显示

#### 操作支持
- **滚动**: 垂直滚动查看内容
- **缩放**: 可缩放查看图表细节（浏览器环境）
- **搜索**: 可使用浏览器搜索功能（Ctrl+F）

### 4.3 状态提示

#### 加载状态
- 显示"正在加载..."提示
- 显示渲染进度（如适用）

#### 错误提示
- 文件读取错误：提示文件路径或权限问题
- 语法错误：提示具体的错误位置和原因
- 渲染失败：提示失败原因和可能的解决方案

---

## 五、典型使用场景

### 场景1：查看包含 Mermaid 图表的文档

1. 启动 MermaidReader 应用
2. 点击"选择文件"按钮
3. 选择一个包含 Mermaid 图表的 Markdown 文件
4. 等待应用自动解析和渲染
5. 在主面板中查看渲染后的完整文档

### 场景2：验证 Mermaid 语法正确性

1. 打开包含 Mermaid 语法的 Markdown 文件
2. 观察图表渲染结果
3. 如果图表未能正确渲染，查看底部错误提示
4. 根据错误提示修改原始文件中的 Mermaid 语法
5. 重新打开文件查看修正后的渲染结果

### 场景3：浏览技术文档

1. 打开包含技术文档的 MD 文件
2. 浏览文档结构（标题层级）
3. 查看流程图、时序图等可视化图表
4. 阅读表格内容

---

## 六、注意事项

### 6.1 文件限制
- 支持的文件格式：`.md`, `.markdown`
- 文件大小限制：默认最大 10MB
- 不支持嵌套文件夹浏览（浏览器环境）

### 6.2 性能建议
- 包含大量复杂 Mermaid 图表的文档可能需要较长渲染时间
- 建议一次只打开一个大型文件
- 性能较弱的设备上避免同时渲染多个图表

### 6.3 浏览器环境限制
- 部分文件选择功能可能受限
- 建议使用 Chrome 或 Edge 浏览器
- 确保允许本地文件访问

---

## 七、故障排除

### 7.1 图表未显示

**可能原因**:
1. Mermaid 语法错误
2. 不支持的 Mermaid 语法
3. 文件编码问题

**解决方案**:
1. 检查 Mermaid 代码语法
2. 查看错误提示信息
3. 尝试简化 Mermaid 代码
4. 检查文件编码（建议使用 UTF-8）

### 7.2 文件无法打开

**可能原因**:
1. 文件格式不受支持
2. 文件大小超出限制
3. 文件权限问题
4. 文件路径包含特殊字符

**解决方案**:
1. 确认文件格式为 .md 或 .markdown
2. 检查文件大小是否 < 10MB
3. 尝试移动文件到简单路径
4. 检查文件是否被其他程序占用

### 7.3 中文显示乱码

**可能原因**:
1. 文件编码不是 UTF-8
2. 浏览器编码设置问题

**解决方案**:
1. 将文件保存为 UTF-8 编码
2. 在浏览器中设置自动检测编码
3. 使用专业文本编辑器重新保存

### 7.4 渲染速度慢

**可能原因**:
1. 文件包含大量图表
2. 图表复杂度高
3. 系统资源不足

**解决方案**:
1. 等待渲染完成
2. 关闭其他占用资源的程序
3. 尝试在性能更好的设备上使用

---

## 八、技术架构

### 核心技术栈
- **前端框架**: 原生 JavaScript + HTML5
- **图表引擎**: Mermaid.js v10.x
- **Markdown 解析**: Marked.js
- **桌面框架**: NW.js（打包部署）
- **运行环境**: Chrome/Edge 浏览器

### 核心模块
1. **文件读取模块**: 读取本地文件内容
2. **Markdown 解析模块**: 解析 Markdown 语法
3. **Mermaid 渲染模块**: 渲染 Mermaid 图表
4. **表格渲染模块**: 渲染 Markdown 表格
5. **界面显示模块**: 展示渲染结果

### 依赖管理
- 所有依赖通过 npm 管理
- 本地安装，不使用 CDN
- 版本锁定在 package.json

---

## 九、版本信息

### 当前版本
- **版本号**: 1.0
- **发布日期**: 2026-01-30
- **状态**: 开发中

### 更新日志
| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0 | 2026-01-30 | 初始版本发布，包含核心功能 |

---

## 十、联系方式

### 问题反馈
如遇到问题，请提供以下信息：
1. 操作系统版本
2. 浏览器版本（如使用浏览器环境）
3. 问题描述和复现步骤
4. 错误提示信息截图

### 技术支持
- 项目文档: MermaidReader/架构决策记录.md
- 使用说明: MermaidReader/APP使用说明.md

---

## 十一、Mermaid 版本与依赖管理

### 11.1 当前版本状态

| 项目 | 值 |
|------|-----|
| package.json 声明 | `mermaid: "10.9.5"` |
| 实际安装版本 | **10.9.5** |
| 数据源 | 完全本地 (`node_modules/mermaid/dist/mermaid.min.js`) |
| 是否联网 | 否，所有环境都从本地加载 |

### 11.2 版本锁定说明

**历史背景**:
- 早期开发中曾遇到 NW.js 内置 Chromium 自带 Mermaid 与 npm 安装版本不一致的问题
- NW.js 内置版本较旧，npm 安装的是新版 (10.9.5)
- 两套 Mermaid 混用导致渲染结果不一致

**解决方案**:
```
测试脚本 → Puppeteer(独立Chromium) → 本地 mermaid.min.js (v10.9.5)
```

**优势**:
- 隔离 NW.js 环境，不受内置库影响
- 版本统一，所有测试使用同一份 mermaid.min.js
- 可复现，换个机器只要 `npm install` 就能保持一致

### 11.3 多文件兼容性

版本锁定对多文件兼容性带来以下保障:

| 好处 | 说明 |
|------|------|
| 语法一致 | 所有 MD 文件用同一版本解析，避免版本差异导致的渲染差异 |
| 特性统一 | 新版本的 `["text"]` 语法支持，确保跨文件特性一致 |
| Bug 固定 | 10.9.5 修复了之前版本的解析问题 |
| 可回溯 | 锁定版本后可以稳定复现和调试 |

### 11.4 依赖管理最佳实践

**项目规范**:

1. **版本锁定**: `package.json` 中使用精确版本号而非 semver 范围
   ```json
   "mermaid": "10.9.5"  // 正确: 锁定精确版本
   "mermaid": "^10.6.1" // 不推荐: 允许小版本升级
   ```

2. **统一渲染入口**: 所有环境统一使用本地文件
   ```
   node_modules/mermaid/dist/mermaid.min.js
   ```

3. **禁止 CDN**: 确保所有环境都从本地加载，不依赖外部网络

4. **升级流程**:
   ```
   a. 用测试脚本验证新版本兼容性
   b. 确认所有图表正常渲染
   c. 更新 package.json 中的版本号
   d. 提交代码并通知团队
   ```

### 11.5 版本升级注意事项

如果需要升级 Mermaid 版本，请按以下步骤操作:

1. **备份当前环境**: 确保当前版本工作正常
2. **安装新版本**: `npm install mermaid@新版本号`
3. **运行测试脚本**: `node MermaidReader/src/test-auto-render.js`
4. **验证渲染结果**: 检查生成的 SVG 和 HTML 是否正常
5. **更新 package.json**: 将版本号改为新版本
6. **更新本文档**: 同步更新版本信息

### 11.6 已知版本特性

**Mermaid 10.9.5 支持的文本格式**:

```mermaid
// 推荐: 使用双引号包裹复杂文本
flowchart TD
    Node["包含特殊字符的文本 © 2026"]

// 不推荐: 可能导致解析错误
flowchart TD
    Node[包含特殊字符的文本 © 2026]
```

**自动修复机制**: 测试脚本会自动将方括号格式转换为双引号格式，确保兼容性。

---

## 十二、源代码结构

### 12.1 项目目录结构

```
MermaidReader/
├── app.html              # ✅ 主渲染程序（推荐使用）
├── browser_view.html           # 浏览器渲染工具
├── package.json                # 项目配置和依赖声明
├── package-lock.json           # 依赖版本锁定文件
│
├── src/                        # 源代码目录
│   ├── index.js                # 主逻辑文件（NW.js 环境）
│   ├── browser_view.html       # 浏览器环境入口
│   ├── test-auto-render.js     # 自动化测试脚本
│   ├── App.css                 # 应用程序样式
│   ├── App.tsx                 # React 组件（未启用）
│   ├── index.css               # 入口样式
│   ├── index.tsx               # React 入口（未启用）
│   ├── types.ts                # TypeScript 类型定义
│   │
│   ├── components/             # React 组件目录（早期探索，未启用）
│   │   ├── ChartSettings.tsx   # 图表设置组件
│   │   ├── ChartSettings.css   # 图表设置样式
│   │   ├── FileExplorer.tsx    # 文件浏览器组件
│   │   ├── FileExplorer.css    # 文件浏览器样式
│   │   ├── MermaidRenderer.tsx # Mermaid渲染器组件
│   │   └── MermaidRenderer.css # Mermaid渲染器样式
│   │
│   ├── types/                  # 类型定义目录
│   │   └── chart-types.ts      # 图表类型定义
│   │
│   ├── utils/                  # 工具函数目录
│   │   ├── TableOptimizer.ts   # 表格优化工具
│   │   ├── fileSystem.ts       # 文件系统工具
│   │   └── flowchart-optimizer.ts # 流程图优化工具
│   │
│   └── test-results/           # 测试结果目录
│       └── (测试输出文件)
│
├── node_modules/               # 依赖库目录
│   ├── mermaid/                # Mermaid.js 图表库
│   ├── marked/                 # Marked.js Markdown 解析库
│   ├── highlight.js/           # 代码语法高亮库
│   ├── puppeteer/              # Puppeteer 测试环境
│   └── (其他依赖)
│
├── nwjs/                       # NW.js 运行时（用户自备）
│   └── nw.exe                  # NW.js 可执行文件
│
├── release/                    # 发布版本目录
│   └── (打包输出)
│
├── tools/                      # 工具脚本目录
│   └── (辅助工具)
│
├── APP使用说明.md              # 本使用说明文档
├── APP架构设计.md              # 架构设计文档
├── APP和系统陪测代码管理规则.md # 代码管理规范
├── 调试笔记.md                 # 开发调试记录
├── 调试记录_backup.md          # 调试记录备份
│
└── MermaidReader-v1.0.zip      # 完整备份（包含 node_modules）
```

### 12.2 核心文件说明

#### 12.2.1 `app.html` - 主渲染程序

| 属性 | 值 |
|------|-----|
| 位置 | 项目根目录 |
| 类型 | HTML 主程序 |
| 状态 | ✅ **推荐使用** |
| 功能 | 完整的 Markdown + Mermaid 渲染功能 |

**核心逻辑**:
```
1. 加载本地依赖库（mermaid.min.js, marked.min.js, highlight.min.js）
2. 提供文件选择界面
3. 读取 MD 文件内容
4. 使用 marked.js 解析 Markdown
5. 使用 mermaid.run() 渲染 Mermaid 图表
6. 使用 highlight.js 高亮代码块
7. 渲染表格（自定义 CSS 样式）
8. 显示最终结果
```

#### 12.2.2 `src/index.js` - NW.js 主逻辑

| 属性 | 值 |
|------|-----|
| 位置 | `src/index.js` |
| 类型 | JavaScript 主模块 |
| 环境 | NW.js 桌面应用 |
| 状态 | 已配置但主程序迁移至 app.html |

**功能**:
- NW.js 窗口管理
- 文件系统访问
- 应用生命周期控制

#### 12.2.3 `src/browser_view.html` - 浏览器渲染工具

| 属性 | 值 |
|------|-----|
| 位置 | `src/browser_view.html` |
| 类型 | HTML 独立工具 |
| 环境 | 浏览器（Chrome/Edge） |
| 功能 | 快速测试和调试 Mermaid 渲染 |

**特点**:
- 无需 NW.js，可直接在浏览器打开
- 适合快速验证 Mermaid 语法
- 调试时发现 `getElementById` 问题并修复
- 修复 `mermaid.init()` → `mermaid.run()` API 变更

#### 12.2.4 `src/test-auto-render.js` - 自动化测试脚本

| 属性 | 值 |
|------|-----|
| 位置 | `src/test-auto-render.js` |
| 类型 | Node.js 测试脚本 |
| 依赖 | Puppeteer |
| 功能 | 批量测试 MD 文件渲染结果 |

**测试流程**:
```
1. 扫描测试文件目录
2. 对每个 MD 文件：
   a. 复制到临时文件
   b. 修复 Mermaid 语法问题
   c. 使用 Puppeteer 渲染
   d. 生成 SVG + HTML 输出
   e. 对比预期结果
3. 生成测试报告
```

**已修复的问题**:
- ©符号 → (c)
- 特殊破折号 → ---
- [['文本']] → ["文本"]
- 方括号内引号转义

### 12.3 依赖库结构

#### 12.3.1 核心依赖

| 库名 | 版本 | 用途 | 本地路径 |
|------|------|------|----------|
| mermaid | 10.9.5 | Mermaid 图表渲染 | `node_modules/mermaid/dist/mermaid.min.js` |
| marked | 12.0.2 | Markdown 解析 | `node_modules/marked/marked.min.js` |
| highlight.js | 10.7.2 | 代码语法高亮 | `node_modules/highlight.js/build/highlight.min.js` |
| puppeteer | 23.8.0 | 自动化测试 | `node_modules/puppeteer` |

#### 12.3.2 加载顺序

```
app.html 加载顺序:
1. mermaid.min.js      (图表渲染)
2. marked.min.js       (Markdown 解析)
3. highlight.min.js    (代码高亮)
4. CSS 样式定义
5. JavaScript 逻辑
```

#### 12.3.3 版本锁定机制

**问题背景**:
- NW.js 内置 Chromium 自带 Mermaid（旧版本）
- npm 安装的是新版 (10.9.5)
- 两套版本混用导致渲染不一致

**解决方案**:
```
测试脚本 → Puppeteer(独立Chromium) → 本地 mermaid.min.js (v10.9.5)
```

**优势**:
- 隔离 NW.js 环境，不受内置库影响
- 版本统一，所有测试使用同一份 mermaid.min.js
- 可复现，换个机器只要 `npm install` 就能保持一致

### 12.4 渲染工作流程

#### 12.4.1 完整渲染流程

```
用户操作
    │
    ▼
┌─────────────────┐
│  选择 MD 文件   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  读取文件内容   │ ← FileReader / fs.readFile
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  预处理文本     │ ← 修复 ©, —, [['x']]
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Marked 解析    │ ← marked.parse(content)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  代码高亮       │ ← highlight.js
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Mermaid 渲染   │ ← mermaid.run()
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  表格美化       │ ← CSS 样式
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  显示结果       │ ← innerHTML
└─────────────────┘
```

#### 12.4.2 Mermaid 渲染细节

**代码块识别**:
```javascript
// 正则表达式
const mermaidBlock = /```mermaid\r?\n([\s\S]*?)```/g;

// 匹配示例
// ```mermaid
// graph TD
//     A[开始] --> B[结束]
// ```
```

**渲染调用**:
```javascript
// Mermaid 10.x API
mermaid.run({
    querySelector: '.mermaid'
});
```

**SVG 输出**:
```html
<div class="mermaid">
    <svg>...</svg>  <!-- 渲染后的图表 -->
</div>
```

### 12.5 备份与恢复

#### 12.5.1 完整备份

**备份文件**: `MermaidReader-v1.0.zip`

**包含内容**:
```
MermaidReader-v1.0.zip
├── MermaidReader/           # 完整项目目录
│   ├── app.html
│   ├── src/
│   ├── node_modules/        # ✅ 包含所有依赖
│   └── ...
└── (其他文件)
```

**恢复方法**:
```bash
# 1. 解压到新位置
unzip MermaidReader-v1.0.zip

# 2. 进入目录
cd MermaidReader

# 3. 验证依赖（可选）
npm install  # v1.0 已包含 node_modules，通常不需要
```

#### 12.5.2 增量备份

**未包含在 zip 中的文件**:
- `node_modules/` - 过大，已包含在 zip 中
- `src/test-results/` - 测试输出
- `nwjs/` - 用户自行下载

**手动备份建议**:
```bash
# 备份命令
zip -r MermaidReader-backup.zip . \
    -x "node_modules/*" \
    -x "src/test-results/*" \
    -x "*.log"
```

#### 12.5.3 版本回滚

**从 git 回滚**（如果启用版本控制）:
```bash
# 查看历史
git log --oneline

# 回滚到指定版本
git checkout <commit-hash>
```

**手动回滚**:
1. 找到之前的备份文件
2. 解压到临时目录
3. 对比差异文件
4. 手动恢复

### 12.6 开发调试

#### 12.6.1 调试工具

| 工具 | 用途 | 启动方式 |
|------|------|----------|
| browser_view.html | 快速调试 | 浏览器直接打开 |
| test-auto-render.js | 批量测试 | `node src/test-auto-render.js` |
| 调试笔记.md | 问题追踪 | 文本编辑器 |

#### 12.6.2 常用调试命令

```bash
# 运行自动化测试
node src/test-auto-render.js

# 查看测试结果
ls src/test-results/

# 清理测试输出
rm -rf src/test-results/*
```

#### 12.6.3 常见问题定位

| 问题 | 可能原因 | 定位文件 |
|------|----------|----------|
| 图表未渲染 | mermaid.run() 未调用 | app.html |
| 元素找不到 | getElementById 错误 | browser_view.html |
| 语法错误 | © 未转换 | test-auto-render.js |
| 样式问题 | CSS 未加载 | app.html CSS 部分 |

### 12.7 扩展开发

#### 12.7.1 添加新功能

**步骤**:
1. 在 `app.html` 中添加功能代码
2. 在 `src/index.js` 中添加对应逻辑（如需要）
3. 更新 `APP使用说明.md`
4. 运行测试脚本验证

#### 12.7.2 修改样式

**样式文件**:
- `app.html` 内嵌 CSS
- `src/App.css`（未启用 React）

**修改位置**:
```html
<!-- app.html 中的样式 -->
<style>
    /* 在此处添加/修改样式 */
</style>
```

#### 12.7.3 升级依赖

**升级 Mermaid**:
```bash
# 安装新版本
npm install mermaid@<新版本号>

# 运行测试
node src/test-auto-render.js

# 检查输出
cat src/test-results/report.txt

# 更新文档
# 1. 更新 package.json 版本号
# 2. 更新 APP使用说明.md 第11章
```

**注意事项**:
- 先备份当前环境
- 测试脚本隔离 NW.js 环境
- 确保所有图表正常渲染后再升级

### 12.8 便携版（Portable）

#### 12.8.1 便携版概述

**便携版**是一个无需安装的 Windows 应用程序，可以直接解压后运行。

**特点**:
- 无需安装，双击即可运行
- 所有依赖打包在一起
- 可以放在 U 盘或任意目录运行
- 不修改系统注册表

#### 12.8.2 便携版目录结构

```
MermaidReader-portable/
├── nw.exe                    # 主程序
├── app.html                  # 应用界面
├── package.json              # 应用配置
├── src/                      # 源代码
├── node_modules/             # 依赖库
│   ├── mermaid/              # Mermaid.js
│   ├── marked/               # Marked.js
│   └── highlight.js/         # highlight.js
├── locales/                  # 语言包（中文+英文）
│   ├── en-US.pak
│   └── zh-CN.pak
├── *.dll                     # Chromium 运行时
├── nw.pak                    # NW.js 资源包
└── ...
```

#### 12.8.3 创建便携版

**步骤**:
1. 下载 NW.js v0.107.0（win-x64 版本）
2. 解压并删除不需要的 locales（只保留 en-US.pak、zh-CN.pak）
3. 复制 app.html、package.json、src/、node_modules/ 到 NW.js 目录
4. 删除 test-results、swiftshader 等不需要的目录

**命令**:
```bash
# 解压 NW.js
unzip nwjs-v0.107.0-win-x64.zip

# 删除不需要的 locales
cd nwjs-v0.107.0-win-x64/locales
rm -f !(en-US.pak|zh-CN.pak|zh-TW.pak)

# 复制应用文件
cp ../../app.html .
cp ../../package.json .
cp -r ../../src .
cp -r ../../node_modules/mermaid ../../node_modules/marked ../../node_modules/highlight.js node_modules/

# 可选：删除不需要的目录
rm -rf swiftshark
```

#### 12.8.4 运行便携版

**方式1：双击运行**
1. 打开 `MermaidReader-portable` 目录
2. 双击 `nw.exe`
3. 应用将启动

**方式2：命令行运行**
```bash
cd MermaidReader-portable
nw.exe
```

#### 12.8.5 便携版体积

| 项目 | 大小 |
|------|------|
| 完整版（含所有 locales） | ~430MB |
| 精简版（只保留中文+英文） | ~377MB |
| 核心文件（不含测试结果） | ~377MB |

> **注意**: 便携版体积较大是因为 NW.js 内置了完整的 Chromium 浏览器引擎，这是其渲染兼容性的代价。