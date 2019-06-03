require '物品.商店.练功房'
require '物品.商店.杀鸡敬猴'
require '物品.商店.基地'
require '物品.商店.传送'
require '物品.商店.随机技能'
require '物品.商店.随机物品'
require '物品.商店.扭蛋'


--一开始就创建商店 需要有玩家在视野内 漂浮文字的高度才能显示出来
ac.wait(100,function() 
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
                --注册区域事件
                local rct =  ac.rect.j_rect(str)
                local region = ac.region.create(rct)
                region:event '区域-离开' (function(trg, hero)
                    if hero:get_name() ~= '魔鬼的交易' then
                        return
                    end
                    hero:blink(rct)
                    hero:set_facing(face)
                end)    
            end    
        end    
    end 
end)



-- ac.game:event '玩家-注册英雄后' (function()
--     if ac.flag_shop  then return end
--     ac.flag_shop = true

--     ac.wait(2*1000,function()
--         print('注册英雄后1')
--         local fresh_time = 2*60 --刷新时间
--         -- if global_test then 
--         --     fresh_time = 10 --测试刷新时间
--         -- end
--         local off_set = 0
--         --创建物品商店
--         local x,y = ac.map.rects['物品商店']:get_point():get()
--         local shop = ac.shop.create('物品商店',x,y-off_set,270)
--         shop:set_size(1.2)
--         ac.map.fresh_shop_item(shop)
--         ac.loop(fresh_time*1000,function()
--             ac.map.fresh_shop_item(shop)
--             ac.player.self:sendMsg('|cff00bdec物品商店|r有新货色来了！赶紧来买！先到先得！',10)
--             ac.player.self:sendMsg('|cff00bdec物品商店|r有新货色来了！赶紧来买！先到先得！',10)
--             ac.player.self:sendMsg('|cff00bdec物品商店|r有新货色来了！赶紧来买！先到先得！',10)
--         end)

--         print('注册英雄后2')
--         --创建技能商店
--         local x,y = ac.map.rects['技能商店']:get_point():get()
--         local shop1 = ac.shop.create('技能商店',x,y-off_set,270)
--         shop1:set_size(0.7*1.2)
--         ac.map.fresh_shop_skill(shop1)
--         ac.loop(fresh_time*1000 + 100,function()
--             ac.map.fresh_shop_skill(shop1)
--             ac.player.self:sendMsg('|cff00ff00技能商店|r有新货色来了！赶紧来买！先到先得！',10)
--             ac.player.self:sendMsg('|cff00ff00技能商店|r有新货色来了！赶紧来买！先到先得！',10)
--             ac.player.self:sendMsg('|cff00ff00技能商店|r有新货色来了！赶紧来买！先到先得！',10)
--         end)

--         print('注册英雄后3')
--         --创建积分商店
--         local x,y = ac.map.rects['积分商店']:get_point():get()
--         local shop2 = ac.shop.create('积分商店',x,y-off_set,270)
--         shop2:set_size(2*1.2)
--         print('注册英雄后4')
--         --创建xx商店
--         local x,y = ac.map.rects['图书馆']:get_point():get()
--         local shop3 = ac.shop.create('图书馆',x,y-off_set,270)
--         shop3:set_size(1.2)

--         print('注册英雄后5')
--         --创建天结散人
--         local x,y = ac.map.rects['天结散人']:get_point():get()
--         local shop4 = ac.shop.create('天结散人',x,y-off_set,270)
--         shop4:set_size(1.2)

--         print('注册英雄后6')
--         ac.game:event '游戏-回合开始'(function(trg,index, creep) 
--             if creep.name ~= '刷怪' then 
--                 return 
--             end    
--             --藏宝图 第10波 出现
--             local index = 10 
--             if creep.name == '刷怪' and  creep.index == index then
--                 shop4:add_sell_item('藏宝图',1)
--                 --发送消息
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000藏宝图|r玩法，前往|cffff0000天结散人|r处购买',10)
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000藏宝图|r玩法，前往|cffff0000天结散人|r处购买',10)
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000藏宝图|r玩法，前往|cffff0000天结散人|r处购买',10)
--             end   

--             --迷路的宝藏 第20波 出现
--             local index = 20 
--             if creep.name == '刷怪' and  creep.index == index then
--                 shop4:add_sell_item('迷路的坦克',2)
--                 --发送消息
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000迷路的坦克|r玩法，前往|cffff0000天结散人|r处购买',10)
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000迷路的坦克|r玩法，前往|cffff0000天结散人|r处购买',10)
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000迷路的坦克|r玩法，前往|cffff0000天结散人|r处购买',10)
--             end   

--             --小黑屋 第30波 出现
--             local index = 30 
--             if creep.name == '刷怪' and  creep.index == index then
--                 shop4:add_sell_item('进入小黑屋',3)
--                 --发送消息
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000小黑屋|r玩法，前往|cffff0000天结散人|r处进入',10)
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000小黑屋|r玩法，前往|cffff0000天结散人|r处进入',10)
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000小黑屋|r玩法，前往|cffff0000天结散人|r处进入',10)
--                 --开启按钮
--                 c_ui.kzt.F2_home:show()
--                 c_ui.kzt.F3_xiaoheiwu:show()

--                 --调整镜头锁定区域
--                 for i = 1, 10 do
--                     local p = ac.player[i]
--                     --在选人区域创建可见度修整器(对每个玩家,永久)
--                     if p:is_player() then 
--                         local minx, miny, maxx, maxy = ac.map.rects['镜头锁定']:get()
--                         p:setCameraBounds(minx, miny, maxx, maxy)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。

--                         p.hero:add_skill('F2回城', '隐藏')
--                         p.hero:add_skill('F3小黑屋', '隐藏') 
                    
--                         --给每位玩家创建小黑屋 修炼商店
--                         local x,y = ac.rect.j_rect('lgfsd'..p.id):get_point():get()
--                         local shop5 = ac.shop.create('修炼商店',x,y,270)
--                         shop5:set_size(1.2) 
--                         local shop6 = ac.shop.create('杀敌兑换',x+300,y,270)
--                         shop6:set_size(1.2) 
--                     end  
--                 end

--             end   
--             --挑战自我 第40波 出现
--             local index = 40 
--             if creep.name == '刷怪' and  creep.index == index then
--                 --发送消息
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000挑战自我|r玩法，前往|cffff0000小黑屋|r处购买',10)
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000挑战自我|r玩法，前往|cffff0000小黑屋|r处购买',10)
--                 ac.player.self:sendMsg('【系统消息】新增|cffff0000挑战自我|r玩法，前往|cffff0000小黑屋|r处购买',10)

--                 for i = 1, 10 do
--                     local p = ac.player[i]
--                     --在选人区域创建可见度修整器(对每个玩家,永久)
--                     if p:is_player() then 
--                         local x,y = ac.rect.j_rect('lgfsd'..p.id):get_point():get()
--                         local shop7 = ac.shop.create('镜像挑战',x+600,y,270)
--                         -- shop7:set_owner(p)
--                         shop7:set_size(1.2) 
--                     end  
--                 end
--             end   

--         end)
--     end)    

-- end)