local console = require 'jass.console'
local runtime = require 'jass.runtime'
local tostring = tostring
local debug    = debug

--判断是否是发布版本
local release = not pcall(require, '_currentpath')
if release then
    console.enable = false
    package.path = package.path .. ';'
    .. '?\\init.lua;'
    .. 'script\\?.lua;'
    .. 'script\\?\\init.lua;'
else
    --打开控制台
    console.enable = true
end
global_test = console.enable
--重载print,自动转换编码
print = console.write
runtime.handle_level = 0
runtime.sleep = true
runtime.error_handle = function(msg)
    print("---------------------------------------")
    print("              LUA ERROR!!              ")
    print("---------------------------------------")
    print(tostring(msg) .. "\n")
    print(debug.traceback())
    print("---------------------------------------")
end

xpcall(function ()
    require 'script'
end,function (msg)
    runtime.error_handle(msg)
end)