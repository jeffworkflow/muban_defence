local mt = ac.skill['藏宝图']
mt{
    --等久
    level = 1,
    --图标
    art = [[cangbaotu.blp]],
    --说明
    tip = [[


根据提示，到指定地点，挖开即可获得 |cffdf19d0 各种宝藏 |r
]],
    --物品类型
    item_type = '消耗品',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --物品技能
    is_skill = true,
    --挖图范围
    area = 500,
    --售价
    kill_count = 200,
    --cd
    cool = 0.5,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r',
    --自动挖宝
    wabao_auto_use = false,
    --全部玩家发送信息概率
    rate = 0.3,
    --多少秒后地上物品消失
    time_removed = 100,
    --可能会掉线
    effect = function(self)
        local str = ''
        if self.owner:get_owner():is_self() then 
            str='wbdd.mdx'
        end
        return str    
    end   
}
    
function mt:on_add()
    --全图随机刷 正式用
    self.random_point =  ac.map.rects['藏宝区']:get_random_point(true)
    -- print(ac.map.rects['藏宝区']:get_random_point(true))

    --测试用
    -- self.random_point = self.owner:get_point()
end

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local item = self 
    local list = {}
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 

    if hero.wabao_auto then 
        self.wabao_auto_use = true
    else
        self.wabao_auto_use = false
    end    
    if player.peon_wabao then 
        if player.hero.wabao_auto then 
            self.wabao_auto_use = true
        else
            self.wabao_auto_use = false
        end 
    end    

    if self.eff then 
        self.eff:remove()
    end    
    self.eff = ac.effect(self.random_point,self.effect,0,1,'origin')

    local tx,ty = self.random_point:get()
    local rect = ac.rect.create( tx - self.area/2, ty-self.area/2, tx + self.area/2, ty + self.area/2)
    local region = ac.region.create(rect)
    local point = hero:get_point()

    --自动寻宝
    if self.wabao_auto_use then 
        --区域修改
        rect = ac.rect.create( tx - 64, ty-64, tx + 64, ty + 64)
        region = ac.region.create(rect)
        if not self.trg then 
            self.trg = region:event '区域-进入' (function(trg, unit)
                if  unit == hero then
                    if not player.peon_wabao and  (hero.unit_type == '宠物' or hero.unit_type == '召唤物') then 
                        player:sendMsg('|cff00ffff宠物不能挖图|r',3)
                        player:sendMsg('|cff00ffff宠物不能挖图|r',3)
                        return true
                    end 
                    -- print('单位进入')
                    self:on_add() 
                    for i =1,player.cnt_award_wabao or 1 do 
                       self:add_content()  
                    end
                    self:add_item_count(-1) 
                    if self.trg then 
                        self.trg:remove()
                        self.trg = nil
                    end    
                    
                    if self:get_item_count()>= 1 then 
                        --模拟消耗品使用
                        self:on_cast_start()
                        self:add_item_count(-1) 
                    end  
                end
            end)
        end    
        ac.wait(500,function()
            hero:issue_order('move',self.random_point)
        end)
        player:pingMinimap(self.random_point, 3)
    else      
        --点在区域内
        if region < point  then
            if not player.peon_wabao and  ( hero.unit_type == '宠物' or hero.unit_type == '召唤物') then 
                player:sendMsg('|cff00ffff宠物不能挖图|r',3)
                player:sendMsg('|cff00ffff宠物不能挖图|r',3)
                return true
            end    

            self:add_item_count(-1) 
            self:on_add() 
            --添加东西给英雄
            --测试用
            for i =1,player.cnt_award_wabao or 1 do 
                self:add_content()  
             end 
        else
            player:pingMinimap(self.random_point, 3)
        end 
    end       
end    

