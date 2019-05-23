@echo off
cd /d %~dp0

set root=%~dp0
set source=%root%\resource
set temp_file=%root%\temp.txt

::2.luac 加密 并替换map\script的lua文件 start /wait --开启新窗口并后台运行
dir /b /s %source%\*.jpg %source%\*.png %source%\*.gif %source%\*.zip %source%\*.rar> "%temp_file%"
for /f %%G in (%temp_file%) do "echo %%G"
pause




