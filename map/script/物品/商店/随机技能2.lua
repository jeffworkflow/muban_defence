--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['随机技能2']
mt{
--等久
level = 1,

--图标
art = [[other\suijijineng.blp]],

--说明
tip = [[消耗 |cff00ff00 %jifen% 通关积分|r 兑换 一本随机技能书]],

content_tip = '物品说明:',

--物品类型
item_type = '神符',


--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--冷却
cool = 0,
--最大购买次数
max_buy_cnt = 20,

--购买价格
jifen = 1500,

auto_fresh_tip = true,
--物品技能
is_skill = true,

}

function mt:on_cast_start()
    local hero = self.owner
    local player = hero.owner
    local shop_item = ac.item.shop_item_map[self.name]

    if not player.buy_skill_cnt then 
        player.buy_skill_cnt = 1
    end 
    if not shop_item.player_buy_cnt then 
        shop_item.player_buy_cnt = {}
    end

    player.buy_skill_cnt = player.buy_skill_cnt + 1  
    shop_item.player_buy_cnt[hero:get_owner()] = player.buy_skill_cnt

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
    ac.player.self:sendMsg('|cff00ffff【系统提示】|r|cffff0000'..player:get_name()..'|r|cff00ffff在技能商店用|r|cffff8000积分|r|cff00ffff兑换了一本 |r|cff00ff00'..name..'|r',10)

    
end

function mt:on_remove()
end