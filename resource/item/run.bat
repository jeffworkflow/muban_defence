@echo off
::utf8
chcp 65001
set root=%~dp0
set source=%root%
set target=%root%filelist.txt

echo %root% 
echo %source% 
echo %target% 


::处理字符串
dir /b /s %root%*.blp  >> "%target%"

::cp 子文件夹的 文件到 resource
for /f %%G in (%target%) do  copy  "%%G" "%source%" /y 

pause
