
--进入最终boss阶段，boss苏醒，打败boss进入无尽
ac.game:event '游戏-最终boss' (function(trg) 
    if ac.final_boss then 
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 最终boss已出现|r，请大家共同前往击杀',3)
        return 
    end    
    local max_cnt = finds(ac.g_game_degree_name,'无限BOSS') and ac.g_game_degree or 1

    for i=1,max_cnt do 
        --增加单位（普通boss）
        local point = ac.map.rects['进攻点']:get_point()
        local boss = ac.player.com[2]:create_unit(ac.attack_boss[#ac.attack_boss],point)
        
        boss:add_buff '攻击英雄' {}
        boss:add_skill('无敌','英雄')
        boss:add_skill('撕裂大地','英雄')
        boss:add_skill('伤害守卫','英雄')
        boss:add_skill('boss光子灵枪','英雄')
        boss:add('免伤',1.5 * ac.get_difficult(ac.g_game_degree_attr))
        boss:add('物理伤害加深',1.45 * ac.get_difficult(ac.g_game_degree_attr))
        
        ac.final_boss = (ac.final_boss or 0) + 1
        --注册事件
        boss:event '单位-死亡'(function(_,unit,killer) 
            ac.final_boss = ac.final_boss -1
            if ac.final_boss <=0 then
                if finds(ac.g_game_degree_name_ex,'无尽','乱斗')  then 
                    --散落碎片
                    ac.func_give_suipian(unit:get_point()) 
                    --无尽开始
                    ac.game:event_notify('游戏-无尽开始')
                else    
                    --游戏结束
                    ac.game:event_notify('游戏-结束',true)
                    --创建神龙
                    local x,y = boss:get_point():get()
                    local shop4 = ac.shop.create('神龙',x,y,270)
                end    
            end    
        end) ; 
    end    
    
end);    


