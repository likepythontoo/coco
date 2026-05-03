@echo off
chcp 65001 > nul
title GitHub 高级自定义上传工具
mode con cols=60 lines=20
color 0A

:: 美化标题
echo.
echo  ============================================================
echo                🎯 GitHub 自定义一键上传
echo  ============================================================
echo.

:: 核心：让用户输入自定义更新内容
set "commit_msg="
set /p "commit_msg=✏️  请输入本次更新说明："

:: 判断是否输入内容，没输入就用默认
if not defined commit_msg (
    set commit_msg=日常更新
)

echo.
echo ------------------------------------------------------------
echo [1/3] 正在扫描并添加所有文件...
git add . >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo ❌ 错误：文件添加失败！
    goto pauseEnd
)

echo [2/3] 正在提交：%commit_msg%
git commit -m "%commit_msg%" >nul 2>&1
if %errorlevel% equ 1 (
    echo ℹ️  提示：没有任何文件修改，无需上传！
    goto pauseEnd
)

echo [3/3] 正在推送到GitHub云端...
git push >nul 2>&1
if %errorlevel% neq 0 (
    color 0C
    echo ❌ 错误：上传失败！检查网络或仓库配置
    goto pauseEnd
)

:: 上传成功
color 0A
echo.
echo  ============================================================
echo                    ✅ 上传全部完成！
echo  ============================================================
echo.

:pauseEnd
echo 按任意键退出程序...
pause >nul