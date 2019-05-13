@echo off
cd /d %~dp0

set war3Path=E:\Warcraft3
set ydwePath=D:\fengchao\ydwe1.3.2
set w3x2lni=D:\fengchao\w3x2lni_v2.4.1 

set mapOutPath=%war3Path%\maps\vscode

::echo "%cd%"
set mapPath=%~dp0
set mapPath=%mapPath:~0,-1%
set mapName=MoeHero

::打包地图
"%w3x2lni%\w2l.exe" obj "%mapPath%" "%~dp0%mapName%.w3x"

cd %ydwePath%
echo "%~dp0%mapName%.w3x"
ydwe.exe -war3 -loadfile "%~dp0%mapName%.w3x"
::pause

