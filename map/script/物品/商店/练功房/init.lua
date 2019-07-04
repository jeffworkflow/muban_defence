


require '物品.商店.练功房.练功师'
require '物品.商店.练功房.杀敌数兑换'

require '物品.商店.练功房.魔鬼的交易'

--注册魔兽事件 区域不可其他进入
for i =1 ,6 do 
    local p = ac.player(i)
    if p:is_player() then
        local ret = ac.rect.j_rect('lgfbh'..p.id)
        local region = ac.region.create(ret)
        region.owner = p
        -- p.tt_region = region
        region:event '区域-进入' (function(trg, hero, self)
            -- print('区域进入',hero:get_name(),hero:get_point(),self.owner,self:get())
            if region < hero:get_point()  then --不加区域判断，会有莫名其妙的问题，在练功房传送到其他地方，可能会出现在其他区域。
                local player = hero:get_owner()
                --可能会掉线
                if player ==  self.owner or  player.id>10 then 
                else
                    -- print('不可进入3',hero:get_name(),hero:get_point(),self:get()) 
                    hero:blink(ac.map.rects['主城'],true,false,true)
                    player:sendMsg('不可进入')   
                end   
            end     
        end)    
        -- region:event '区域-离开' (function(trg, hero, self)
        --     print('区域离开',hero:get_name(),self.owner) 
        -- end)    
    end   
end    
