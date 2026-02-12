@echo off
REM Build script for MermaidReader
REM IMPORTANT: This script preserves UTF-8 encoding in main.go

echo ========================================
echo MermaidReader Build Script
echo ========================================
echo.

REM Get script directory
set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

REM 1. Read current version
echo [1/5] Reading current version...
if not exist "version.txt" (
    echo 1.5.6 > version.txt
)
set /p CURRENT_VERSION=<version.txt
echo     Current version: %CURRENT_VERSION%

REM 2. Parse version (MAJOR.MINOR.PATCH)
for /f "tokens=1,2,3 delims=." %%a in ("%CURRENT_VERSION%") do (
    set MAJOR=%%a
    set MINOR=%%b
    set PATCH=%%c
)

REM 3. Auto increment patch version
echo [2/5] Upgrading version...
set /a NEW_PATCH=%PATCH% + 1
set NEW_VERSION=%MAJOR%.%MINOR%.%NEW_PATCH%
echo     New version: %NEW_VERSION%

REM 4. Update version.txt
echo %NEW_VERSION% > version.txt
echo     version.txt updated

REM 5. Update main.go version using sed (Git Bash)
echo [3/5] Updating main.go version...
REM Use Git Bash sed which preserves UTF-8 encoding
"C:\Program Files\Git\usr\bin\sed.exe" -i "s/return \"[^\"]*\" \/\/ 当前版本，由build脚本自动更新/return \"%NEW_VERSION%\" \/\/ 当前版本，由build脚本自动更新/" main.go 2>nul
if %errorlevel% neq 0 (
    echo     Warning: sed failed, main.go may not be updated
    echo     Please manually update main.go line 49 to: return "%NEW_VERSION%"
)
echo     main.go updated

REM 6. Verify version update
echo [4/5] Verifying version update...
findstr "return \"%NEW_VERSION%\"" main.go >nul
if %errorlevel% equ 0 (
    echo     Verification: OK
) else (
    echo     Warning: Version update verification failed
)

REM 7. Execute Wails Build
echo [5/5] Starting Build...
echo.
wails build

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Build Success!
echo Version: %NEW_VERSION%
echo ========================================

REM 8. Copy to bin directory
echo.
echo Copying to bin directory...
copy "build\bin\MermaidReader.exe" "bin\MermaidReader.exe" /y
echo Done!

pause
