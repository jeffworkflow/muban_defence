

-- {'nainiu11', 

for i=1,3 do 
    local mt = ac.creep['奶牛'..i]{    
        creeps_datas = '奶牛*15',
        region = 'nainiu1'..i,
        cool_count = 3,
    }
    function mt:on_change_creep(unit,lni_data)
        --设置搜敌范围
        unit:set_search_range(1000)
        unit:event '单位-死亡'(function(_,unit,killer)
            local player = killer.owner
            local hero = player.hero
            --概率 超级彩蛋
            local rate = 0.015
            -- local rate = 10 --测试
            local rand = math.random(100000)/1000
            if rand <= rate then 
                --掉落
                local skl = hero:find_skill('无敌破坏神',nil,true)
                if not skl then 
                    ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','无敌破坏神')
                    ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 杀牛一时爽，一直杀牛一直爽，|r 获得成就|cffff0000 "无敌破坏神" |r，奖励 |cffff00005000万全属性，物理伤害加深+200%，技能伤害加深+100%|r',6)
                end    
            end 
        end)
    end  
end    




