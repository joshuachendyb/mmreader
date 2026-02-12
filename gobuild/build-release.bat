@echo off
REM Build script for release version
REM Note: Remove chcp 65001 for Git Bash compatibility
setlocal enabledelayedexpansion

REM ========================================
REM MermaidReader Wails 构建脚本
REM 版本号由用户手动设置，不自动升级
REM ========================================

REM 设置工作目录
set BASE_DIR=%~dp0
cd /d "%BASE_DIR%"

REM ========================================
REM 版本号设置（手动修改此处）
REM ========================================
set VERSION=2.0.0
set BUILD_DATE=%date:~0,4%%date:~5,2%%date:~8,2%

REM 显示构建信息
echo ========================================
echo MermaidReader Wails 构建脚本
echo 版本: %VERSION%
echo 日期: %date% %time%
echo ========================================
echo.

REM 检查Wails环境
echo 检查Wails环境...
where wails >nul 2>nul
if %errorlevel% neq 0 (
    echo [错误] 未找到Wails命令行工具
    echo 请先安装: go install github.com/wailsapp/wails/v2/cmd/wails@latest
    pause
    exit /b 1
)

echo Wails环境检查通过
echo.

REM 清理旧构建
echo 清理旧构建文件...
if exist "build\bin" rmdir /s /q "build\bin" 2>nul
if exist "bin\MermaidReader.exe" del /f "bin\MermaidReader.exe" 2>nul
echo 清理完成
echo.

REM 执行Wails构建
echo 开始构建MermaidReader v%VERSION%...
echo 这可能需要几分钟时间...
echo.

wails build

if %errorlevel% neq 0 (
    echo.
    echo [错误] Wails构建失败!
    echo 请检查错误信息
    pause
    exit /b 1
)

echo.
echo ✅ Wails构建成功!

REM 检查构建结果
if not exist "build\bin\MermaidReader.exe" (
    echo [错误] 未找到构建输出文件
    pause
    exit /b 1
)

REM 获取文件大小
for %%i in ("build\bin\MermaidReader.exe") do set FILESIZE=%%~zi
echo 文件大小: %FILESIZE% 字节

REM 复制到bin目录
echo.
echo 复制到bin目录...
copy "build\bin\MermaidReader.exe" "bin\MermaidReader.exe" /y
if %errorlevel% neq 0 (
    echo [警告] 复制到bin目录失败，但build\bin目录中有最新版本
) else (
    echo ✅ 已复制到bin\MermaidReader.exe
)

REM 创建发布目录
set RELEASE_DIR=release_%BUILD_DATE%_v%VERSION%
echo.
echo 创建发布目录: %RELEASE_DIR%
if exist "%RELEASE_DIR%" rmdir /s /q "%RELEASE_DIR%"
mkdir "%RELEASE_DIR%"

REM 复制文件到发布目录
copy "build\bin\MermaidReader.exe" "%RELEASE_DIR%\" >nul
copy "README.md" "%RELEASE_DIR%\" >nul

REM 创建版本说明文件
echo 创建版本说明...
(
echo MermaidReader v%VERSION% - %date%
echo ============================================
echo 发布版本: %VERSION%
echo 发布日期: %date%
echo 构建时间: %time%
echo 文件大小: %FILESIZE% 字节
echo ============================================
echo.
echo 主要特性:
echo - Markdown文档阅读器
echo - Mermaid图表渲染支持
echo - 实时预览功能
echo - 主题切换（亮色/深色）
echo - 字体大小调节
echo - 目录导航（TOC）
echo - 滚动同步高亮
echo - 最近文件列表
echo - 错误日志记录（调试用）
echo.
echo 修复内容:
echo - 全局错误捕获机制
echo - 图表渲染错误隔离
echo - 中文引号兼容性
echo - 窗口边框优化
echo.
echo 已知问题:
echo - Windows系统窗口边框在某些环境可能不显示
echo.
echo 使用说明:
echo 1. 运行MermaidReader.exe
echo 2. 点击"打开文件"选择.md文件
echo 3. 查看目录导航和图表渲染
echo.
echo 调试功能:
echo - 在控制台输入 showErrorLogs() 查看错误历史
echo - 输入 clearErrorLogs() 清空错误日志
echo ============================================
) > "%RELEASE_DIR%\VERSION.txt"

REM 创建压缩包
echo.
echo 创建压缩包...
set ZIP_FILE=%RELEASE_DIR%.zip
if exist "%ZIP_FILE%" del /f "%ZIP_FILE%"
powershell -Command "Compress-Archive -Path '%RELEASE_DIR%' -DestinationPath '%ZIP_FILE%' -Force" >nul 2>&1

if exist "%ZIP_FILE%" (
    echo ✅ 压缩包创建成功: %ZIP_FILE%
    for %%i in ("%ZIP_FILE%") do echo 压缩包大小: %%~zi 字节
) else (
    echo [警告] 压缩包创建失败
)

echo.
echo ========================================
echo 🎉 构建完成!
echo ========================================
echo 📁 构建输出: build\bin\MermaidReader.exe
echo 📁 复制位置: bin\MermaidReader.exe
echo 📁 发布目录: %RELEASE_DIR%
echo 📦 发布包: %ZIP_FILE%
echo 📊 版本: %VERSION%
echo ========================================
echo.
echo 版本升级说明:
echo - 如需升级版本，请手动修改此脚本第19行的VERSION变量
echo - 当前版本: %VERSION%
echo.

REM 打开发布目录
start "" "%RELEASE_DIR%"

endlocal
