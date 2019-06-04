local rect = require 'types.rect'
--物品名称
local mt = ac.skill['兑换1木头']
mt{
--等久
level = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNChestOfGold.blp]],
--说明
tip = [[
|cffFFE799【使用说明】：|r

消耗 |cffff00001w金币|r 兑换 |cff00ff001木头|r
]],
--物品类型
item_type = '神符',
--售价 500000
gold = 10000,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
award_wood = 1,
content_tip = '',
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local unit = self.seller
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    hero:add_wood(self.award_wood)
end
