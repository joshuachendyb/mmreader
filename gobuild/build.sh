#!/bin/bash

# MermaidReader 构建脚本
# 使用 Bash 编写的跨平台构建脚本

set -e

# 设置工作目录
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE_DIR"

echo "========================================"
echo "MermaidReader 构建脚本"
echo "时间: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================"

# 设置输出目录
OUTPUT_DIR="bin"
RELEASE_DIR="release_$(date '+%Y%m%d_%H%M%S')"

# 清理旧文件
if [ -d "$OUTPUT_DIR" ]; then
    echo "清理旧文件..."
    rm -rf "$OUTPUT_DIR"
fi

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 获取版本号
VERSION=$(date '+%Y%m%d')

echo "构建应用..."
go build -ldflags="-s -w -X main.version=$VERSION" -o "$OUTPUT_DIR/MermaidReader.exe" main.go

# 检查构建结果
if [ ! -f "$OUTPUT_DIR/MermaidReader.exe" ]; then
    echo "❌ 构建失败!"
    exit 1
fi

echo "✅ 构建成功!"

# 获取文件大小
FILESIZE=$(stat -f%z "$OUTPUT_DIR/MermaidReader.exe" 2>/dev/null || stat -c%s "$OUTPUT_DIR/MermaidReader.exe")
echo "文件大小: $FILESIZE 字节"

# 压缩可执行文件（如果 UPX 可用）
if command -v upx && upx --version >/dev/null 2>&1; then
    echo "压缩可执行文件..."
    upx "$OUTPUT_DIR/MermaidReader.exe"
    
    COMPRESSED_SIZE=$(stat -f%z "$OUTPUT_DIR/MermaidReader.exe" 2>/dev/null || stat -c%s "$OUTPUT_DIR/MermaidReader.exe")
    echo "✅ 压缩完成! 原始大小: $FILESIZE 字节, 压缩后: $COMPRESSED_SIZE 字节"
else
    echo "UPX 未找到，跳过压缩"
fi

# 创建发布目录
echo "创建发布包..."
mkdir -p "$RELEASE_DIR"

# 复制文件
cp "$OUTPUT_DIR/MermaidReader.exe" "$RELEASE_DIR/"
cp "README.md" "$RELEASE_DIR/"

# 创建版本说明
cat > "$RELEASE_DIR/VERSION.txt" << EOF
MermaidReader v$VERSION - $(date '+%Y-%m-%d')
============================================
发布版本: $VERSION
发布日期: $(date '+%Y-%m-%d')
文件大小: $FILESIZE 字节
$(if [ "$COMPRESSED_SIZE" ]; then echo "压缩后大小: $COMPRESSED_SIZE 字节"; fi)
============================================
主要特性:
- Mermaid 图表编辑器
- 实时预览功能
- 主题切换支持
- 文件操作功能
- SVG/PNG 导出
EOF

# 创建压缩包
if command -v zip >/dev/null 2>&1; then
    echo "创建压缩包..."
    zip -r "$RELEASE_DIR.zip" "$RELEASE_DIR"
fi

# 显示构建结果
echo ""
echo "🎉 构建完成!"
echo "📁 输出目录: $OUTPUT_DIR"
echo "📁 发布目录: $RELEASE_DIR"
echo "📦 发布包: $RELEASE_DIR.zip"
echo "📊 版本: $VERSION"

# 打开发布目录
if command -v open >/dev/null 2>&1; then
    open "$RELEASE_DIR"
elif command -v explorer >/dev/null 2>&1; then
    explorer "$RELEASE_DIR"
fi