--物品名称
local mt = ac.skill['霸者之证进阶']
mt{
--等久
level = 1,

--图标
art = [[icon\feisheng.blp]],

--说明
tip = [[|cffffff00当英雄满级后，如果想在修为上更进一步，只有拥有霸者之证的人，才能步入化境！]],

--物品类型
item_type = '神符',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

--物品技能
is_skill = true,

content_tip = '',

--商店名词缀
store_affix = ''
}

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local shop_item = ac.item.shop_item_map[self.name]
    local item = hero:has_item('霸者之证')
    if hero.level == 100 and item and item.level == 1 then 
        --物品进化
        item:upgrade(1)
        ac.player.self:sendMsg('恭喜|cffff0000'..player:get_name()..'|r |cff00ffff进阶成功，霸者之证获得进阶能力|r')   
    else
        player:sendMsg('|cff00ffff条件不足，进阶失败|r')    
    end    

end

function mt:on_remove()
end