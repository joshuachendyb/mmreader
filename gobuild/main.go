package main

import (
	"context"
	"embed"
	"fmt"
	"os"
	"path/filepath"

	"github.com/wailsapp/wails/v2"
	"github.com/wailsapp/wails/v2/pkg/options"
	"github.com/wailsapp/wails/v2/pkg/options/assetserver"
	"github.com/wailsapp/wails/v2/pkg/options/windows"
	"github.com/wailsapp/wails/v2/pkg/runtime"
)

//go:embed all:static
var assets embed.FS

// App 应用结构
type App struct {
	ctx context.Context
}

// NewApp 创建新应用实例
func NewApp() *App {
	return &App{}
}

// startup 应用启动时调用
func (a *App) startup(ctx context.Context) {
	a.ctx = ctx
}

// domReady DOM加载完成时调用
func (a *App) domReady(ctx context.Context) {}

// beforeClose 关闭前调用
func (a *App) beforeClose(ctx context.Context) (prevent bool) {
	return false
}

// shutdown 应用关闭时调用
func (a *App) shutdown(ctx context.Context) {}

// GetVersion 获取应用版本号 (暴露给前端)
// BUILD_VERSION_MARKER - 不要删除这行注释，build脚本用此标记替换版本号
func (a *App) GetVersion() string {
	return "2.0.0" // 当前版本，由build脚本自动更新
}

// OpenFileDialog 打开文件选择对话框 (暴露给前端)
func (a *App) OpenFileDialog() (string, error) {
	selection, err := runtime.OpenFileDialog(a.ctx, runtime.OpenDialogOptions{
		Title: "选择 Markdown 文件",
		Filters: []runtime.FileFilter{
			{
				DisplayName: "Markdown 文件",
				Pattern:     "*.md",
			},
			{
				DisplayName: "文本文件",
				Pattern:     "*.txt",
			},
			{
				DisplayName: "所有文件",
				Pattern:     "*.*",
			},
		},
		ShowHiddenFiles: false,
	})

	if err != nil {
		return "", err
	}

	return selection, nil
}

// ReadFile 读取文件内容 (暴露给前端)
func (a *App) ReadFile(filePath string) (string, error) {
	content, err := os.ReadFile(filePath)
	if err != nil {
		return "", err
	}
	return string(content), nil
}

// GetFileName 获取文件名 (暴露给前端)
func (a *App) GetFileName(filePath string) string {
	return filepath.Base(filePath)
}

func main() {
	app := NewApp()

	err := wails.Run(&options.App{
		Title:            "MermaidReader",
		Width:            1280,
		Height:           700,
		DisableResize:    false,
		Fullscreen:       false,
		StartHidden:      false,
		Frameless:        false,
		MinWidth:         800,
		MinHeight:        500,
		BackgroundColour: &options.RGBA{R: 27, G: 38, B: 54, A: 1},
		AssetServer: &assetserver.Options{
			Assets: assets,
		},
		OnStartup:     app.startup,
		OnDomReady:    app.domReady,
		OnBeforeClose: app.beforeClose,
		OnShutdown:    app.shutdown,
		Bind: []interface{}{
			app,
		},
		Debug: options.Debug{
			OpenInspectorOnStartup: true, // 启动时打开开发者工具
		},
		Windows: &windows.Options{
			WebviewIsTransparent:              false,
			WindowIsTranslucent:               false,
			DisableWindowIcon:                 false,
			IsZoomControlEnabled:              true,
			ZoomFactor:                        1.0,
			DisableFramelessWindowDecorations: false,
			WebviewGpuIsDisabled:              false,
		},
	})

	if err != nil {
		fmt.Println("Error:", err.Error())
		os.Exit(1)
	}
}
