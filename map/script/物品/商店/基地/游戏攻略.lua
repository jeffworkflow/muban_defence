
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['游戏攻略']
mt{
--等久
level = 1,
--图标
art = [[xsgl.blp]],
--说明
tip = [[
1.杀鸡儆猴
2.魔鬼的交易
3.神兵神甲
4.套装
5.异火
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
content_tip = '',
--物品技能
is_skill = true,
--商店名词缀
store_affix = ''
}

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    
end
