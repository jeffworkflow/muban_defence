

--每15分钟传送进武林大会
local start_time = 60 * 15
local duration_time = 60 * 2 --持续时间
local give_award 

--武林大会倒计时（文字提醒）
local function ss_wldh(text)
    ac.timer_ex 
    {
        time = start_time,
        title = '距离 武林大会 开始： ' ,
        func = function ()
            ac.game.start_wldh()
        end,
    }
    --快到时，进行提醒
    local t_time = 15
    ac.wait( (start_time - t_time)*1000,function() 
        ac.timer(1000,t_time,function(t)
            t_time = t_time -1 
            ac.player.self:sendMsg('|cffffe799【系统消息】|r武林大会|cffff0000 '..t_time..' |r秒后开始，请做好准备')
            if t_time <=0 then 
                t:remove()
            end    
        end)
    end )

    ac.wait( (start_time - 5)*1000,function() 
        for i=1,10 do 
            local p = ac.player(i)
            local hero = p.hero
            local peon = p.peon
            if p:is_player() and hero then 
                --每个玩家添加传送动画（倒计时）
                hero:add_buff '时停'
                {
                    time = 5,
                    text = '秒后进入武林大会',
                    skill = '武林大会',
                    source = hero,
                    xoffset = -205,
                    zoffset = 220,
                    show = true,
                    is_god = true,
                }
                ac.wait(5*1000,function()
                    -- print('时停结束，开始进行死亡之环')
                    -- print(hero:get_name())
                    hero:blink(ac.map.rects['武林大会']:get_random_point(true),true,false)
                    peon:blink(ac.map.rects['武林大会']:get_random_point(true),true,false)
                    --锁定镜头
                    local minx, miny, maxx, maxy = ac.map.rects['武林大会']:get()
                    p:setCameraBounds(minx, miny, maxx, maxy)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
                    p:setCamera(hero:get_point())
                    
                    --每个玩家添加传送动画（倒计时）
                    hero:add_buff '时停'
                    {
                        time = 5,
                        skill = '武林大会',
                        source = hero,
                        zoffset = 220,
                        show = true,
                    }
                end)
            end
        end        
    end )
    
end    

ac.game.start_wldh = function() 
    --发布 武林大会-开始 
    ac.game:event_notify('武林大会-开始')
    --武林大会倒计时
    ac.timer_ex 
    {
        time = duration_time,
        title = '距离 武林大会 结束： ' ,
        func = function ()
            ac.game:event_notify('武林大会-结束')
            --武林大会倒计时
            ss_wldh()
        end,
    }
    --快到时，进行提醒
    local t_time = 15
    ac.wait( (duration_time - t_time)*1000,function() 
        ac.timer(1000,t_time,function(t)
            t_time = t_time -1 
            ac.player.self:sendMsg('|cffffe799【系统消息】|r武林大会|cffff0000 '..t_time..' |r秒后结束')
            if t_time <=0 then 
                t:remove()
            end    
        end)
    end )
end

ac.game:event '游戏-开始'(function()
    if ac.g_game_degree_name =='武林大会' then
        ss_wldh()
    end    
end)

ac.game:event '武林大会-开始' (function()
    --给标志
    ac.flag_wldh = true
    --暂停 正常出怪，暂停出怪，
    for i=1,3 do 
        local creep = ac.creep['刷怪'..i]
        creep:PauseTimer(duration_time)
    end  
    --启用如果有暂停出怪处理
    if ac.main_stop_timer then 
        ac.main_stop_timer:PauseTimer()
    end    
    --基地加无敌
    ac.main_unit:add_buff '无敌'{
        time = duration_time + 30
    }
    --玩家敌对
    ac.init_enemy()

    for i=1,10 do 
        local p = ac.player(i)
        local hero = p.hero
        local peon = p.peon
        if p:is_player() and hero then 
            --禁止F2,F3
            local skl = hero:find_skill('F2回城',nil,true)
            if skl then skl:disable() end 
            local skl = hero:find_skill('F3小黑屋',nil,true)
            if skl then skl:disable() end 

        end    
        
    end    
end)


ac.game:event '武林大会-结束' (function()
    ac.flag_wldh = false
    --启用如果有暂停出怪处理，则恢复
    if ac.main_stop_timer then 
        ac.main_stop_timer:ResumeTimer()
    end    
    --玩家联盟
    ac.init_alliance()
    
    for i=1,10 do 
        local p = ac.player(i)
        local hero = p.hero
        local peon = p.peon

        if p:is_player() and hero then 
            --恢复镜头
            local minx, miny, maxx, maxy = ac.map_area:get()
            p:setCameraBounds(minx, miny, maxx, maxy)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
            hero:blink(ac.map.rects['主城'],true,false) 
            peon:blink(ac.map.rects['主城'],true,false)
            ac.wait(10,function()
                p:setCamera(hero:get_point())
            end)
            
            --恢复F2,F3
            local skl = hero:find_skill('F2回城',nil,true)
            if skl then skl:enable() end 
            local skl = hero:find_skill('F3小黑屋',nil,true)
            if skl then skl:enable() end 

            --恢复护甲
            if hero.had_reduce_defence then 
                hero:add('护甲',hero.had_reduce_defence)
            end    

        end    
    end    

    --给奖励
    give_award()


end)

