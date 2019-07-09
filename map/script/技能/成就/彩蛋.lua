local mt = ac.skill['倒霉蛋']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[shuaishen.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+16888 木头
+16888 火灵
+16888 杀敌数|r

]],
    add_wood = 16888,
    add_fire = 16888,
    add_kill = 16888,
}
function mt:on_add()
    local hero  = self.owner
    local player = hero:get_owner()
    hero = player.hero
    
    hero:add_wood(self.add_wood)
    hero:add_fire_seed(self.add_fire)
    hero:add_kill_count(self.add_kill)
end    

local mt = ac.skill['游戏王']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[yxw.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+2500W 全属性
+5%     全伤加深
+5%     免伤|r

]],
    ['全伤加深'] = 5,
    ['免伤'] = 5,
    ['全属性'] = 25000000,
}

local mt = ac.skill['挖宝达人']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[wbdr.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+50%  物品获取率|r

]],
    ['物品获取率'] = 50,
    ['全属性'] = 5000000,
}

local mt = ac.skill['杀鸡狂魔']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[sjjh.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+60w 全属性
+25% 杀敌数加成|r

]],
    ['杀敌数加成'] = 25,
    ['全属性'] = 600000,
}

local mt = ac.skill['五道杠少年']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[wdgsn.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+25% 木头加成|r

]],
    ['木头加成'] = 25,
    ['全属性'] = 5000000,
}

local mt = ac.skill['输出机器']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[scjq.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+150W 全属性
+50%  攻击速度|r

]],
    ['攻击速度'] = 50,
    ['全属性'] = 1500000,
}


local mt = ac.skill['技多不压身']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[scjq.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+50W 全属性
+25%  攻击速度|r

]],
    ['攻击速度'] = 25,
    ['全属性'] = 500000,
}


--注册怪物死亡事件 杀鸡狂魔
ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_name() ~= '鸡' then 
        return 
    end    
    local player = killer:get_owner()
    local hero = player.hero
    if  not hero then return end
    --概率获得成就
    local rate = 0.1
    -- local rate = 80 --测试用
    if math.random(1,10000)/100 < rate then 
        local skl = hero:find_skill('杀鸡狂魔',nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','杀鸡狂魔')
            player.is_show_nickname = '杀鸡狂魔'
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 杀鸡一时爽，一直杀鸡一直爽|r 获得成就|cffff0000 "杀鸡狂魔" |r，奖励 |cffff0000+60w全属性 +25%杀敌数加成|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 杀鸡一时爽，一直杀鸡一直爽|r 获得成就|cffff0000 "杀鸡狂魔" |r，奖励 |cffff0000+60w全属性 +25%杀敌数加成|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 杀鸡一时爽，一直杀鸡一直爽|r 获得成就|cffff0000 "杀鸡狂魔" |r，奖励 |cffff0000+60w全属性 +25%杀敌数加成|r',6)
            -- ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000吸血+10%，攻击回血+50W|r',6)
      
        end
    end    
end)


--注册攻击事件
ac.game:event '单位-攻击开始' (function(self, data)
    if data.target:get_name() ~= '游戏说明' then 
        return 
    end	  
    local player = data.source:get_owner()
    if player.id >10 then return end 
    local hero = player.hero
    --概率获得成就
    local rate = 0.2
    -- local rate = 80 --测试用
    if math.random(1,10000)/100 < rate then 
        local skl = hero:find_skill('输出机器',nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','输出机器')
            player.is_show_nickname = '输出机器'
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 打桩一时爽 一直打桩一直爽|r 获得成就|cffff0000 "输出机器" |r，奖励 |cffff0000+150W全属性 +50%攻击速度|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 打桩一时爽 一直打桩一直爽|r 获得成就|cffff0000 "输出机器" |r，奖励 |cffff0000+150W全属性 +50%攻击速度|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 打桩一时爽 一直打桩一直爽|r 获得成就|cffff0000 "输出机器" |r，奖励 |cffff0000+150W全属性 +50%攻击速度|r',6)
            -- ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000吸血+10%，攻击回血+50W|r',6)
    
        end
    end    
end)