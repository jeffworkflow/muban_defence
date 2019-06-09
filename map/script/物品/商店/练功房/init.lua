


require '物品.商店.练功房.练功师'
require '物品.商店.练功房.杀敌数兑换'

require '物品.商店.练功房.魔鬼的交易'

--注册魔兽事件 区域不可其他进入
for i =1 ,6 do 
    local p = ac.player(i)
    if p:is_player() then
        local ret = ac.rect.j_rect('lgfbh'..p.id)
        local minx, miny, maxx, maxy = ret:get()
        -- ret = ac.rect.create(minx-1500, miny-800, maxx+1500, maxy+800)
        ret = ac.rect.create(minx, miny, maxx, maxy)
        local region = ac.region.create(ret)
        region.owner = p
        region:event '区域-进入' (function(trg, hero)
            local player = hero:get_owner()
            --可能会掉线
            if player ==  region.owner or  player == ac.player(11) or player == ac.player(12) or player == ac.player(16) then 
            else
                hero:blink(ac.map.rects['主城'],true,false,true)
                player:sendMsg('不可进入')    
            end    
        end)    
    end   
end    