-----------------------------------------比武统计------------------------------------------------------- 
ac.game:event '玩家-注册英雄' (function(_, p, hero)

    hero:event '单位-死亡' (function(_,unit,killer)
        if not killer:is_hero() then 
            return 
        end
        local p = killer:get_owner()
        p.wldh_jf = (p.wldh_jf or 0 ) + 1
        --保存比武积分
        p:Map_AddServerValue('wljf',1) --网易服务器
        --保存到自定义服务器 暂时先保存值，后面结束时再保存到服务器
        if not p.cus_server3 then 
            p.cus_server3 = {} 
        end 
        p.cus_server3['比武'] = (p.cus_server3['比武'] or 0) + 1
        --文字提醒
        p:sendMsg('|cffffe799比武积分+1|r',5)
    end) 

end)    
-----------------------------------------发放奖励-------------------------------------------------------
local award_item = {
    [1] = {'红',10},
    [2] = {'金',8},
    [3] = {'蓝',6},
    [4] = {'白',4},
    [5] = {'白',2},
    [6] = {'白',0},
}
function give_award()
    local temp_tab = {}
    for i=1,10 do 
        local p= ac.player(i)
        if p:is_player() then 
            table.insert(temp_tab,{player = p,wldh_jf = (p.wldh_jf or 0)})
        end
        --清空积分
        p.wldh_jf = 0 
    end  
    --排序
    table.sort(temp_tab,function(a,b)
        return a.wldh_jf>b.wldh_jf
    end)
    local tip = '|cffffe799【系统消息】|r|cffff0000武林大会结束，发放奖励如下|r\n\n'
    --循环给奖励
    for i,data in ipairs(temp_tab) do 
        local ad_it,jifen = table.unpack(award_item[i])
        local hero = data.player.hero 
        local list = ac.quality_item[ad_it]
        local name = list[math.random(#list)]
        local it = hero:add_item(name,true)
        -- print(i,data.player,data.wldh_jf)
        tip = tip..'第'..i..'名 |cff00ffff'..data.player:get_name()..'|r共获得|cffff0000'..(data.wldh_jf+jifen)..'|r积分，奖励'..it.color_name..'|r'..'\n\n'
        --保存积分
        data.player:Map_AddServerValue('wljf',jifen) --网易服务器
        
        --保存到自定义服务器 暂时先保存值，后面结束时再保存到服务器
        local p = data.player
        if not p.cus_server3 then 
            p.cus_server3 = {} 
        end 
        p.cus_server3['比武'] = (p.cus_server3['比武'] or 0) + jifen

        --总比武
        p.cus_server3['总比武'] = (p.cus_server3['总比武'] or 0) + p.cus_server3['比武']
        --自定义服务器 保存总积分 
        p:AddServerValue('cntwl',p.cus_server3['比武'])  
        --自定义服务器 保存今日最高积分
        p:sp_set_rank('today_cntwl',p.cus_server3['总比武'])
        --保存完需要清空，下次保存时才能正确增加上去
        p.cus_server3['比武'] = 0 
    end    
    ac.player.self:sendMsg(tip)
    
end    







-----------------------------------------投票相关-------------------------------------------------------
--在线玩家 1  >= 0 开启 存档
-- 2  >= 1 开启 存档
-- 3  >= 1.5 开启 存档
local online_cnt = get_player_count()
local half_online_cnt = online_cnt/2
local use_mall = 0
local click_cnt = 0
local has_check
local function check_vote()
    if has_check then 
        return 
    end 
    has_check = true
    if use_mall >= half_online_cnt then 
        ac.flag_use_mall = true 
    else
        ac.flag_use_mall = false 
    end 

    if ac.flag_use_mall then 
        ac.player.self:sendMsg('|cffffe799【系统消息】|r投票结束，本局|cff00ff00开启|r商城道具和存档内容')   
    else 
        ac.player.self:sendMsg('|cffffe799【系统消息】|r投票结束，本局|cffff0000禁用|r商城道具和存档内容')  
    end    

    ac.game:event_notify('投票结束',ac.flag_use_mall)
    --重载 地图等级
    ac.init_need_map_level()
    
    -- 关闭商城道具
    if not ac.flag_use_mall then 
        for i=1,10 do
            local p = ac.player[i]  
            if p:is_player() then 
                if not p.cheating then 
                    for key,val in sortpairs(p.mall) do 
                        p.mall[key] = 0
                    end    
                end    
            end    
        end 
    end    
end    

ac.game.start_vote = function()
    local list = {
        { name = "是" },
        { name = "否" },
    }
    for i =1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            create_dialog(p,"是否开启商城道具及存档内容？",list,function (index)  
                -- local name = list[index].name
                if index == 1 then 
                    use_mall = use_mall + 1
                    if use_mall >= half_online_cnt then 
                        ac.flag_use_mall = true 
                    end  
                    ac.player.self:sendMsg('|cff00ffff等待其他玩家投票中...|r')      
                else
                    ac.player.self:sendMsg('|cff00ffff等待其他玩家投票中...|r')      
                end  
                --'玩家 '..p:get_name()..' 选择了 |cff00ff00是|r'
                click_cnt = click_cnt + 1 
                if click_cnt >= get_player_count() then 
                    check_vote()
                end    
            end,10)    
        end
    end         
    --时间到，检查选择的结果
    ac.wait(10*1000+10,function(t) 
        check_vote()
    end)
end    



