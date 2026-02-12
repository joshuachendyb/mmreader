@echo off
REM MermaidReader 便携版打包脚本

set SRC_DIR=..\..\release\v1.2-dark-mode\portable
set OUTPUT_DIR=..\..\release\MermaidReader-v1.2-portable
set ZIP_FILE=..\..\release\MermaidReader-v1.2-portable.zip

echo 打包 MermaidReader 便携版...

REM 创建输出目录
if exist "%OUTPUT_DIR%" rmdir /s /q "%OUTPUT_DIR%"
mkdir "%OUTPUT_DIR%"

REM 复制文件
xcopy "%SRC_DIR%\*" "%OUTPUT_DIR%\" /e /i /q

REM 打包成 zip
powershell -Command "Compress-Archive -Path '%OUTPUT_DIR%' -DestinationPath '%ZIP_FILE%' -Force"

REM 显示结果
echo.
echo 打包完成！
echo 输出目录: %OUTPUT_DIR%
echo 压缩包: %ZIP_FILE%

REM 显示大小
for %%i in ("%ZIP_FILE%") do echo 文件大小: %%~zi 字节

pause