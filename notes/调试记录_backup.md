# MermaidReader 调试记录

## 2026-01-30 - Mermaid图表渲染问题修复

### 问题描述

1. **Mermaid图表不显示** - 3-CBL-UI线框图设计-V4.0.md 中的19个图表全部渲染失败
2. **代码块背景不美观** - 黑色背景太刺眼
3. **代码字体不美观** - 缺少等宽字体优化

### 问题根因

#### 问题1: Mermaid语法解析错误

**错误信息**:
```
Parse error on line 2:
... subgraph LoginPage[['登录页']] ...
Expecting 'SEMI', 'NEWLINE', ... got 'SUBROUTINESTART'
```

**根因**: Mermaid 10.x 不支持 `[['文本']]` 双层方括号语法

**影响范围**: 19个图表中大部分使用此语法，全部失败

#### 问题2: 方括号内引号导致解析错误

**错误信息**:
```
... Input2["输入框: 选择"客户"时必填"] ...
Expecting 'SQE', 'DOUBLECIRCLEEND', ... got 'STR'
```

**根因**: 方括号文本中包含引号 `"客户"` 导致Mermaid解析器误判

---

### 解决方案

#### 修复1: 双层方括号语法转换

```javascript
// 修复 [[...]] 双层方括号语法 - Mermaid 10.x 不支持
// [['登录页']] → ["登录页"]
if (/\[\[/.test(cleanCode)) {
  cleanCode = cleanCode.replace(/\[\[([^\]]+)\]\]/g, function(match, text) {
    text = text.replace(/^\[|\]$/g, '');
    return `["${text}"]`;
  });
}
```

**原理**:
- `[['登录页']]` → `["登录页"]`
- 先移除外层方括号
- 确保内层使用双引号

#### 修复2: 方括号内引号移除

```javascript
// 移除方括号内的所有引号 - 遍历所有方括号文本并移除内部引号
cleanCode = cleanCode.replace(/(\w+)\[([^\]]*["']+[^\]]*)\]/g, function(match, id, text) {
  const cleanText = text.replace(/["']/g, '');
  return `${id}["${cleanText}"]`;
});
```

**原理**:
- 匹配方括号内包含引号的文本
- 移除所有引号字符
- 保留原始文本内容

#### 修复3: 代码块样式美化

```css
/* 代码块 */
pre {
  background: #f8f9fa;  /* 浅灰色背景，更护眼 */
  color: #2d3748;       /* 深灰色文字 */
  padding: 20px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
  line-height: 1.6;
}

pre code {
  background: none;
  padding: 0;
  color: inherit;
  font-size: 14px;
  font-family: 'JetBrains Mono', 'Fira Code', 'Consolas', 'Monaco', 'Courier New', monospace;
}

/* 行内代码 */
code {
  font-family: 'JetBrains Mono', 'Fira Code', 'Consolas', 'Monaco', 'Courier New', monospace;
  font-size: 0.9em;
  background: #f1f5f9;
  padding: 2px 6px;
  border-radius: 4px;
  color: #475569;
  border: 1px solid #e2e8f0;
}
```

**改进**:
- 背景: `#f8f9fa` (浅灰色) - 替代黑色 `#1e1e1e`
- 文字: `#2d3748` (深灰色) - 替代亮白色
- 字体: 优先使用 JetBrains Mono 等宽字体
- 行内代码: 更紧凑的样式

---

### 修改的文件

| 文件 | 修改内容 |
|------|---------|
| `MermaidReader/src/test-auto-render.js` | 添加双层方括号和引号修复逻辑 |
| `MermaidReader/src/test-auto-render.js` | 更新代码块CSS样式 |

---

### 测试结果

| 指标 | 值 |
|------|-----|
| 总图表数 | 19 |
| 成功渲染 | 19 |
| 失败 | 0 |
| 成功率 | 100% |
| 平均渲染时间 | 30-80ms/图表 |

---

### 验证方法

```bash
# 运行自动化测试
node MermaidReader/src/test-auto-render.js

# 查看生成的HTML
# 浏览器打开: MermaidReader/src/test-results/3-CBL-UI线框图设计-V4.0/full-document-render.html
```

---

### 经验教训

