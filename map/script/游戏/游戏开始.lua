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
    --每个玩家初始化金币
    for i=1 ,12 do 
        local p = ac.player(i)
        if p.hero then 

        end    
    end    
    local temp_tab = {}
    --创建 npc(商店)
    for key,val in pairs(ac.table.UnitData) do 
        if val.category =='商店' then
            ac.table.UnitData[key].name = key
            table.insert(temp_tab,ac.table.UnitData[key])
        end    
    end
    --排序
    table.sort(temp_tab,function(a,b)
         return a.id < b.id
    end)

    for i,data in ipairs(temp_tab) do
        local where = data.where
        local name = data.name
        local face = data.face or 270
        for i,str in ipairs(where) do 
            local x,y = ac.rect.j_rect(str):get_point():get()
            local shop = ac.shop.create(name,x,y,face)
            if name == '基地' then
                shop:remove_restriction '无敌'
                shop:set('生命上限',100000)
                shop:set('护甲',100)
            end    
            
            if name == '魔鬼的交易' then
                local id = tonumber(string.sub(str,4,4))
                local player = ac.player(id)
                -- print(player)
                shop:set_owner(player)
                ac.game:event_notify('单位-创建商店', shop)
            end    
        end    
    end 


end)    