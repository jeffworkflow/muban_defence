
--一开始就创建商店 需要有玩家在视野内 漂浮文字的高度才能显示出来
local function init_shop()
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
        --优化创建商店
        ac.wait(i*300,function()
            local where = data.where
            local name = data.name
            local face = data.face or 270
            if where then  
                for ix,str in ipairs(where) do 
                    ac.wait(i*300 + ix*200,function()
                        local id
                        local player
                        if name == '魔鬼的交易' then
                           id = tonumber(string.sub(str,4,4))
                           player = id and ac.player(id)
                        end

                        local x,y = ac.rect.j_rect(str):get_point():get()
                        local shop = ac.shop.create(name,x,y,face,nil,player)
                        -- print(shop:get_name(),name,x,y)
                        if name == '基地' then
                            shop:remove_restriction '无敌'
                            shop:set('生命上限',500000)
                            shop:set('护甲',100)
                        end    
                        if name == '游戏说明' then
                            shop:remove_restriction '无敌'
                            shop:set('生命上限',500000000000)
                            shop:set('生命恢复',500000000000)
                            shop:set('护甲',500000000000)
                        end   
                        
                        if name == '魔鬼的交易' then
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
                    end)  
                end    
            end
        end)
    end 
end
init_shop()

return init_shop