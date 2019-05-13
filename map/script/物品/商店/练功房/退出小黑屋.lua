
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['退出小黑屋']
mt{
--等久
level = 1,

--图标
art = [[xiaoheiwu.blp]],

--说明
tip = [[退出小黑屋|r]],

--物品类型
item_type = '神符',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

content_tip = '',
--物品技能
is_skill = true,
--增加值
value = 0.02,
--商店名词缀
store_affix = ''

}

function mt:on_cast_start()
    local hero = self.owner
    hero:blink(ac.point(0,0),true,false,true)
    
end
