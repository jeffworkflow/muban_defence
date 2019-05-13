-- 加载脚本 → 选择难度 → 注册英雄 → 游戏-开始 → 开始刷兵
g_game_min = 1

ac.game:event '游戏-开始' (function()

    -- ac.loop(60*1000,function()
    --     g_game_min = g_game_min +1
    -- end)
    print('游戏开始1')
    --游戏开始，不允许控制中立被动（钥匙怪）
    for x = 0, 10 do
        --不允许控制中立被动的单位
        ac.player.force[1][x]:disableControl(ac.player[16])
        ac.player.force[2][0]:disableControl(ac.player[16])
    end
    print('游戏开始2')
    --每个玩家初始化金币
    for i=1 ,12 do 
        local p = ac.player(i)
        if p.hero then 
            -- local item = p.hero:add_item('新手礼包') 
            -- local item = p.hero:add_item('迷你熊爪') 
            -- print(item.slot_id,item.type_id,item.name)

        end    
    end    
    
    print('游戏开始12')


end)    