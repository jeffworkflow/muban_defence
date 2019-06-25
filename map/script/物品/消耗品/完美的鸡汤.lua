--物品名称
local mt = ac.skill['完美的鸡汤']
mt{
--等久
level = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNBronzeBowlFull.blp]],
--说明
tip = [[ 

|cff00ff00食用可恢复全部生命值|r
]],
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r'
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