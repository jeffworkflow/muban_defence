
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['基地重生次数+1']
mt{
--等久
level = 1,

--图标
art = [[ReplaceableTextures\CommandButtons\BTNImbuedMasonry.blp]],

--说明
tip = [[基地重生次数+1
]],

--物品类型
item_type = '神符',
--售价 500000
mutou = 50000,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--全属性
award_all_attr = 1000,
content_tip = '',
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local unit = self.seller
    local skl = unit:find_skill('重生')
    if not skl then 
        unit:add_skill('重生','隐藏')
    else
        skl.cnt = skl.cnt + 1
    end   


    local hero = self.owner
    local player = hero:get_owner()
    hero = player.hero
    hero:add('全属性',self.award_all_attr)
    player:sendMsg('【系统消息】升级了基地，奖励全属性'..self.award_all_attr)
    
end
