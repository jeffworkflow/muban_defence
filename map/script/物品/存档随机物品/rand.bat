@echo off
del %cd%\ItemData.ini

chcp 65001 && lua "%cd%\´æµµËæ»úÎïÆ·.lua" >> %cd%\ItemData.ini
pause