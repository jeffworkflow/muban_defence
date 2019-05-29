local mt = ac.skill['抽奖券']

mt{
    --等久
    level = 1,
    
    --图标
    art = [[choujiang.blp]],
    
    --说明
    tip = [[点击即可抽奖]],
    
    --物品类型
    item_type = '消耗品',
    
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    
    --冷却
    cool = 0,
    
    content_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
	
}

--右击使用
function mt:on_cast_start()
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    self:add_content()
end

function mt:add_content()
    
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['抽奖券']
    local rand_name = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)
    if not rand_name then 
        return true
    end  
    local index 
    local data
    local gold 
    local exp
    -- print(rand_name)
    if rand_name == '无' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000什么事都没发生|r',10)
    elseif rand_name == '欧皇达人' then
        if  not ac.flag_ouhuang  then 
            ac.flag_ouhuang = player
            player.flag_ouhuang = true
            player.is_show_nickname = '(欧皇达人)'
            local hero = player.hero
            hero:add('每秒加全属性',5)
            hero:add('攻击减甲',5)
            --给全部玩家发送消息
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r |cff00ffff时来运转|r,获得唯一称号|cffff0000"欧皇达人" |r，奖励 |cffff0000抽奖券效果翻倍，每秒加全属性+5，攻击减甲+5|r',10)
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r |cff00ffff时来运转|r,获得唯一称号|cffff0000"欧皇达人" |r，奖励 |cffff0000抽奖券效果翻倍，每秒加全属性+5，攻击减甲+5|r',10)
        else
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000什么事都没发生|r',10)
        end
    elseif rand_name == '金币' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
            gold = math.random(1000,20000)
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励金币：'..gold..'|r',10)
            hero:addGold(gold)
        end    
    elseif  rand_name == '经验' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
            exp = math.random(1000,20000)
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励经验：'..exp..'|r',10)
            hero:addXp(exp)
        end    
    elseif  rand_name == '随机物品' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
            --给英雄随机添加物品
            local name = ac.all_item[math.random( 1,#ac.all_item)]
            --满时，掉在地上
            hero:add_item(name,true)
            local lni_color ='白'
            if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
                lni_color = ac.table.ItemData[name].color
            end    
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, 奖励：|cff'..ac.color_code[lni_color]..name..'|r',10)
        end    
    elseif  rand_name == '随机技能' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
        --给英雄随机添加物品
            local rand_list = ac.unit_reward['商店随机技能']
            local rand_name = ac.get_reward_name(rand_list)
            if not rand_name then 
                return
            end    
            local list = ac.skill_list2
            --添加给英雄
            local name = list[math.random(#list)]
            ac.item.add_skill_item(name,hero)
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励 技能书：'..name..'|r',10)
        end    
    elseif  rand_name == '召唤练功怪' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
            hero:add_item('召唤练功怪',true)
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励：召唤练功怪|r',10)
        end   
    elseif  rand_name == '召唤boss' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
            hero:add_item('召唤boss',true)
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励：召唤boss|r',10)
        end   
    elseif  rand_name == '吞噬丹' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
            hero:add_item('吞噬丹',true)
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励：吞噬丹|r',10)
        end   
    elseif  rand_name == '宠物经验书' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
            hero:add_item('宠物经验书',true)
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励：宠物经验书 |r',10)
        end   
    elseif  rand_name == '随机恶魔果实' then
        local mul = player.flag_ouhuang == true and 2 or 1  --有欧皇达人就2否则1
        for i=1,mul do  
            --死亡掉落 随机掉落恶魔果实
            local name = ac.guoshi_list[math.random(1,#ac.guoshi_list)] .. '的恶魔果实'
            -- print(name)
            hero:add_item(name,true)
            ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励：'..name..'  |r',10)
        end   
    elseif rand_name == '十连抽' then
        ac.player.self:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000 十连抽 |r',10)
        if not player.flag_shilianchou then 
            player.flag_shilianchou = true
            --添加东西给英雄
            for i=1,10 do 
                self:add_content()
            end   
            player.flag_shilianchou = false 
        end    
    end

end

function mt:on_remove()
   
end


ac.game:event '单位-死亡' (function (_,unit,killer)
    if unit:get_owner() ~= ac.player(12) then 
        return
    end    
    --玩家12（敌对死亡才掉落）
    local rate = 0 
    local rand = math.random(100)
    if rand <= rate then 
        --掉落
        ac.item.create_item('抽奖券',unit:get_point())
    end    
end)


