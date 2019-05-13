local player = require 'ac.player'

function player.__index:create_pets()
    print('注册英雄13')
    local u = self:create_unit('n003',ac.point(-500,0))
    u.unit_type = '宠物'
    u:set('移动速度',522)
    print('注册英雄14')
    self.peon = u
    -- u:set_animation_speed(10)
    --添加切换背包
    print('注册英雄15')
    u:add_skill('切换背包','英雄',5)
    print('注册英雄16')
    u:add_restriction '无敌'
    u:add_restriction '缴械'
    u:add_skill('拾取','拾取',1)
    print('注册英雄17')

    u:add_skill('全图闪烁','英雄')
    u:add_skill('传递物品','英雄')
    u:add_skill('一键拾取','英雄')
    u:add_skill('装备合成','英雄')
    u:add_skill('荣耀称号','英雄',8)
    u:add_skill('翅膀管理','英雄',9)
    u:add_skill('宠物天赋','英雄',6)
    u:add_skill('一键出售','英雄',7)
    u:add_skill('商城管理','英雄')
    
    -- 测试魔法书
    -- u:add_skill('魔法书demo','英雄')
    print('注册英雄18')
    
    
end
