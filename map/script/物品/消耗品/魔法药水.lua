--物品名称
local mt = ac.skill['魔法药水']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNPotionGreen.blp]],

--说明
tip = [[使用恢复200生命值]],

--物品类型
item_type = '消耗品',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 10,

--购买价格
gold = 1000,

--物品数量
_count = 1,
--该物品是一个技能
is_skill = true,
--物品详细介绍的title
content_tip = '使用说明：'

}


function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    -- items._count = items._count - 1



end