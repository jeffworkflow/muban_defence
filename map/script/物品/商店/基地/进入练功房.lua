
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['进入练功房']
mt{
--等久
level = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNFootman.blp]],
--说明
tip = [[点击传送至专属练功房]],
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
    local rect = ac.map.rects['练功房刷怪'..p.id]
    hero = p.hero
    -- print(rect)
    hero:blink(rect,true,false,true)
end
