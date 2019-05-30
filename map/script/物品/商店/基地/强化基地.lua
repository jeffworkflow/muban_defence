
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['强化基地']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNStoneArchitecture.blp]],

--说明
tip = [[提升基地%defence% %护甲 和 %life% %生命上限
]],

--物品类型
item_type = '神符',
--售价
wood = 5000,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--全属性
award_all_attr = 100,
--护甲%
defence = 100,
--生命上限%
life = 100,
content_tip = '',
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local unit = self.seller
    unit:add('生命上限%',self.life)
    unit:add('护甲%',self.defence)
    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    hero:add('全属性',self.award_all_attr)
    player:sendMsg('【系统消息】升级了基地，奖励全属性'..self.award_all_attr)
    
end
