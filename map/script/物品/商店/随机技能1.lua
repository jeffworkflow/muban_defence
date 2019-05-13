--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['随机技能1']
mt{
--等久
level = 1,

--图标
art = [[other\suijijineng.blp]],

--说明
tip = [[随机技能]],

--物品类型
item_type = '神符',

--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,

--购买价格
kill_count = 120,
auto_fresh_tip = true,
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local hero = self.owner
    local player = hero.owner
    local shop_item = ac.item.shop_item_map[self.name]
    --给英雄随机添加物品
    local rand_list = ac.unit_reward['商店随机技能']
    local rand_name = ac.get_reward_name(rand_list)
    if not rand_name then 
        return
    end    
    -- skill_list2 英雄技能库
    local list = ac.skill_list2
    --添加给英雄
    local name = list[math.random(#list)]
    ac.item.add_skill_item(name,hero)

    --系统提示
    ac.player.self:sendMsg('|cff00ffff【系统提示】|r|cffff0000'..player:get_name()..'|r|cff00ffff在技能商店用|r|cffff8000杀敌数|r|cff00ffff兑换了一本|r|cff00ff00'..name..'|r',10)



end

function mt:on_remove()
end