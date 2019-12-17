ac.game:event '选择难度' (function(_,g_game_degree_name,g_game_degree)
    if not finds(g_game_degree_name,'无限BOSS') then 
        return
    end    
    --发送文字提醒
    ac.player.self:sendMsg('【无限BOSS】选择了 难'..g_game_degree..' ，当前难度通关后，即可选择下一个难度！')
    ac.player.self:sendMsg('【无限BOSS】通关后可激活“绝世魔剑”存档，属性在巅峰神域-绝世魔剑中查看！')
    ac.player.self:sendMsg('【无限BOSS】【无限BOSS】按F6查看无限BOSS难度排行榜！')
    
    --改变怪物出怪间隔
    for i=1,3 do 
        local mt = ac.creep['刷怪'..i]
        mt.force_cool = 90
    end

    --改变boss极限属性
    ac.game:event '单位-创建' (function(_,unit)
        local str = table.concat(ac.attack_boss)
        if finds(str,unit:get_name()) then
            --增加属性
            unit:add('攻击距离',20*g_game_degree)
            --增加单位（普通boss）
            if not ac.flag_wxboss and unit:get_name()~='毁灭者' then 
                ac.flag_wxboss = true
                for i=1,g_game_degree do 
                    local boss = ac.player.com[2]:create_unit(unit:get_name(),ac.map.rects['进攻点']:get_point())
                    boss:add_buff '攻击英雄' {}
                    boss:add_skill('无敌','英雄')
                    boss:add_skill('撕裂大地','英雄')
                    boss:add('免伤',1.5 * ac.get_difficult(ac.g_game_degree_attr))
                    boss:add('物理伤害加深',1.45 * ac.get_difficult(ac.g_game_degree_attr))
                end  
                ac.flag_wxboss = false  
            end    
        end    



    end)

end)





















