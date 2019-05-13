local mt = ac.skill['金币礼包']
mt{
--等久
level = 1,

--图标
art = [[xin101.blp]],

--说明
tip = [[    
1000元
]],

--物品类型
item_type = '消耗品',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 1,

--购买价格
gold = 0,

}


function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    -- items._count = items._count - 1
    
    --添加给英雄
    hero:addGold(1000)


end