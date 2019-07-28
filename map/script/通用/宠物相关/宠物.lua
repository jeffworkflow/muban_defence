local player = require 'ac.player'

function player.__index:create_pets()
    local x,y = ac.map.rects['出生点']:get_point():get()
    local u = self:create_unit('宠物',ac.point(x-500,y))
    u.unit_type = '宠物'
    u:set('移动速度',522)
    
    self.peon = u
    -- u:set_animation_speed(1000)
    --添加切换背包
    u:add_skill('切换背包','英雄',5)
    u:add_restriction '无敌'
    u:add_restriction '缴械'
    u:add_skill('拾取','拾取',1)

    u:add_skill('全图闪烁','英雄')
    u:add_skill('传递物品','英雄')
    u:add_skill('一键拾取','英雄')
    u:add_skill('装备合成','英雄')
    -- u:add_skill('荣耀称号','英雄',8)
    u:add_skill('宠物皮肤','英雄',12)
    u:add_skill('宠物天赋','英雄',8)
    u:add_skill('一键出售','英雄',7)
    u:add_skill('一键合成','英雄',9)
    
    -- u:add_skill('商城管理','英雄')
    -- u:add_skill('自动合成','英雄',9)
    
    -- 测试魔法书
    -- u:add_skill('魔法书demo','英雄')
    
    --
    if (self.cus_server and self.cus_server['勇士徽章']) or 0  > 0 then
        self.flag_init_yshz = true 
        local item = u:add_item('勇士徽章')
        self.flag_init_yshz = false
        item:set_item_count(self.cus_server['勇士徽章'])
    end    
end
