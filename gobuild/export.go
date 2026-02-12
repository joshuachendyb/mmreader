package main

import (
	"fmt"
	"path/filepath"
	"regexp"
	"strings"

	"github.com/gomutex/godocx"
	"github.com/gomutex/godocx/docx"
	"github.com/gomutex/godocx/wml/stypes"
	"github.com/wailsapp/wails/v2/pkg/runtime"
)

// ExportMarkdownToDocx 将 Markdown 导出为 DOCX 文件
func (a *App) ExportMarkdownToDocx(content string, suggestedName string) (string, error) {
	// 打开保存对话框
	savePath, err := runtime.SaveFileDialog(a.ctx, runtime.SaveDialogOptions{
		Title:           "导出 Word 文档",
		DefaultFilename: suggestedName,
		Filters: []runtime.FileFilter{
			{
				DisplayName: "Word 文档",
				Pattern:     "*.docx",
			},
		},
	})

	if err != nil {
		return "", fmt.Errorf("选择保存位置失败: %v", err)
	}

	if savePath == "" {
		return "", fmt.Errorf("用户取消了保存")
	}

	// 确保扩展名为 .docx
	if !strings.HasSuffix(strings.ToLower(savePath), ".docx") {
		savePath = savePath + ".docx"
	}

	// 创建 DOCX 文档
	doc, err := godocx.NewDocument()
	if err != nil {
		return "", fmt.Errorf("创建文档失败: %v", err)
	}

	// 解析 Markdown 并生成 DOCX 内容
	err = parseMarkdownToDocx(content, doc)
	if err != nil {
		return "", fmt.Errorf("解析 Markdown 失败: %v", err)
	}

	// 保存文档
	err = doc.SaveTo(savePath)
	if err != nil {
		return "", fmt.Errorf("保存文档失败: %v", err)
	}

	return savePath, nil
}

// parseMarkdownToDocx 解析 Markdown 并填充 DOCX 文档
func parseMarkdownToDocx(content string, doc *docx.RootDoc) error {
	lines := strings.Split(content, "\n")
	var inCodeBlock bool
	var codeBlockLang string
	var codeBlockContent []string
	var inTable bool
	var tableHeaders []string
	var tableRows [][]string

	for i := 0; i < len(lines); i++ {
		line := lines[i]
		trimmed := strings.TrimSpace(line)

		// 处理代码块
		if strings.HasPrefix(trimmed, "```") {
			if !inCodeBlock {
				// 开始代码块
				inCodeBlock = true
				codeBlockLang = strings.TrimSpace(trimmed[3:])
				codeBlockContent = []string{}
			} else {
				// 结束代码块
				inCodeBlock = false
				addCodeBlockToDocx(doc, codeBlockLang, codeBlockContent)
				codeBlockLang = ""
				codeBlockContent = nil
			}
			continue
		}

		if inCodeBlock {
			codeBlockContent = append(codeBlockContent, line)
			continue
		}

		// 处理表格
		if strings.HasPrefix(trimmed, "|") && strings.HasSuffix(trimmed, "|") {
			// 检查是否是分隔行（包含 --- ）
			if strings.Contains(trimmed, "---") {
				// 这是分隔行，跳过
				continue
			}

			if !inTable {
				inTable = true
				tableHeaders = []string{}
				tableRows = [][]string{}
			}

			// 解析表格行
			cells := parseTableRow(trimmed)
			if len(tableHeaders) == 0 {
				tableHeaders = cells
			} else {
				tableRows = append(tableRows, cells)
			}
			continue
		} else if inTable {
			// 表格结束，创建表格
			addTableToDocx(doc, tableHeaders, tableRows)
			inTable = false
			tableHeaders = nil
			tableRows = nil
		}

		// 处理标题
		if strings.HasPrefix(trimmed, "# ") {
			title := strings.TrimSpace(trimmed[2:])
			doc.AddHeading(title, 0)
			continue
		}
		if strings.HasPrefix(trimmed, "## ") {
			title := strings.TrimSpace(trimmed[3:])
			doc.AddHeading(title, 1)
			continue
		}
		if strings.HasPrefix(trimmed, "### ") {
			title := strings.TrimSpace(trimmed[4:])
			doc.AddHeading(title, 2)
			continue
		}
		if strings.HasPrefix(trimmed, "#### ") {
			title := strings.TrimSpace(trimmed[5:])
			doc.AddHeading(title, 3)
			continue
		}
		if strings.HasPrefix(trimmed, "##### ") {
			title := strings.TrimSpace(trimmed[6:])
			doc.AddHeading(title, 4)
			continue
		}
		if strings.HasPrefix(trimmed, "###### ") {
			title := strings.TrimSpace(trimmed[7:])
			doc.AddHeading(title, 5)
			continue
		}

		// 处理列表
		if strings.HasPrefix(trimmed, "- ") || strings.HasPrefix(trimmed, "* ") {
			item := strings.TrimSpace(trimmed[2:])
			doc.AddParagraph(item).Style("List Bullet")
			continue
		}
		if matched, _ := regexp.MatchString(`^\d+\.\s`, trimmed); matched {
			item := regexp.MustCompile(`^\d+\.\s*`).ReplaceAllString(trimmed, "")
			doc.AddParagraph(item).Style("List Number")
			continue
		}

		// 处理引用块
		if strings.HasPrefix(trimmed, "> ") {
			quote := strings.TrimSpace(trimmed[2:])
			doc.AddParagraph(quote).Style("Quote")
			continue
		}

		// 处理分隔线
		if trimmed == "---" || trimmed == "***" || trimmed == "___" {
			p := doc.AddParagraph("─────────────────────────────")
			p.Justification(stypes.JustificationCenter)
			continue
		}

		// 处理普通段落（包含行内格式）
		if trimmed != "" {
			addParagraphWithInlineStyles(doc, trimmed)
		}
	}

	// 处理未闭合的代码块
	if inCodeBlock && len(codeBlockContent) > 0 {
		addCodeBlockToDocx(doc, codeBlockLang, codeBlockContent)
	}

	// 处理未闭合的表格
	if inTable && len(tableHeaders) > 0 {
		addTableToDocx(doc, tableHeaders, tableRows)
	}

	return nil
}

