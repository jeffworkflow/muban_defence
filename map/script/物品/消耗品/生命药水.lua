--物品名称
local mt = ac.skill['生命药水']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNPotionGreen.blp]],

--说明
tip = [[使用恢复全部生命值

|cffdf19d0 PS：可以给宠物，让宠物帮忙吃药|r
]],

--物品类型
item_type = '消耗品',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 1,

--购买价格
gold = 0,

--物品数量
_count = 10,
--物品详细介绍的title
content_tip = '使用说明：'
}


function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    -- items._count = items._count - 1
    hero:heal
    {
        source = hero,
        skill = self,
        size = 10,
        -- string = '恢复全部生命',
        heal = hero:get('生命上限'),
    }


end