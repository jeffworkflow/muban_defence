local player = require 'ac.player'

function player.__index:create_pets()
    local u = self:create_unit('n003',ac.point(-500,0))
    --添加切换背包
    -- u:add_skill('切换背包','切换背包-宠物',1)
    u:add_restriction '无敌'
    u:add_restriction '缴械'
    u:add_skill('拾取','拾取',1)
    u:add_skill('全图闪烁','英雄')
end
