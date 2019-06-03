local mt = ac.skill['高级扭蛋(百连抽)']

mt{
    --等久
    level = 1,
    --图标
    art = [[gjnd.blp]],
    --说明
    tip = [[点击即可抽奖]],
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    --售价
    wood = 1680,
    --物品技能
    is_skill = true,
    --全部玩家发送信息概率
    rate = 1,
    --商店名词缀
    store_affix = '',
}

--右击使用
function mt:on_cast_start()
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    for i=1,100 do 
        self:add_content()
    end    
end

function mt:add_content()
    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    --初始化
    player.achievement = player.achievement or {}
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['高级扭蛋']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end  
    local flag
    local temp_rand_name = rand_name
    --先处理属性相关
    for k,v in string.gsub(temp_rand_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
        --增加人物属性
        -- print(k,v)
        flag = true
        hero:add(k,v)
    end  
    local tran_player = rand_rate < self.rate and ac.player.self or nil
    --发送消息
    if flag and tran_player then 
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r, |cffff0000'..rand_name..'|r',10)
    end    
    
    --再处理特殊的 
    if rand_name == '空蛋' then
        player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r, |cffff0000什么事都没发生|r',10)
    elseif rand_name == '玻璃大炮' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r |cff00ffff时来运转|r,获得成就|cffff0000"'..rand_name..'" |r，奖励 |cffff0000+1亿攻击，-1W护甲|r',10)
        else
            player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r, |cffff0000已拥有 '..rand_name..' 什么事都没发生|r',10)
        end
    elseif rand_name == '黄金罗盘' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r |cff00ffff时来运转|r,获得成就|cffff0000"'..rand_name..'" |r，奖励 |cffff0000自动寻宝|r',10)
        else
            player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r, |cffff0000已拥有 '..rand_name..' 什么事都没发生|r',10)
        end  
    elseif rand_name == '诸界的毁灭者' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r |cff00ffff时来运转|r,获得成就|cffff0000"'..rand_name..'" |r，奖励 |cffff0000+7500W攻击，-0.1攻击间隔|r',10)
        else
            player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r, |cffff0000已拥有 '..rand_name..' 什么事都没发生|r',10)
        end  
    elseif rand_name == '末日的钟摆' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r |cff00ffff时来运转|r,获得成就|cffff0000"'..rand_name..'" |r，奖励 |cffff0000技暴几率+5%，技暴伤害+50%，+500W全属性|r',10)
        else
            player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r, |cffff0000已拥有 '..rand_name..' 什么事都没发生|r',10)
        end
    elseif rand_name == '游戏王' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg("【系统提示】玩家 |cffff0000"..player:get_name()..'|r |cff00ffff时来运转|r,获得成就|cffff0000"'..rand_name..'" |r，奖励 |cffff0000全伤+5%，免伤+5%，+2500W全属性|r',10)
        else
            player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r, |cffff0000已拥有 '..rand_name..' 什么事都没发生|r',10)
        end
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local rand_list = ac.unit_reward['商店随机物品']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        local list = ac.quality_item[rand_name] 
        local name = list[math.random(#list)]
        --满时，掉在地上
        self.owner:add_item(name,true)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end 
        if tran_player then    
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r,奖励：|cff'..ac.color_code[lni_color]..name..'|r',10)
        end
    elseif  rand_name == '随机技能' then
        local rand_list = ac.unit_reward['商店随机技能']
        local rand_name = ac.get_reward_name(rand_list)
        if not rand_name then 
            return
        end    
        local list = ac.skill_list2
        --添加给购买者
        local name = list[math.random(#list)]
        ac.item.add_skill_item(name,self.owner)
        if tran_player then 
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff抽奖|r, |cffff0000奖励 技能书：'..name..'|r',10)
        end
    elseif  finds(rand_name,'技能升级书') then
        self.owner:add_item(rand_name,true)
        if tran_player then 
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r,获得 |cffff0000'..rand_name..'|r',10)
        end
    elseif finds(rand_name,'洗练石') then
        self.owner:add_item(rand_name,true)
        if tran_player then 
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r,获得 |cffff0000'..rand_name..'|r',10)
        end
    elseif rand_name == '吞噬丹' then
        self.owner:add_item(rand_name,true)
        if tran_player then 
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r,获得 |cffff0000'..rand_name..'|r',10)
        end
    elseif  rand_name == '宠物经验书(大)' then
        self.owner:add_item(rand_name,true)
        if tran_player then 
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r,获得 |cffff0000'..rand_name..'|r',10) 
        end
    elseif  rand_name == '神兵' then
        local rand_list = ac.magic_item[rand_name]
        --添加给英雄
        local name = rand_list[math.random(6,10)]
        self.owner:add_item(rand_name,true)
        if tran_player then 
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r,获得 |cffff0000'..rand_name..'|r',10) 
        end
    elseif  rand_name == '神甲' then
        local rand_list = ac.magic_item[rand_name]
        --添加给英雄
        local name = rand_list[math.random(6,10)]
        self.owner:add_item(rand_name,true)
        if tran_player then 
        tran_player:sendMsg('玩家 |cff00ffff'..player:get_name()..'|r |cff00ffff'..self.name..'|r,获得 |cffff0000'..rand_name..'|r',10) 
        end
    end

end

function mt:on_remove()
   
end



