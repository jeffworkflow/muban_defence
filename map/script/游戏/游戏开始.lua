-- 加载脚本 → 选择难度 → 注册英雄 → 游戏-开始 → 开始刷兵
-- ac.npc_shop = {
--     ['npc1'] = ac.map.rects['npc1'],
--     ['npc2'] = ac.map.rects['npc2'],
--     ['npc3'] = ac.map.rects['npc3'],
--     ['npc4'] = ac.map.rects['npc4'],
--     ['npc5'] = ac.map.rects['npc5'],
--     ['npc6'] = ac.map.rects['npc6'],
--     ['npc7'] = ac.map.rects['npc7'],
--     ['npc8'] = ac.map.rects['npc8'],
--     ['npc9'] = ac.map.rects['npc9'],

--     --练功房 
-- 	['练功房11'] =ac.map.rects('练功房11') ,
-- 	['练功房12'] =ac.map.rects('练功房12') ,
-- 	['练功房13'] =ac.map.rects('练功房13') ,
-- 	['练功房14'] =ac.map.rects('练功房14') ,

-- 	['练功房21'] =ac.map.rects('练功房21') ,
-- 	['练功房22'] =ac.map.rects('练功房22') ,
-- 	['练功房23'] =ac.map.rects('练功房23') ,
-- 	['练功房24'] =ac.map.rects('练功房24') ,

-- 	['练功房31'] =ac.map.rects('练功房31') ,
-- 	['练功房32'] =ac.map.rects('练功房32') ,
-- 	['练功房33'] =ac.map.rects('练功房33') ,
-- 	['练功房34'] =ac.map.rects('练功房34') ,

-- 	['练功房41'] =ac.map.rects('练功房41') ,
-- 	['练功房42'] =ac.map.rects('练功房42') ,
-- 	['练功房43'] =ac.map.rects('练功房43') ,
-- 	['练功房44'] =ac.map.rects('练功房44') ,

-- 	['练功房51'] =ac.map.rects('练功房51') ,
-- 	['练功房52'] =ac.map.rects('练功房52') ,
-- 	['练功房53'] =ac.map.rects('练功房53') ,
-- 	['练功房54'] =ac.map.rects('练功房54') ,

-- 	['练功房61'] =ac.map.rects('练功房61') ,
-- 	['练功房62'] =ac.map.rects('练功房62') ,
-- 	['练功房63'] =ac.map.rects('练功房63') ,
-- 	['练功房64'] =ac.map.rects('练功房64') ,

-- }



ac.game:event '游戏-开始' (function()

    print('游戏开始1')
    --游戏开始，不允许控制中立被动（钥匙怪）
    for x = 0, 10 do
        --不允许控制中立被动的单位
        ac.player.force[1][x]:disableControl(ac.player[16])
        ac.player.force[2][0]:disableControl(ac.player[16])
    end
    print('游戏开始2')

    
    --开启按钮 F2 F3
    -- c_ui.kzt.F2_home:show()
    -- c_ui.kzt.F3_xiaoheiwu:show()

    --每个玩家初始化金币
    for i=1 ,12 do 
        local p = ac.player(i)
        if p.hero then 

        end    
    end    

    --难五 添加伏地魔 和斗神
    if ac.g_game_degree_attr >= 5 then 
        for key,unit in pairs(ac.shop.unit_list) do 
            if unit:get_name() == '新手任务' then 
                unit:add_sell_item('伏地魔',3)
            end	
            if unit:get_name() == '境界突破'  then 
                unit:add_sell_item('境界-斗神',11)
            end	
            if unit:get_name() == '护天神甲'  then 
                unit:add_sell_item('神甲-皇龙阴阳甲',11)
            end	
            if unit:get_name() == '神兵利器'  then 
                unit:add_sell_item('神兵-九幽白蛇剑',11)
            end	
        end	
        --创建 超级异火
        local x,y = ac.rect.j_rect('npc10'):get_point():get()
        local shop = ac.shop.create('超级异火',x,y,270,nil)  
        --创建 超越极限
        local x,y = ac.rect.j_rect('cyjx'):get_point():get()
        local shop = ac.shop.create('超越极限',x,y,270,nil)  
        
        --百鸟朝凤相关
        local time = 8 * 60
        -- local time = 30
        for i=1,8 do 
            ac.wait(i*time*1000,function()
                local u = ac.player(16):create_unit('鸟',ac.rect.j_rect('bncf'..i))
                local angle = ac.rect.j_rect('bncf'..i):get_point() / ac.rect.j_rect('bncf9'):get_point()
                u:add_restriction '无敌'
                u:add_restriction '定身'
                u:set_facing(angle)
            end)
        end    

    end    

end)    


