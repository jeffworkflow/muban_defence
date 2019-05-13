--每回合开始，60秒后，中央boss释放死亡之环
--同时存活人数为0 ，游戏失败 （标准模式）
--
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪' then
        return
    end  
    print('回合开始3')
    -- 回合开始，倒计时释放死亡之环
    local time = 60

    if not creep.boss then 
        local unit = ac.player.com[2]:create_unit('最终boss',ac.map['刷怪中心点'],270)
        unit:set_size(2)
        unit:add_restriction '定身'
        unit:add_restriction '缴械'
        unit:add_restriction '无敌'
        -- unit:setColor(100,100,100)
        -- unit:setColor(68,68,68)
        -- unit:set_animation 'Stand Ready'
        unit:add_skill('死亡之环','隐藏')
        if not unit.data  then 
            unit.data = {}
        end    
        unit.data.type ='boss'

        creep.boss = unit
        ac.final_boss = unit
    end 
    local c_boss_buff = creep.boss:find_buff '时停' 

    if c_boss_buff then 
        c_boss_buff:remove()
    end   

    --释放完后，等待2秒继续僵硬
    local buff = creep.boss:add_buff '时停'
    {
        time = time,
        skill = '游戏模块',
        source = unit,
        zoffset = 220,
        show = true
    }
    function buff:on_finish()
        -- print('时停结束，开始进行死亡之环')
        creep.boss:force_cast('死亡之环')
    end

    if creep.boss.waiter1 then 
        creep.boss.waiter1:remove()
    end
     
    if creep.boss.waiter2 then 
        creep.boss.waiter2:remove()
    end   
    creep.boss.waiter1 = ac.loop((time+2)*1000,function()
        local c_boss_buff = creep.boss:find_buff '时停' 
        if c_boss_buff then 
            c_boss_buff:remove()
        end   
        --释放完后，等待2秒继续僵硬
        local buff = creep.boss:add_buff '时停'
        {
            time = time,
            skill = '游戏模块',
            source = unit,
            show = true
        }
        function buff:on_finish()
            creep.boss:force_cast('死亡之环')
        end
    end)
    
end)
--进入最终boss阶段，boss苏醒，打败boss进入无尽
ac.game:event '游戏-最终boss' (function(trg,index, creep) 
    if creep.name ~= '刷怪' then
        return
    end  
    if creep.boss.waiter1 then 
        creep.boss.waiter1:remove()
    end
     
    if creep.boss.waiter2 then 
        creep.boss.waiter2:remove()
    end   
    
    -- print('删掉光环怪')
    if ac.enemy_unit then ac.enemy_unit:remove() end
    
    --boss 苏醒动画
    local c_boss_buff = creep.boss:find_buff '时停' 
    if c_boss_buff then 
        c_boss_buff:remove()
    end   
    
    creep.boss:add_buff '缩放' {
        origin_size = 1,
        target_size = 2.5,
        time = 3.5
    }
    --添加4个boss技能
    creep.boss:add_skill('毁灭','英雄') 
    -- creep.boss:add_skill('地狱火雨','英雄') 
    for i=1,3 do 
        local skl_name = ac.skill_list3[math.random(#ac.skill_list3)]
        if not creep.boss:find_skill(skl_name) then 
            creep.boss:add_skill(skl_name,'英雄') 
        end
    end        
	--镜头动画
	local p = ac.player.self
	p:setCamera(creep.boss:get_point() + {0, 300}, 0.5)
    p:hideInterface(0.5)

    ac.wait(3.6*1000,function ()
        p:showInterface(0.1)
        p:setCamera(p.hero:get_point() + {0, 300}, 0.3)
    end)

    ac.wait(4*1000,function ()
        creep.boss:remove_restriction '无敌' 
        creep.boss:remove_restriction '定身'
        creep.boss:remove_restriction '缴械'
    end)


    --设置搜敌路径
    creep.boss:set_search_range(99999)
    --注册事件
    creep.boss:event '单位-死亡'(function(_,unit,killer) 
        --保存英雄熟练度
        local value 
        if ac.g_game_degree ==1 then 
            value = 2
        elseif ac.g_game_degree ==2 then    
            value = 4  
        elseif ac.g_game_degree ==3 then    
            value = 6  
        else
            value = 8
        end     
        ac.final_boss = false   
        killer:add_hero_xp(value)

        --保存积分
        if ac.save_jifen then 
            ac.save_jifen()
        end    
        --通关难4，送大天使皮肤
        if ac.g_game_degree ==4 then 
            local t = {}
            for i = 1 ,10 do 
                local player = ac.player(i)
                if player:is_player() and player.kda then 
                    table.insert(t,{id = player:get(),kda = player.kda})
                end    
            end 
            table.sort(t,function(a,b) return a.kda>b.kda end)           
            local p = ac.player(t[1].id) 
            -- for i =1,10 do 
            --     if t[i] then 
            --        print(ac.player(t[i].id) ,t[i].kda) 
            --     end
            -- end    

            ac.save(p,'大天使加百列',1)
            --发送消息
            local tip = '|cffffff00【系统消息】通关圣人难度|r,恭喜玩家 |cffff0000'..p:get_name()..'|r获得皮肤：|cffff0000大天使加百列（鲁大师皮肤）|r'..'，可能是因为kda最高才能获得。\n'
            ac.player.self:sendMsg(tip,30)
        end    
        --难1， 游戏胜利  
        --难2、3 ， 20秒后进入无尽 
        if ac.g_game_degree ==1 then 
            ac.game:event_notify('游戏-结束',true)
        else   
            --文字提示
            ac.player.self:sendMsg('【系统消息】恭喜你打败最终boss,30秒后进入无尽',30)
            ac.player.self:sendMsg('【系统消息】恭喜你打败最终boss,30秒后进入无尽',30)
            ac.player.self:sendMsg('【系统消息】恭喜你打败最终boss,30秒后进入无尽',30)
            local timer_ex1 = ac.timer_ex 
            {
                time = 30,
                title = "进入无尽倒计时",
                func = function ()
                    ac.creep['刷怪-无尽']:start()
                    ac.game:event_dispatch('游戏-无尽开始',creep) 
                end,
            }
        end    
    end) ; 
    

end);    


