
--购买地图重置版的玩家奖励
if not global_test then 
    ac.wait(13,function()
        for i=1,10 do
            local p = ac.player[i]
            if p:is_player() and p:Map_IsMapReset() then
                p:event '玩家-注册英雄后' (function(_, _, hero)
                    hero:add('杀怪加全属性',38.8)
                    hero:add('攻击减甲',38.8)
                    hero:add('木头加成',38.8)
                    hero:add('全伤加深',38.8)
                    p:sendMsg('|cffffe799【系统消息】|r购买了魔兽重置版，获得额外奖励 |cff00ff00杀怪加全属性+38.8 攻击减甲+38.8 木头加成+38.8% 全伤加深+38.8%|r',10)
                end)
            end
        end
    end);
end