#!/bin/bash
# Build script for MermaidReader - Git Bash version

echo "========================================"
echo "MermaidReader Build Script (Git Bash)"
echo "========================================"
echo ""

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# 1. Read current version
echo "[1/4] Reading current version..."
if [ ! -f "version.txt" ]; then
    echo "1.5.0" > version.txt
fi
CURRENT_VERSION=$(cat version.txt)
echo "    Current version: $CURRENT_VERSION"

# 2. Parse version (MAJOR.MINOR.PATCH)
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# 3. Auto increment patch version
echo "[2/4] Upgrading version..."
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"
echo "    New version: $NEW_VERSION"

# 4. Update version.txt
echo "$NEW_VERSION" > version.txt
echo "    version.txt updated"

# 5. Update main.go version using sed
echo "[3/4] Updating main.go version..."
# Match the Chinese comment pattern
sed -i "s/return \"[^\"]*\" \/\/ 当前版本，由build脚本自动更新/return \"$NEW_VERSION\" \/\/ 当前版本，由build脚本自动更新/" main.go
echo "    main.go updated"

# 6. Execute Wails Build
echo "[4/4] Starting Build..."
echo ""
wails build

if [ $? -ne 0 ]; then
    echo ""
    echo "[ERROR] Build failed!"
    exit 1
fi

echo ""
echo "========================================"
echo "Build Success!"
echo "Version: $NEW_VERSION"
echo "========================================"

# 7. Copy to bin directory
echo ""
echo "Copying to bin directory..."
cp "build/bin/MermaidReader.exe" "bin/MermaidReader.exe"
echo "Done!"

read -p "Press Enter to continue..."
