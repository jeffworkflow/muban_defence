
--购买地图重置版的玩家奖励
if not global_test then 
    ac.wait(13,function()
        for i=1,10 do
            local p = ac.player[i]
            if p:is_player() and p:Map_IsMapReset() then
                p:event '玩家-注册英雄后' (function(_, _, hero)
                    hero:add('杀怪加全属性',16.8)
                    hero:add('攻击减甲',16.8)
                    hero:add('触发概率加成',16.8)
                    hero:add('全伤加深',16.8)
                    p:sendMsg('【系统消息】 因购买了重置版魔兽，奖励 杀怪加全属性+16.8 攻击减甲+16.8 触发概率加成+16.8% 全伤加深+16.8%',10)
                end)
            end
        end
    end);
end