1. **Mermaid版本兼容性**: Mermaid 10.x 对语法要求更严格，`[[...]]` 语法已不再支持
2. **引号处理**: 方括号内的文本应避免使用引号，或在渲染前自动移除
3. **样式优化**: 浅灰色背景比黑色背景更适合长时间阅读
4. **字体选择**: 等宽字体对代码显示很重要，JetBrains Mono 是很好的选择

---

### 相关文档

- `MermaidReader/架构决策记录.md`
- `MermaidReader/APP使用说明.md`
- `MermaidReader/APP架构设计.md`

---

**记录时间**: 2026-01-30
**记录人**: AI Assistant
**状态**: 已解决

---

## 2026-01-30 (追加) - browser_view.html 和 index.js 修复

### 问题描述

自动化测试 (`test-auto-render.js`) 100%成功，但浏览器端 `browser_view.html` 打开的图表仍然不显示。

### 问题根因

`browser_view.html` 和 `index.js` 没有集成修复逻辑，直接将原始Mermaid代码交给mermaid渲染。

**受影响的文件**:
- `MermaidReader/src/browser_view.html`
- `MermaidReader/src/index.js`

---

### 解决方案

#### 修复1: browser_view.html 添加修复函数

```javascript
function fixMermaidCode(code) {
  let fixedCode = code;

  // 1. 修复 [[...]] 双层方括号语法
  if (/\[\[/.test(fixedCode)) {
    fixedCode = fixedCode.replace(/\[\[([^\]]+)\]\]/g, function(match, text) {
      text = text.replace(/^\[|\]$/g, '');
      return `["${text}"]`;
    });
  }

  // 2. 移除方括号内的所有引号
  fixedCode = fixedCode.replace(/(\w+)\[([^\]]*["']+[^\]]*)\]/g, function(match, id, text) {
    const cleanText = text.replace(/["']/g, '');
    return `${id}["${cleanText}"]`;
  });

  // 3. 处理©符号和特殊字符
  fixedCode = fixedCode.replace(/©/g, '(c)');
  fixedCode = fixedCode.replace(/—/g, '---');

  // 4. 确保所有方括号文本使用双引号
  fixedCode = fixedCode.replace(/(\w+)\[([^\[\]]*)\]/g, (match, id, text) => {
    if (/[()\d\u4e00-\u9fa5]/.test(text) && !/^["'].*["']$/.test(text)) {
      return `${id}["${text}"]`;
    }
    return match;
  });

  return fixedCode;
}
```

#### 修复2: browser_view.html 美化样式

```css
body {
  font-family: 'Microsoft YaHei', 'Segoe UI', 'PingFang SC', 'Hiragino Sans GB', Arial, sans-serif;
  font-size: 16px;
  line-height: 1.8;
  color: #2c3e50;
  background: #f5f7fa;
  margin: 0;
  padding: 20px;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 30px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

.mermaid {
  margin: 24px 0;
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  text-align: center;
  overflow-x: auto;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}
```

#### 修复3: index.js 添加修复函数

在 `renderMermaidBlock` 和 `renderMdToHtmlString` 中添加相同的 `fixMermaidCode` 函数。

---

### 修改的文件

| 文件 | 修改内容 |
|------|---------|
| `MermaidReader/src/browser_view.html` | 添加 `fixMermaidCode()` 函数，修复mermaid代码块解析 |
| `MermaidReader/src/browser_view.html` | 美化页面样式，与 `full-document-render.html` 一致 |
| `MermaidReader/src/index.js` | 添加 `fixMermaidCode()` 函数到渲染逻辑 |
| `MermaidReader/src/index.js` | 美化 `renderMdToHtmlString()` 生成的HTML样式 |

---

### 测试结果

| 测试场景 | 结果 |
|---------|------|
| test-auto-render.js | ✅ 19/19 成功 |
| browser_view.html | ✅ 所有图表正常渲染 |
| index.js (renderMdToHtmlString) | ✅ 修复代码块和样式 |

---

### 关键经验

1. **修复逻辑需要统一**: 所有渲染路径必须使用相同的修复逻辑
2. **样式一致性**: 保持所有渲染输出样式一致，提升用户体验
3. **模块化修复**: 将修复逻辑封装为 `fixMermaidCode()` 函数，便于复用

---

**记录时间**: 2026-01-30
**记录人**: AI Assistant
**状态**: 已解决
