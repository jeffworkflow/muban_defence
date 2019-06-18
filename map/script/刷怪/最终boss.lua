
--进入最终boss阶段，boss苏醒，打败boss进入无尽
ac.game:event '游戏-最终boss' (function(trg) 
    if ac.final_boss then 
        ac.player.self:sendMsg('|cff00bdec【系统消息】|r 最终boss已出现|r，请大家共同前往击杀',3)
        return 
    end    
    local point = ac.map.rects['刷怪-boss']:get_point()
    local boss = ac.player.com[2]:create_unit(ac.attack_boss[#ac.attack_boss],point)
    if ac.creep['刷怪1'] then 
        table.insert(ac.creep['刷怪1'].group,boss)
    end    
    ac.final_boss = boss
    --注册事件
    boss:event '单位-死亡'(function(_,unit,killer) 
        ac.game:event_notify('游戏-结束',true)
    end) ; 
    
end);    


