
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['金币翻倍']
mt{
--等久
level = 1,

--图标
art = [[jibidubo.blp]],

--说明
tip = [[金币 50%翻倍， 50%0]],

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
store_affix = '',
--实际概率
rate = 60 

}

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local gold = p.gold
    local rand = math.random(100)
    if gold <=0 then 
        p:sendMsg('|cffFFCC00不够赌|r')
        return 
    end  
    if rand <= self.rate then 
        hero:addGold(gold)
        p:sendMsg('|cff00ff00翻倍|r')
    else
        hero:addGold(-gold)
        p:sendMsg('|cffff0000凉凉|r')
    end    
end
