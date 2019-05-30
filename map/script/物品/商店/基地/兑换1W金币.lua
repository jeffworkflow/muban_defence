local rect = require 'types.rect'
--物品名称
local mt = ac.skill['兑换1W金币']
mt{
--等久
level = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],
--说明
tip = [[1木头换1W金币
]],
--物品类型
item_type = '神符',
--售价 500000
wood = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
award_gold = 10000,
content_tip = '',
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local unit = self.seller
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    hero:addGold(self.award_gold)
end
