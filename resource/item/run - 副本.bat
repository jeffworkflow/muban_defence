@echo off
::utf8
chcp 65001
set root=%~dp0
set source=%root%resource\
set target=%root%filelist.lua

echo %root% 
echo %source% 
echo %target% 


::处理字符串
echo local str = [[ > "%target%"
dir /b /s %root%*.blp  >> "%target%"
echo ]] >> "%target%"
echo return str >> "%target%"

::在lua 里面随机生成物品及对应的blp
chcp 65001 && start /wait lua item_prd.lua

::删除resource 文件夹
rd /s /q %source%
md resource
::cp 子文件夹的 文件到 resource
for /f %%G in (%target%) do  copy  "%%G" "%source%" /y 

pause