function mt:add_content()
    if self.eff then 
        self.eff:remove()
    end 

    local hero = self.owner
    local player = self.owner:get_owner()
    hero = player.hero 
    --初始化
    player.achievement = player.achievement or {}
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['藏宝图']
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
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'|r',2)
    end    
    --加挖宝积分
    -- player:AddServerValue('wbjf',1) 自定义服务器
    player:Map_AddServerValue('wbjf',1) --网易服务器
    if not player.cus_server3 then 
        player.cus_server3 = {}
    end    
    player.cus_server3['挖宝'] = (player.cus_server3['挖宝'] or 0) + 1

    ac.game:event_notify('挖图成功',hero) --发布事件回调

    --什么事情都没有发生，挖宝经验（可存档）+1，当前挖宝经验XX
    --再处理特殊的 
    if rand_name == '无' then
        player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffff0000(挖宝积分+1，当前挖宝积分 '..player.cus_server['挖宝积分']..' )|r',2)
    elseif rand_name == '挖宝达人' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000500万全属性，物品获取率+50%|r',6)
        else
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffff0000(挖宝积分+1，当前挖宝积分 '..player.cus_server['挖宝积分']..' )|r',2)
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
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cff'..ac.color_code[lni_color]..name..'|r',2)
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
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000技能书：'..name..'|r',2)
    elseif  rand_name == '宠物经验书(小)' then
        self.owner:add_item(rand_name,true)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'|r',2) 
    elseif  rand_name == '宠物经验书(大)' then
        self.owner:add_item(rand_name,true)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'|r',2) 

    elseif  rand_name == '火灵' then
        self.owner:add_fire_seed(10000)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'+10000|r',2) 
    elseif  rand_name == '木头' then
        self.owner:add_wood(3500)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'+3500|r',2) 
    elseif  finds(rand_name,'格里芬','黑暗项链','最强生物心脏','白胡子的大刀') then
        --满时，掉在地上
        self.owner:add_item(rand_name,true)
        tran_player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'|r',2) 
    elseif rand_name == '碎片幼儿园' then
        if not ac.flag_spyey  then 
            ac.flag_spyey = true 
            ac.func_give_suipian(self.owner:get_point())
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 在挖宝时挖塌了|cffff0000'..rand_name..'，一大堆碎片散落|cffff0000老家周围|r，大家快去抢啊|r',2) 
        else 
            self:add_content() --已挖到再随机一次
        end    
    elseif rand_name == 'ONE_PIECE' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000500万全属性，对BOSS额外伤害+5%|r',6)
        else
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffff0000(挖宝积分+1，当前挖宝积分 '..player.cus_server['挖宝积分']..' )|r',2)
        end  
    elseif rand_name == '法老的遗产' then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name  
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000500万全属性 +2.5%会心几率 +25%会心伤害|r',6)
        else
            player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffff0000(挖宝积分+1，当前挖宝积分 '..player.cus_server['挖宝积分']..' )|r',2)
        end
    elseif rand_name == '家里有矿' then
        if finds(hero:get_name(),'剑仙','至尊宝','鬼厉') then 
            local skl = hero:find_skill(rand_name,nil,true)
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋',rand_name)
                player.is_show_nickname = rand_name  
                --给全部玩家发送消息
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cff00ff00所有队友的全属性+5%',6)
            else
                player:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffff0000(挖宝积分+1，当前挖宝积分 '..player.cus_server['挖宝积分']..' )|r',2)
            end
        else 
            self:add_content() --已挖到再随机一次
        end    
    end   
end

function mt:on_remove()
    local hero = self.owner
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    
    
end

--散落碎片
ac.func_give_suipian = function(start,tab)
    local cnt = math.random(5,10)
    local tab = tab or ac.shenlong_suipin
    for i=1,cnt do 
        local item_name = tab[math.random(1,#tab)]
        local point = ac.map.rects['藏宝区']:get_random_point(true)
        --运动
        local mvr = ac.mover.target
        {
            source = start,
            target = point,
            model = [[RedCrystalShard.mdx]],
            height = 800,
            speed = 1000,
            skill = '碎片运动'
        }
        if not mvr then
            return
        end
        function mvr:on_finish()
            ac.item.create_item(item_name,point)
        end    
    end    
end


--解决藏宝图在npc脚下，英雄挖不到宝，幽灵会导致 物品地上卡人的位置。
ac.game:event '玩家-注册英雄' (function(_, _, hero)
    -- hero:add_restriction('幽灵') 
end)    
--挖宝排行榜相关
--每1分钟保存一次

--保存今日榜
local function save_wb()
    for i=1,10 do
        local p = ac.player[i]
        if p:is_player() then 
            if not p.cus_server3 then 
                p.cus_server3 = {}
            end   
            if p.cus_server3['挖宝'] then 
                p.cus_server3['总挖宝'] = (p.cus_server3['总挖宝'] or 0) + p.cus_server3['挖宝']
                --自定义服务器 保存总积分 
                p:AddServerValue('cntwb',p.cus_server3['挖宝'])  
                --自定义服务器 保存今日最高积分
                p:sp_set_rank('today_cntwb',p.cus_server3['总挖宝'])
                
                --保存完需要清空，下次保存时才能正确增加上去
                p.cus_server3['挖宝'] = 0 
            end    
        end
    end   
end  
ac.game:event '游戏-开始' (function() 
    local time =60 * 2
    ac.loop(time*1000,function()
        save_wb()
    end)
end)