// parseTableRow 解析表格行
func parseTableRow(line string) []string {
	// 移除首尾的 |
	line = strings.Trim(line, "| ")
	// 分割单元格
	cells := strings.Split(line, "|")
	result := make([]string, 0, len(cells))
	for _, cell := range cells {
		result = append(result, strings.TrimSpace(cell))
	}
	return result
}

// addTableToDocx 添加表格到文档
func addTableToDocx(doc *docx.RootDoc, headers []string, rows [][]string) {
	if len(headers) == 0 {
		return
	}

	table := doc.AddTable()
	table.Style("Table Grid")

	// 添加表头
	hdrRow := table.AddRow()
	for _, header := range headers {
		hdrRow.AddCell().AddParagraph(header)
	}

	// 添加数据行
	for _, row := range rows {
		dataRow := table.AddRow()
		for i, cell := range row {
			if i < len(headers) {
				dataRow.AddCell().AddParagraph(cell)
			}
		}
	}
}

// addCodeBlockToDocx 添加代码块到文档
func addCodeBlockToDocx(doc *docx.RootDoc, lang string, lines []string) {
	// 添加语言标签（如果有）
	if lang != "" {
		langPara := doc.AddParagraph("")
		langPara.AddText("[" + lang + "]").Italic(true).Size(20)
	}

	// 添加代码内容
	codeText := strings.Join(lines, "\n")
	doc.AddParagraph(codeText)

	// 添加空行分隔
	doc.AddEmptyParagraph()
}

// addParagraphWithInlineStyles 添加段落（支持行内格式）
func addParagraphWithInlineStyles(doc *docx.RootDoc, text string) {
	p := doc.AddParagraph("")

	// 处理行内格式：粗体 **text**，斜体 *text*，代码 `code`，删除线 ~~text~~
	// 使用正则表达式匹配所有格式标记
	pattern := regexp.MustCompile(`(\*\*.*?\*\*|\*[^*]+\*|__[^_]+__|_[^_]+_|` + "`" + `[^` + "`" + `]+` + "`" + `|~~[^~]+~~)`)

	lastIndex := 0
	matches := pattern.FindAllStringIndex(text, -1)

	for _, match := range matches {
		// 添加匹配前的普通文本
		if match[0] > lastIndex {
			p.AddText(text[lastIndex:match[0]])
		}

		// 处理匹配到的格式文本
		part := text[match[0]:match[1]]
		processInlineStyle(p, part)

		lastIndex = match[1]
	}

	// 添加剩余的普通文本
	if lastIndex < len(text) {
		p.AddText(text[lastIndex:])
	}
}

// processInlineStyle 处理行内样式
func processInlineStyle(p *docx.Paragraph, part string) {
	switch {
	case strings.HasPrefix(part, "**") && strings.HasSuffix(part, "**"):
		// 粗体
		content := part[2 : len(part)-2]
		p.AddText(content).Bold(true)
	case strings.HasPrefix(part, "*") && strings.HasSuffix(part, "*"):
		// 斜体
		content := part[1 : len(part)-1]
		p.AddText(content).Italic(true)
	case strings.HasPrefix(part, "__") && strings.HasSuffix(part, "__"):
		// 粗体（下划线形式）
		content := part[2 : len(part)-2]
		p.AddText(content).Bold(true)
	case strings.HasPrefix(part, "_") && strings.HasSuffix(part, "_"):
		// 斜体（下划线形式）
		content := part[1 : len(part)-1]
		p.AddText(content).Italic(true)
	case strings.HasPrefix(part, "`") && strings.HasSuffix(part, "`"):
		// 行内代码
		content := part[1 : len(part)-1]
		p.AddText(content)
	case strings.HasPrefix(part, "~~") && strings.HasSuffix(part, "~~"):
		// 删除线
		content := part[2 : len(part)-2]
		run := p.AddText(content)
		_ = run // 删除线需要特殊处理，暂时忽略
	default:
		// 普通文本
		p.AddText(part)
	}
}

// GetSuggestedExportName 获取建议的导出文件名
func (a *App) GetSuggestedExportName(filePath string) string {
	if filePath == "" {
		return "document.docx"
	}

	// 获取文件名（不含扩展名）
	base := filepath.Base(filePath)
	ext := filepath.Ext(base)
	name := strings.TrimSuffix(base, ext)

	return name + ".docx"
}
