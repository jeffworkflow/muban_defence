local mt = ac.skill['高级扭蛋']

mt{
    --等久
    level = 1,
    --图标
    art = [[gjnd.blp]],
    --说明
    tip = [[|cffffe799【说明】：|r
    
|cff00ff00小扭伤腰，大扭伤肾，且扭且珍惜|r
]],
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    --售价
    wood = 980,
    --兑换材料
    raffle = '高级扭蛋券*1',
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
    self:add_content()
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
    local tran_player = rand_rate < self.rate and ac.player.self or player
    --发送消息
    if flag then 
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    end    
    
    --再处理特殊的 
    if rand_name == '空蛋' then
        player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
    elseif rand_name == '玻璃大炮' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000攻击+2亿，护甲-5k|r',6)
        else
            player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end
    elseif rand_name == '发光的蓝色灰烬' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000物理伤害加深+50%，暴击几率+5%，暴击加深+50%，+500W全属性|r',6)
        else
            player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end  
    elseif rand_name == '诸界的毁灭者' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000攻击+7500W，攻击间隔-0.1|r',6)
        else
            player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end  
    elseif rand_name == '末日的钟摆' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000技暴几率+5%，技暴加深+50%，+500W全属性|r',6)
        else
            player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end
    elseif rand_name == '游戏王' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffffe799【系统消息】|r|cffff0000时来运转!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得成就 |cffff0000"'..rand_name..'" |r，奖励 |cffff0000全伤+5%，免伤+5%，+2500W全属性|r',6)
        else
            player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        self.owner:add_item(name,true)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end 
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cff'..ac.color_code[lni_color]..name..'|r',2)
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
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000技能书：'..name..'|r',2)
    elseif  finds(rand_name,'技能升级书') then
        self.owner:add_item(rand_name,true)
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    elseif finds(rand_name,'洗练石') then
        self.owner:add_item(rand_name,true)
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    elseif rand_name == '吞噬丹' then
        self.owner:add_item(rand_name,true)
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    elseif  rand_name == '宠物经验书(大)' then
        self.owner:add_item(rand_name,true)
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..rand_name..'|r',2)
    elseif finds(rand_name,'神兵','神甲') then
        local rand_list = ac.magic_item[rand_name]
        --添加给英雄
        local name = rand_list[math.random(6,10)]
        local skl = hero:find_skill(name,nil,true)
        --已激活，再扭一次
        if skl and skl.level >= 1 then 
            
            self:add_content()
        else 
            self.owner:add_item(name,true)
            tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 获得了 |cffff0000'..name..'|r',2) 
        end 
    elseif  rand_name == '火灵' then
        self.owner:add_fire_seed(12500)
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r 获得了 |cffff0000'..rand_name..'+12500|r',2) 
    elseif  rand_name == '木头' then
        self.owner:add_wood(1680)
        tran_player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r 获得了 |cffff0000'..rand_name..'+1680|r',2) 
    elseif rand_name == '龙族血统' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'扭蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000+10每秒加护甲，+500W全属性|r',6)
        else
            player:sendMsg1('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 打开|cff00ff00'..self.name..'|r, 发现了 |cffff0000蛋是空的|r',2)
        end
    end  

end

function mt:on_remove()
   
end



