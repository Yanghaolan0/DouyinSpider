@echo off
cd /d "%~dp0"

:: 1. 尝试使用 Conda 环境
where conda >nul 2>&1
if %errorlevel% == 0 (
    call conda activate Spider 2>nul
    if %errorlevel% == 0 (
        python src\main.py
        goto end
    )
)

:: 2. 尝试使用便携式 Python
if exist python\python.exe (
    python\python.exe src\main.py
    goto end
)

:: 3. 尝试使用系统 Python（解析绝对路径后再执行）
set "SYS_PY="
for /f "delims=" %%I in ('where python 2^>nul') do (
    set "SYS_PY=%%I"
    goto run_sys_python
)

echo [ERROR] 未找到可用的 Python 解释器。
goto end

:run_sys_python
"%SYS_PY%" src\main.py

:end
pause
