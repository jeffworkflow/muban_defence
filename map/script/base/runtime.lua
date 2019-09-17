local runtime = require 'jass.runtime'
local console = require 'jass.console'

local tostring = tostring
local debug    = debug
--开启控制台 全局测试 true 开启 上传地图前需要先调为 false 
console.enable = false
global_test = console.enable

if console.enable then 
    print = console.write
else
    -- print = function  (...)
    --     local args={...}
    --     local s = ''
    --     for index = 1 , #args do 
    --         s = s..tostring(args[index])..'   '
    --     end
    --     -- 关闭控制台后，print值不在游戏内显示。
    --     BJDebugMsg(s)
    -- end
end
--阿七为2 ，英萌为0
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

function sortpairs(t)
    local mt
    local func 
    local sort = {}
    for k, v in pairs(t) do
        sort[#sort+1] = {k, v}
    end
    table.sort(sort, function (a, b)
        return a[1] < b[1]
    end)
    local n = 1
    return function()
        local v = sort[n]
        if not v then
            return
        end
        n = n + 1
        return v[1], v[2]
    end
end
-- local dbg = require("jass.debug")
-- rawset(dbg,'gchash',function () end)
