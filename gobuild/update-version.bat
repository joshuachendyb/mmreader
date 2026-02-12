@echo off
chcp 65001

REM 版本号自动升级脚本
REM 用户指定前两组（如1.4），第三组自动递增

set VERSION_FILE=version.txt

REM 读取当前版本
if not exist %VERSION_FILE% (
    echo 1.4.0 > %VERSION_FILE%
)

set /p CURRENT_VERSION=<%VERSION_FILE%

REM 解析版本号（格式：x.y.z）
for /f "tokens=1,2,3 delims=." %%a in ("%CURRENT_VERSION%") do (
    set MAJOR=%%a
    set MINOR=%%b
    set PATCH=%%c
)

REM 递增第三组版本号
set /a NEW_PATCH=%PATCH% + 1

REM 如果第三组超过99，可以重置或进位（这里保持简单，允许到999）
if %NEW_PATCH% gtr 999 (
    set NEW_PATCH=1
)

REM 生成新版本号
set NEW_VERSION=%MAJOR%.%MINOR%.%NEW_PATCH%

REM 写入文件
echo %NEW_VERSION% > %VERSION_FILE%

echo 版本号已更新: %CURRENT_VERSION% -^> %NEW_VERSION%
