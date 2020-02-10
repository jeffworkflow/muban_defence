
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['加速出怪']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNShadowPact.blp]],

--说明
tip = [[


|cff00ff00加快无尽怪物进攻5秒|r,现每波进攻间隔： %time_tip% 

]],
shop_count = 0, --初始个数

--物品类型
item_type = '神符',
--售价 500000
wood = 2000,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 600,
--加快进攻（秒）
stu_time = 5,
time_tip = function()
    return ac.creep['刷怪-无尽1'].force_cool or 60
end,

content_tip = '|cffFFE799【使用说明】：|r',
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local unit = self.seller
    local p = self.owner:get_owner()
    local hero = p.hero
    if ac.creep['刷怪-无尽1'].index == 0 then 
        p:sendMsg('没到无尽，不可加速')
        hero:add_wood(self.wood)
        return 
    end 
    local tip = ''
    for i=1,3 do 
        local creep = ac.creep['刷怪-无尽'..i]
        creep.force_cool = math.max(creep.force_cool - self.stu_time,10)
        tip = creep.force_cool
    end
    ac.player.self:sendMsg('玩家 '..p:get_name()..' 购买了|cffff0000加速进攻！|r现在进攻间隔：'..tip..'秒',5)
    
end


