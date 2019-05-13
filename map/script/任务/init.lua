local mt = {}

mt.__index = function (self,key)
    local tbl = rawget(self,key)
    if tbl == nil then 
        tbl = {}
        rawset(self,key,tbl)
    end 
    return tbl
end

mt.__call = function (self,tbl)
    if #tbl == 0 then 
        return 
    end 
    local key = tbl[1]
    local object = self[key]
    for i=2,#tbl do 
        self[tbl[i]] = self[key]
    end 
end

rawset(japi,'task',{})
setmetatable(japi.task,mt)

require '任务.trigger'

local npc_list = require '任务.npc'
local hero = require 'types.hero'

for index,info in ipairs(npc_list) do 
    local data = hero.hero_list[info.name]
    if data then 
        local npc = ac.player(9):create_unit(data.data.id,ac.point(info.x,info.y),info.facing)
        npc:add_restriction '物免'
        npc:add_restriction '魔免'
        npc:add_restriction '免死'
        npc.is_npc = true
        PauseUnit(npc.handle,true)
    end
end 

return mt