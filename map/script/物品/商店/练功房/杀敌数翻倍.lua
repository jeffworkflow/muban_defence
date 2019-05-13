
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['杀敌数翻倍']
mt{
--等久
level = 1,

--图标
art = [[shadidubo.blp]],

--说明
tip = [[杀敌数 50%翻倍， 50%0]],

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
    local kill_count = p.kill_count 
    local rand = math.random(100)
    if kill_count <=0 then 
        p:sendMsg('|cffFFCC00不够赌|r')
        return 
    end    
    if rand <= self.rate then 
        p.kill_count = p.kill_count * 2
        p:sendMsg('|cff00ff00翻倍|r')
    else
        p.kill_count = 0
        p:sendMsg('|cffff0000凉凉|r')
    end    
end
