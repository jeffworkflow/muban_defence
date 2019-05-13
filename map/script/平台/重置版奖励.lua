
--购买地图重置版的玩家奖励
if not global_test then 
    ac.wait(13,function()
        for i=1,10 do
            local p = ac.player[i]
            if p:is_player() and p:Map_IsMapReset() then
                p:event '玩家-注册英雄后' (function(_, _, hero)
                    hero:add('每秒全属性',5)
                    hero:add('经验加成',25)
                    p:sendMsg('【系统消息】 因购买了重置版魔兽，奖励 每秒全属性+5 经验获取率+25%',10)
                end)
            end
        end
    end);
end

